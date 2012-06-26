//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.api;

/**
 * The Robotlegs log target contract
 */interface ILogTarget {

	function log(source : Dynamic, level : UInt, timestamp : Int, message : String, params : Array<Dynamic> = null) : Void;
}

