//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.localeventmap.impl;

import flash.events.IEventDispatcher;

class EventMapConfig {
	public var dispatcher(getDispatcher, never) : IEventDispatcher;
	public var eventString(getEventString, never) : String;
	public var listener(getListener, never) : Function;
	public var eventClass(getEventClass, never) : Class<Dynamic>;
	public var callback(getCallback, never) : Function;
	public var useCapture(getUseCapture, never) : Bool;

	/*============================================================================*/	/* Public Properties                                                          */	/*============================================================================*/	var _dispatcher : IEventDispatcher;
	public function getDispatcher() : IEventDispatcher {
		return _dispatcher;
	}

	var _eventString : String;
	public function getEventString() : String {
		return _eventString;
	}

	var _listener : Function;
	public function getListener() : Function {
		return _listener;
	}

	var _eventClass : Class<Dynamic>;
	public function getEventClass() : Class<Dynamic> {
		return _eventClass;
	}

	var _callback : Function;
	public function getCallback() : Function {
		return _callback;
	}

	var _useCapture : Bool;
	public function getUseCapture() : Bool {
		return _useCapture;
	}

	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(dispatcher : IEventDispatcher, eventString : String, listener : Function, eventClass : Class<Dynamic>, callback : Function, useCapture : Bool) {
		_dispatcher = dispatcher;
		_eventString = eventString;
		_listener = listener;
		_eventClass = eventClass;
		_callback = callback;
		_useCapture = useCapture;
	}

}

