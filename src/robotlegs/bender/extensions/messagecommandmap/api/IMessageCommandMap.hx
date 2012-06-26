//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.messagecommandmap.api;

import robotlegs.bender.extensions.commandmap.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandmap.dsl.ICommandMappingFinder;
import robotlegs.bender.extensions.commandmap.dsl.ICommandUnmapper;

interface IMessageCommandMap {

	function map(message : Dynamic, once : Bool = false) : ICommandMapper;
	function unmap(message : Dynamic) : ICommandUnmapper;
	function getMapping(message : Dynamic) : ICommandMappingFinder;
}

