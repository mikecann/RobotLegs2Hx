//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import robotlegs.bender.framework.api.ILogTarget;
import robotlegs.bender.framework.api.ILogger;
import robotlegs.bender.framework.api.LogLevel;

class LogManager implements ILogTarget {
	public var logLevel(getLogLevel, setLogLevel) : UInt;

	/*============================================================================*/	/* Public Properties                                                          */	/*============================================================================*/	var _logLevel : UInt;
	public function getLogLevel() : UInt {
		return _logLevel;
	}

	public function setLogLevel(value : UInt) : UInt {
		_logLevel = value;
		return value;
	}

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _targets : Vector<ILogTarget>;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function getLogger(source : Dynamic) : ILogger {
		return new Logger(source, this);
	}

	public function addLogTarget(target : ILogTarget) : Void {
		_targets.push(target);
	}

	public function log(source : Dynamic, level : UInt, timestamp : Int, message : String, params : Array<Dynamic> = null) : Void {
		if(level > _logLevel) 
			return;
		for(target in _targets/* AS3HX WARNING could not determine type for var: target exp: EIdent(_targets) type: Vector<ILogTarget>*/) {
			target.log(source, level, timestamp, message, params);
		}

	}


	public function new() {
		_logLevel = LogLevel.INFO;
		_targets = new Vector<ILogTarget>();
	}
}

