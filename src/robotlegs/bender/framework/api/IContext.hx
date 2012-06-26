//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.api;

import org.hamcrest.Matcher;
import org.swiftsuspenders.Injector;
import robotlegs.bender.framework.api.ILifecycle;
import robotlegs.bender.framework.api.ILogTarget;
import robotlegs.bender.framework.api.ILogger;

/**
 * The Robotlegs context contract
 */interface IContext {
	var initialized(getInitialized, never) : Bool;
	var destroyed(getDestroyed, never) : Bool;
	var injector(getInjector, never) : Injector;
	var lifecycle(getLifecycle, never) : ILifecycle;
	var logLevel(getLogLevel, setLogLevel) : UInt;

	// todo: move
		function getInitialized() : Bool;
	// todo: move
		function getDestroyed() : Bool;
	function getInjector() : Injector;
	function getLifecycle() : ILifecycle;
	function getLogLevel() : UInt;
	function setLogLevel(value : UInt) : UInt;
	function initialize() : Void;
	function destroy() : Void;
	function extend() : IContext;
	function configure() : IContext;
	function addConfigHandler(matcher : Matcher, handler : Function) : IContext;
	function getLogger(source : Dynamic) : ILogger;
	function addLogTarget(target : ILogTarget) : IContext;
}

