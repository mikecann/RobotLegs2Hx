//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import robotlegs.bender.framework.api.ILogTarget;
import robotlegs.bender.framework.api.ILogger;

class Logger implements ILogger {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _source : Dynamic;
	var _target : ILogTarget;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(source : Dynamic, target : ILogTarget) {
		_source = source;
		_target = target;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function debug(message : Dynamic, params : Array<Dynamic> = null) : Void {
		_target.log(_source, 32, Math.round(haxe.Timer.getStamp() / 1000)(), message, params);
	}

	public function info(message : Dynamic, params : Array<Dynamic> = null) : Void {
		_target.log(_source, 16, Math.round(haxe.Timer.getStamp() / 1000)(), message, params);
	}

	public function warn(message : Dynamic, params : Array<Dynamic> = null) : Void {
		_target.log(_source, 8, Math.round(haxe.Timer.getStamp() / 1000)(), message, params);
	}

	public function error(message : Dynamic, params : Array<Dynamic> = null) : Void {
		_target.log(_source, 4, Math.round(haxe.Timer.getStamp() / 1000)(), message, params);
	}

	public function fatal(message : Dynamic, params : Array<Dynamic> = null) : Void {
		_target.log(_source, 2, Math.round(haxe.Timer.getStamp() / 1000)(), message, params);
	}

}

