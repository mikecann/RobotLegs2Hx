//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.api;

import robotlegs.bender.extensions.viewmanager.api.IViewHandler;

interface IMediatorViewHandler implements IViewHandler {

	function addMapping(mapping : IMediatorMapping) : Void;
	function removeMapping(mapping : IMediatorMapping) : Void;
	function handleItem(item : Dynamic, type : Class<Dynamic>) : Void;
}

