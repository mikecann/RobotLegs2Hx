//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.commandmap.impl;

import robotlegs.bender.extensions.commandmap.api.ICommandMapping;
import robotlegs.bender.extensions.commandmap.dsl.ICommandMappingConfig;

class CommandMapping implements ICommandMapping, implements ICommandMappingConfig {
	public var commandClass(getCommandClass, never) : Class<Dynamic>;
	public var guards(getGuards, never) : Array<Dynamic>;
	public var hooks(getHooks, never) : Array<Dynamic>;

	/*============================================================================*/	/* Public Properties                                                          */	/*============================================================================*/	var _commandClass : Class<Dynamic>;
	public function getCommandClass() : Class<Dynamic> {
		return _commandClass;
	}

	var _guards : Array<Dynamic>;
	public function getGuards() : Array<Dynamic> {
		return _guards;
	}

	var _hooks : Array<Dynamic>;
	public function getHooks() : Array<Dynamic> {
		return _hooks;
	}

	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(commandClass : Class<Dynamic>) {
		_guards = [];
		_hooks = [];
		_commandClass = commandClass;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function withGuards() : ICommandMappingConfig {
		_guards = _guards.concat.apply(null, guards);
		return this;
	}

	public function withHooks() : ICommandMappingConfig {
		_hooks = _hooks.concat.apply(null, hooks);
		return this;
	}

}

