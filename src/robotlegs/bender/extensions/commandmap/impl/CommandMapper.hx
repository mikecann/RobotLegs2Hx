//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.commandmap.impl;

import flash.utils.Dictionary;
import robotlegs.bender.extensions.commandmap.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandmap.api.ICommandMapping;
import robotlegs.bender.extensions.commandmap.dsl.ICommandMappingConfig;
import robotlegs.bender.extensions.commandmap.dsl.ICommandMappingFinder;
import robotlegs.bender.extensions.commandmap.api.ICommandTrigger;
import robotlegs.bender.extensions.commandmap.dsl.ICommandUnmapper;

class CommandMapper implements ICommandMapper, implements ICommandMappingFinder, implements ICommandUnmapper {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _mappings : Dictionary;
	var _trigger : ICommandTrigger;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(trigger : ICommandTrigger) {
		_mappings = new Dictionary();
		_trigger = trigger;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function toCommand(commandClass : Class<Dynamic>) : ICommandMappingConfig {
		return Reflect.field(_mappings, Std.string(commandClass)) ||= createMapping(commandClass);
	}

	public function forCommand(commandClass : Class<Dynamic>) : ICommandMappingConfig {
		return Reflect.field(_mappings, Std.string(commandClass));
	}

	public function fromCommand(commandClass : Class<Dynamic>) : Void {
		var mapping : ICommandMapping = Reflect.field(_mappings, Std.string(commandClass));
		mapping && _trigger.removeMapping(mapping);
		This is an intentional compilation error. See the README for handling the delete keyword
		delete Reflect.field(_mappings, Std.string(commandClass));
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function createMapping(commandClass : Class<Dynamic>) : CommandMapping {
		var mapping : CommandMapping = new CommandMapping(commandClass);
		_trigger.addMapping(mapping);
		return mapping;
	}

}

