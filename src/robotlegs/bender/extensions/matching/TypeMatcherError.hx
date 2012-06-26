//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.matching;

// TODO: should be in API
class TypeMatcherError extends Error {

	/*============================================================================*/	/* Public Static Properties                                                   */	/*============================================================================*/	static public inline var EMPTY_MATCHER : String = "An empty matcher will create a filter which matches nothing. You should specify at least one condition for the filter.";
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(message : String) {
		super(message);
	}

}

