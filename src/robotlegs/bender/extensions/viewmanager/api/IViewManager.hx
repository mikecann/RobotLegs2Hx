//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager.api;

import flash.display.DisplayObjectContainer;

interface IViewManager {

	function addContainer(container : DisplayObjectContainer) : Void;
	function removeContainer(container : DisplayObjectContainer) : Void;
	function addViewHandler(handler : IViewHandler) : Void;
	function removeViewHandler(handler : IViewHandler) : Void;
	function removeAllHandlers() : Void;
}

