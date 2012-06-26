//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.modularity.events;

import flash.events.Event;
import robotlegs.bender.framework.api.IContext;

class ModularContextEvent extends Event {
	public var context(getContext, never) : IContext;

	/*============================================================================*/	/* Public Static Properties                                                   */	/*============================================================================*/	static public inline var CONTEXT_ADD : String = "contextAdd";
	static public inline var CONTEXT_REMOVE : String = "contextRemove";
	/*============================================================================*/	/* Public Properties                                                          */	/*============================================================================*/	var _context : IContext;
	public function getContext() : IContext {
		return _context;
	}

	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(type : String, context : IContext) {
		super(type, true, true);
		_context = context;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	override public function clone() : Event {
		return new ModularContextEvent(type, context);
	}

	override public function toString() : String {
		return formatToString("ModularContextEvent", "context");
	}

}

