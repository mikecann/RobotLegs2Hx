//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.api;

import flash.events.Event;

/**
 * Robotlegs object lifecycle event
 */class LifecycleEvent extends Event {

	/*============================================================================*/	/* Public Static Properties                                                   */	/*============================================================================*/	static public inline var ERROR : String = "error";
	static public inline var PRE_INITIALIZE : String = "preInitialize";
	static public inline var INITIALIZE : String = "initialize";
	static public inline var POST_INITIALIZE : String = "postInitialize";
	static public inline var PRE_SUSPEND : String = "preSuspend";
	static public inline var SUSPEND : String = "suspend";
	static public inline var POST_SUSPEND : String = "postSuspend";
	static public inline var PRE_RESUME : String = "preResume";
	static public inline var RESUME : String = "resume";
	static public inline var POST_RESUME : String = "postResume";
	static public inline var PRE_DESTROY : String = "preDestroy";
	static public inline var DESTROY : String = "destroy";
	static public inline var POST_DESTROY : String = "postDestroy";
	/*============================================================================*/	/* Public Properties                                                          */	/*============================================================================*/	public var error : Error;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	function new(type : String) {
		super(type);
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	override public function clone() : Event {
		var event : LifecycleEvent = new LifecycleEvent(type);
		event.error = error;
		return event;
	}

}

