//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.api;

/**
 * Robotlegs object lifecycle state
 */class LifecycleState {

	/*============================================================================*/	/* Public Static Properties                                                   */	/*============================================================================*/	static public inline var UNINITIALIZED : String = "uninitialized";
	static public inline var INITIALIZING : String = "initializing";
	static public inline var ACTIVE : String = "active";
	static public inline var SUSPENDING : String = "suspending";
	static public inline var SUSPENDED : String = "suspended";
	static public inline var RESUMING : String = "resuming";
	static public inline var DESTROYING : String = "destroying";
	static public inline var DESTROYED : String = "destroyed";

	public function new() {
	}
}

