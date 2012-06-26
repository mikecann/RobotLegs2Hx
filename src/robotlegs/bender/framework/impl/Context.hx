//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import org.hamcrest.Matcher;
import org.swiftsuspenders.Injector;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.ILifecycle;
import robotlegs.bender.framework.api.LifecycleState;
import robotlegs.bender.framework.api.ILogTarget;
import robotlegs.bender.framework.api.ILogger;

class Context implements IContext {
	public var injector(getInjector, never) : Injector;
	public var logLevel(getLogLevel, setLogLevel) : UInt;
	public var lifecycle(getLifecycle, never) : ILifecycle;
	public var initialized(getInitialized, never) : Bool;
	public var destroyed(getDestroyed, never) : Bool;

	/*============================================================================*/	/* Public Properties                                                          */	/*============================================================================*/	var _injector : Injector;
	public function getInjector() : Injector {
		return _injector;
	}

	public function getLogLevel() : UInt {
		return _logManager.logLevel;
	}

	public function setLogLevel(value : UInt) : UInt {
		_logManager.logLevel = value;
		return value;
	}

	var _lifecycle : Lifecycle;
	public function getLifecycle() : ILifecycle {
		return _lifecycle;
	}

	// todo: move this into lifecycle
		public function getInitialized() : Bool {
		return _lifecycle.state != LifecycleState.UNINITIALIZED && _lifecycle.state != LifecycleState.INITIALIZING;
	}

	// todo: move this into lifecycle
		public function getDestroyed() : Bool {
		return _lifecycle.state == LifecycleState.DESTROYED;
	}

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _uid : String;
	var _logManager : LogManager;
	var _configManager : ConfigManager;
	var _extensionInstaller : ExtensionInstaller;
	var _logger : ILogger;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new() {
		_injector = new Injector();
		_uid = UID.create(Context);
		_logManager = new LogManager();
		_injector.map(Injector).toValue(_injector);
		_injector.map(IContext).toValue(this);
		_logger = _logManager.getLogger(this);
		_lifecycle = new Lifecycle(this);
		_configManager = new ConfigManager(this);
		_extensionInstaller = new ExtensionInstaller(this);
		_lifecycle.whenInitializing(_configManager.initialize);
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function initialize() : Void {
		_logger.info("Initializing...");
		_lifecycle.initialize(handleInitializeComplete);
	}

	public function destroy() : Void {
		_logger.info("Destroying...");
		_lifecycle.destroy(handleDestroyComplete);
	}

	public function extend() : IContext {
		for(extension in extensions/* AS3HX WARNING could not determine type for var: extension exp: EIdent(extensions) type: null*/) {
			_extensionInstaller.install(extension);
		}

		return this;
	}

	public function configure() : IContext {
		for(config in configs/* AS3HX WARNING could not determine type for var: config exp: EIdent(configs) type: null*/) {
			_configManager.addConfig(config);
		}

		return this;
	}

	public function addConfigHandler(matcher : Matcher, handler : Function) : IContext {
		_configManager.addConfigHandler(matcher, handler);
		return this;
	}

	public function getLogger(source : Dynamic) : ILogger {
		return _logManager.getLogger(source);
	}

	public function addLogTarget(target : ILogTarget) : IContext {
		_logManager.addLogTarget(target);
		return this;
	}

	public function toString() : String {
		return _uid;
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function handleInitializeComplete(error : Dynamic) : Void {
		error && handleError(error);
		_logger.info("Initialize complete");
	}

	function handleDestroyComplete(error : Dynamic) : Void {
		error && handleError(error);
		_logger.info("Destroy complete");
	}

	function handleError(error : Dynamic) : Void {
		_logger.error(error);
		if(Std.is(error, Error))  {
			throw try cast(error, Error) catch(e:Dynamic) null;
		}

		else if(error)  {
			throw new Error(error);
		}
	}

}

