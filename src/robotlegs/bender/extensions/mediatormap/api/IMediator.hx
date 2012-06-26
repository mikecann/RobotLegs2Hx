//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.api;

interface IMediator {
	var viewComponent(never, setViewComponent) : Dynamic;

	function setViewComponent(view : Dynamic) : Dynamic;
	function initialize() : Void;
	function destroy() : Void;
}

