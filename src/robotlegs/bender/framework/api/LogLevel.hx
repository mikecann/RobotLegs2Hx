//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.api;

/**
 * Robotlegs log level
 */class LogLevel {

	/*============================================================================*/	/* Public Static Properties                                                   */	/*============================================================================*/	static public inline var FATAL : UInt = 2;
	static public inline var ERROR : UInt = 4;
	static public inline var WARN : UInt = 8;
	static public inline var INFO : UInt = 16;
	static public inline var DEBUG : UInt = 32;
	static public inline var NAME : Array<Dynamic> = [0, 0, "FATAL", // 2
	0, "ERROR", // 4
	0, 0, 0, "WARN", // 8
	0, 0, 0, 0, 0, 0, 0, "INFO", // 16
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "DEBUG"];
	// 32
	
	public function new() {
	}
}

