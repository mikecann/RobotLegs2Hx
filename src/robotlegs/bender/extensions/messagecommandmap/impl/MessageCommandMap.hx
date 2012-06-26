//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.messagecommandmap.impl;

import flash.utils.Dictionary;
import org.swiftsuspenders.Injector;
import robotlegs.bender.framework.api.IMessageDispatcher;
import robotlegs.bender.extensions.commandmap.api.ICommandMap;
import robotlegs.bender.extensions.commandmap.api.ICommandTrigger;
import robotlegs.bender.extensions.commandmap.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandmap.dsl.ICommandMappingFinder;
import robotlegs.bender.extensions.commandmap.dsl.ICommandUnmapper;
import robotlegs.bender.extensions.messagecommandmap.api.IMessageCommandMap;

class MessageCommandMap implements IMessageCommandMap {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _triggers : Dictionary;
	var _injector : Injector;
	var _dispatcher : IMessageDispatcher;
	var _commandMap : ICommandMap;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(injector : Injector, dispatcher : IMessageDispatcher, commandMap : ICommandMap) {
		_triggers = new Dictionary();
		_injector = injector;
		_dispatcher = dispatcher;
		_commandMap = commandMap;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function map(message : Dynamic, once : Bool = false) : ICommandMapper {
		var trigger : ICommandTrigger = Reflect.field(_triggers, Std.string(message)) ||= createTrigger(message, once);
		return _commandMap.map(trigger);
	}

	public function unmap(message : Dynamic) : ICommandUnmapper {
		return _commandMap.unmap(getTrigger(message));
	}

	public function getMapping(message : Dynamic) : ICommandMappingFinder {
		return _commandMap.getMapping(getTrigger(message));
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function createTrigger(message : Dynamic, once : Bool = false) : ICommandTrigger {
		return new MessageCommandTrigger(_injector, _dispatcher, message, once);
	}

	function getTrigger(message : Dynamic) : ICommandTrigger {
		return Reflect.field(_triggers, Std.string(message));
	}

}

