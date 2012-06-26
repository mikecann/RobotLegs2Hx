//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager.impl;

import flash.display.DisplayObject;
import flash.events.Event;

class ConfigureViewEvent extends Event {
	public var view(getView, never) : DisplayObject;

	static public inline var CONFIGURE_VIEW : String = "configureView";
	var _view : DisplayObject;
	public function getView() : DisplayObject {
		return _view;
	}

	public function new(type : String, view : DisplayObject = null) {
		super(type, true, true);
		_view = view;
	}

	override public function clone() : Event {
		return new ConfigureViewEvent(type, _view);
	}

}

