//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.eventcommandmap.api;

import robotlegs.bender.extensions.commandmap.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandmap.dsl.ICommandMappingFinder;
import robotlegs.bender.extensions.commandmap.dsl.ICommandUnmapper;

interface IEventCommandMap {

	function map(type : String, eventClass : Class<Dynamic> = null, once : Bool = false) : ICommandMapper;
	function unmap(type : String, eventClass : Class<Dynamic> = null) : ICommandUnmapper;
	function getMapping(type : String, eventClass : Class<Dynamic> = null) : ICommandMappingFinder;
}

