//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.bundles.mvcs;

import flash.events.Event;
import flash.events.IEventDispatcher;
import robotlegs.bender.extensions.localeventmap.api.IEventMap;
import robotlegs.bender.extensions.mediatormap.api.IMediator;

/**
 * Classic Robotlegs mediator implementation
 *
 * <p>Override initialize and destroy to hook into the mediator lifecycle.</p>
 */class Mediator implements IMediator {
	public var viewComponent(never, setViewComponent) : Dynamic;

	/*============================================================================*//* Public Properties                                                          *//*============================================================================*/@:meta(Inject())
	public var eventMap : IEventMap;
	@:meta(Inject())
	public var eventDispatcher : IEventDispatcher;
	var _viewComponent : Dynamic;
	public function setViewComponent(view : Dynamic) : Dynamic {
		_viewComponent = view;
		return view;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function initialize() : Void {
	}

	public function destroy() : Void {
		eventMap.unmapListeners();
	}

	/*============================================================================*/	/* Protected Functions                                                        */	/*============================================================================*/	function addViewListener(eventString : String, listener : Function, eventClass : Class<Dynamic> = null) : Void {
		eventMap.mapListener(cast((_viewComponent), IEventDispatcher), eventString, listener, eventClass);
	}

	function addContextListener(eventString : String, listener : Function, eventClass : Class<Dynamic> = null) : Void {
		eventMap.mapListener(eventDispatcher, eventString, listener, eventClass);
	}

	function removeViewListener(eventString : String, listener : Function, eventClass : Class<Dynamic> = null) : Void {
		eventMap.unmapListener(cast((_viewComponent), IEventDispatcher), eventString, listener, eventClass);
	}

	function removeContextListener(eventString : String, listener : Function, eventClass : Class<Dynamic> = null) : Void {
		eventMap.unmapListener(eventDispatcher, eventString, listener, eventClass);
	}

	function dispatch(event : Event) : Void {
		if(eventDispatcher.hasEventListener(event.type)) 
			eventDispatcher.dispatchEvent(event);
	}


	public function new() {
	}
}

