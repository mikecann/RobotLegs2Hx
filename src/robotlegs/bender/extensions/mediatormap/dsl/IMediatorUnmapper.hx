//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.dsl;

interface IMediatorUnmapper {

	function fromMediator(mediatorClass : Class<Dynamic>) : Void;
	function fromMediators() : Void;
}

