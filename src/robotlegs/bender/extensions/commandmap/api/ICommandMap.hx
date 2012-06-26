//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.commandmap.api;

import robotlegs.bender.extensions.commandmap.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandmap.dsl.ICommandMappingFinder;
import robotlegs.bender.extensions.commandmap.dsl.ICommandUnmapper;

interface ICommandMap {

	function map(trigger : ICommandTrigger) : ICommandMapper;
	function unmap(trigger : ICommandTrigger) : ICommandUnmapper;
	function getMapping(trigger : ICommandTrigger) : ICommandMappingFinder;
}

