//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.eventcommandmap.impl;

import flash.events.IEventDispatcher;
import flash.utils.Dictionary;
import org.swiftsuspenders.Injector;
import robotlegs.bender.extensions.commandmap.api.ICommandMap;
import robotlegs.bender.extensions.commandmap.api.ICommandTrigger;
import robotlegs.bender.extensions.commandmap.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandmap.dsl.ICommandMappingFinder;
import robotlegs.bender.extensions.commandmap.dsl.ICommandUnmapper;
import robotlegs.bender.extensions.eventcommandmap.api.IEventCommandMap;

class EventCommandMap implements IEventCommandMap {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _triggers : Dictionary;
	var _injector : Injector;
	var _dispatcher : IEventDispatcher;
	var _commandMap : ICommandMap;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(injector : Injector, dispatcher : IEventDispatcher, commandMap : ICommandMap) {
		_triggers = new Dictionary();
		_injector = injector;
		_dispatcher = dispatcher;
		_commandMap = commandMap;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function map(type : String, eventClass : Class<Dynamic> = null, once : Bool = false) : ICommandMapper {
		var trigger : ICommandTrigger = _triggers[type + eventClass] ||= createTrigger(type, eventClass, once);
		return _commandMap.map(trigger);
	}

	public function unmap(type : String, eventClass : Class<Dynamic> = null) : ICommandUnmapper {
		return _commandMap.unmap(getTrigger(type, eventClass));
	}

	public function getMapping(type : String, eventClass : Class<Dynamic> = null) : ICommandMappingFinder {
		return _commandMap.getMapping(getTrigger(type, eventClass));
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function createTrigger(type : String, eventClass : Class<Dynamic> = null, once : Bool = false) : ICommandTrigger {
		return new EventCommandTrigger(_injector, _dispatcher, type, eventClass, once);
	}

	function getTrigger(type : String, eventClass : Class<Dynamic> = null) : ICommandTrigger {
		return _triggers[type + eventClass];
	}

}

