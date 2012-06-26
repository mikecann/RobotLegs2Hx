//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.api;

import flash.events.IEventDispatcher;

@:meta(Event(name="mediatorCreate",type="robotlegs.bender.extensions.mediatorMap.api.MediatorFactoryEvent"))
@:meta(Event(name="mediatorRemove",type="robotlegs.bender.extensions.mediatorMap.api.MediatorFactoryEvent"))
interface IMediatorFactory implements IEventDispatcher {

	function getMediator(view : Dynamic, mapping : IMediatorMapping) : Dynamic;
	function createMediators(view : Dynamic, type : Class<Dynamic>, mappings : Array<Dynamic>) : Array<Dynamic>;
	function removeMediators(view : Dynamic) : Void;
}

