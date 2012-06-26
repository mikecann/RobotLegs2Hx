//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import org.hamcrest.Matcher;
import org.hamcrest.Matcher;

/**
 * Robotlegs object processor
 */class ObjectProcessor {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _handlers : Array<Dynamic>;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	/**
	 * Add a handler to process objects that match a given matcher.
	 * @param matcher The matcher
	 * @param handler The handler function
	 */	public function addObjectHandler(matcher : Matcher, handler : Function) : Void {
		_handlers.push(new ObjectHandler(matcher, handler));
	}

	/**
	 * Process an object by running it through registered handlers
	 * @param object The object instance to process.
	 */	public function processObject(object : Dynamic) : Void {
		for(handler in _handlers/* AS3HX WARNING could not determine type for var: handler exp: EIdent(_handlers) type: Array<Dynamic>*/) {
			handler.handle(object);
		}

	}


	public function new() {
		_handlers = [];
	}
}

class ObjectHandler {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _matcher : Matcher;
	var _handler : Function;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(matcher : Matcher, handler : Function) {
		_matcher = matcher;
		_handler = handler;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function handle(object : Dynamic) : Void {
		_matcher.matches(object) && _handler(object);
	}

}

