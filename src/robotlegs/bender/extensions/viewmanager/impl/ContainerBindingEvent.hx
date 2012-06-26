//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager.impl;

import flash.events.Event;

class ContainerBindingEvent extends Event {

	/*============================================================================*/	/* Public Static Properties                                                   */	/*============================================================================*/	static public inline var BINDING_EMPTY : String = "bindingEmpty";
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(type : String) {
		super(type);
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	override public function clone() : Event {
		return new ContainerBindingEvent(type);
	}

}

