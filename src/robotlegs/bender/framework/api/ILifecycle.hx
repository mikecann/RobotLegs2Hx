//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.api;

import flash.events.IEventDispatcher;

/**
 * The Robotlegs lifecycle contract
 */interface ILifecycle implements IEventDispatcher {
	var state(getState, never) : String;
	var target(getTarget, never) : Dynamic;

	function getState() : String;
	function getTarget() : Dynamic;
	function initialize(callback : Function = null) : Void;
	function suspend(callback : Function = null) : Void;
	function resume(callback : Function = null) : Void;
	function destroy(callback : Function = null) : Void;
	function beforeInitializing(handler : Function) : ILifecycle;
	function whenInitializing(handler : Function) : ILifecycle;
	function afterInitializing(handler : Function) : ILifecycle;
	function beforeSuspending(handler : Function) : ILifecycle;
	function whenSuspending(handler : Function) : ILifecycle;
	function afterSuspending(handler : Function) : ILifecycle;
	function beforeResuming(handler : Function) : ILifecycle;
	function whenResuming(handler : Function) : ILifecycle;
	function afterResuming(handler : Function) : ILifecycle;
	function beforeDestroying(handler : Function) : ILifecycle;
	function whenDestroying(handler : Function) : ILifecycle;
	function afterDestroying(handler : Function) : ILifecycle;
}

