//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.commandmap.impl;

import flash.utils.Dictionary;
import robotlegs.bender.extensions.commandmap.api.ICommandMap;
import robotlegs.bender.extensions.commandmap.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandmap.dsl.ICommandMappingFinder;
import robotlegs.bender.extensions.commandmap.api.ICommandTrigger;
import robotlegs.bender.extensions.commandmap.dsl.ICommandUnmapper;

class CommandMap implements ICommandMap {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _mappers : Dictionary;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function map(trigger : ICommandTrigger) : ICommandMapper {
		return Reflect.field(_mappers, Std.string(trigger)) ||= new CommandMapper(trigger);
	}

	public function unmap(trigger : ICommandTrigger) : ICommandUnmapper {
		return Reflect.field(_mappers, Std.string(trigger));
	}

	public function getMapping(trigger : ICommandTrigger) : ICommandMappingFinder {
		return Reflect.field(_mappers, Std.string(trigger));
	}


	public function new() {
		_mappers = new Dictionary();
	}
}

