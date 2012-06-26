//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

class UID {

	/*============================================================================*/	/* Private Static Properties                                                  */	/*============================================================================*/	static var i : UInt;
	/*============================================================================*/	/* Public Static Functions                                                    */	/*============================================================================*/	static public function create(source : Dynamic = null) : String {
		if(Std.is(source, Class)) 
			source = Type.getClassName(source).split("::").pop();
		return ((source) ? source + "-" : "") + (i++).toString(16) + "-" + (Math.random() * 255).toString(16);
	}


	public function new() {
	}
}

