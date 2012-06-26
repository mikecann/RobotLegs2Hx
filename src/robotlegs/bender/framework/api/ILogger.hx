//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.api;

/**
 * The Robotlegs logger contract
 */interface ILogger {

	function debug(message : Dynamic, params : Array<Dynamic> = null) : Void;
	function info(message : Dynamic, params : Array<Dynamic> = null) : Void;
	function warn(message : Dynamic, params : Array<Dynamic> = null) : Void;
	function error(message : Dynamic, params : Array<Dynamic> = null) : Void;
	function fatal(message : Dynamic, params : Array<Dynamic> = null) : Void;
}

