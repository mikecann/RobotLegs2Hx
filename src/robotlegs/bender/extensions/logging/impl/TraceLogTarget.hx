//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.logging.impl;

import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.ILogTarget;
import robotlegs.bender.framework.api.LogLevel;

class TraceLogTarget implements ILogTarget {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _context : IContext;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(context : IContext) {
		_context = context;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function log(source : Dynamic, level : UInt, timestamp : Int, message : String, params : Array<Dynamic> = null) : Void {
		trace(timestamp + " " + LogLevel.NAME[level] + " " + _context + " " + source + " - " + parseMessage(message, params));
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function parseMessage(message : String, params : Array<Dynamic>) : String {
		if(params != null)  {
			var numParams : Int = params.length;
			var i : Int = 0;
			while(i < numParams) {
				message = message.split("{" + i + "}").join(params[i]);
				++i;
			}
		}
		return message;
	}

}

