//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.eventcommandmap.impl;

import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.utils.DescribeType;
import org.swiftsuspenders.Injector;
import robotlegs.bender.extensions.commandmap.api.ICommandMapping;
import robotlegs.bender.extensions.commandmap.api.ICommandTrigger;
import robotlegs.bender.framework.impl.GuardsApprove;
import robotlegs.bender.framework.impl.ApplyHooks;

class EventCommandTrigger implements ICommandTrigger {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _mappings : Vector<ICommandMapping>;
	var _injector : Injector;
	var _dispatcher : IEventDispatcher;
	var _type : String;
	var _eventClass : Class<Dynamic>;
	var _once : Bool;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(injector : Injector, dispatcher : IEventDispatcher, type : String, eventClass : Class<Dynamic> = null, once : Bool = false) {
		_mappings = new Vector<ICommandMapping>();
		_injector = injector.createChildInjector();
		_dispatcher = dispatcher;
		_type = type;
		_eventClass = eventClass;
		_once = once;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function addMapping(mapping : ICommandMapping) : Void {
		verifyCommandClass(mapping);
		_mappings.push(mapping);
		if(_mappings.length == 1) 
			addListener();
	}

	public function removeMapping(mapping : ICommandMapping) : Void {
		var index : Int = _mappings.indexOf(mapping);
		if(index != -1)  {
			_mappings.splice(index, 1);
			if(_mappings.length == 0) 
				removeListener();
		}
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function verifyCommandClass(mapping : ICommandMapping) : Void {
	}

	function addListener() : Void {
		_dispatcher.addEventListener(_type, handleEvent);
	}

	function removeListener() : Void {
		_dispatcher.removeEventListener(_type, handleEvent);
	}

	function handleEvent(event : Event) : Void {
		var eventConstructor : Class<Dynamic> = Reflect.field(event, "constructor");
		// check strongly-typed event (if specified)
		if(_eventClass != null && eventConstructor != _eventClass) 
			return;
		// map loosely typed event for injection
		_injector.map(Event).toValue(event);
		// map the strongly typed event for injection
		if(eventConstructor != Event) 
			_injector.map(_eventClass || eventConstructor).toValue(event);
		// run past the guards and hooks, and execute
		var mappings : Vector<ICommandMapping> = _mappings.concat();
		for(mapping in mappings/* AS3HX WARNING could not determine type for var: mapping exp: EIdent(mappings) type: Vector<ICommandMapping>*/) {
			if(guardsApprove(mapping.guards, _injector))  {
				_once && removeMapping(mapping);
				_injector.map(mapping.commandClass).asSingleton();
				var command : Dynamic = _injector.getInstance(mapping.commandClass);
				applyHooks(mapping.hooks, _injector);
				_injector.unmap(mapping.commandClass);
				command.execute();
			}
		}

		// unmap the loosely typed event
		_injector.unmap(Event);
		// unmap the strongly typed event
		if(eventConstructor != Event) 
			_injector.unmap(_eventClass || eventConstructor);
	}

}

