//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.eventdispatcher;

import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IContextExtension;

/**
 * This extension maps an IEventDispatcher into a context's injector.
 */class EventDispatcherExtension implements IContextExtension {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _eventDispatcher : IEventDispatcher;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(eventDispatcher : IEventDispatcher = null) {
		_eventDispatcher = eventDispatcher || new EventDispatcher();
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function extend(context : IContext) : Void {
		context.injector.map(IEventDispatcher).toValue(_eventDispatcher);
	}

}

