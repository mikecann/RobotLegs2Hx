//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.localeventmap.impl;

import flash.events.Event;
import flash.events.IEventDispatcher;
import robotlegs.bender.extensions.localeventmap.api.IEventMap;

/**
 * An abstract <code>IEventMap</code> implementation
 */// TODO: review
class EventMap implements IEventMap {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	/**
	 * The <code>IEventDispatcher</code>
	 */	var _eventDispatcher : IEventDispatcher;
	/**
	 * @private
	 */	var _listeners : Vector<EventMapConfig>;
	/**
	 * @private
	 */	var _suspendedListeners : Vector<EventMapConfig>;
	/**
	 * @private
	 */	var _suspended : Bool;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	/**
	 * Creates a new <code>EventMap</code> object
	 *
	 * @param eventDispatcher An <code>IEventDispatcher</code> to treat as a bus
	 */	public function new(eventDispatcher : IEventDispatcher) {
		_listeners = new Vector<EventMapConfig>();
		_suspendedListeners = new Vector<EventMapConfig>();
		_suspended = false;
		_eventDispatcher = eventDispatcher;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	/**
	 * The same as calling <code>addEventListener</code> directly on the <code>IEventDispatcher</code>,
	 * but keeps a list of listeners for easy (usually automatic) removal.
	 *
	 * @param dispatcher The <code>IEventDispatcher</code> to listen to
	 * @param eventString The <code>Event</code> type to listen for
	 * @param listener The <code>Event</code> handler
	 * @param eventClass Optional Event class for a stronger mapping. Defaults to <code>flash.events.Event</code>.
	 * @param useCapture
	 * @param priority
	 * @param useWeakReference
	 */	public function mapListener(dispatcher : IEventDispatcher, eventString : String, listener : Function, eventClass : Class<Dynamic> = null, useCapture : Bool = false, priority : Int = 0, useWeakReference : Bool = true) : Void {
		eventClass ||= Event;
		var currentListeners : Vector<EventMapConfig> = (_suspended) ? _suspendedListeners : _listeners;
		var eventConfig : EventMapConfig;
		var i : Int = currentListeners.length;
		while(i--) {
			eventConfig = currentListeners[i];
			if(eventConfig.dispatcher == dispatcher && eventConfig.eventString == eventString && eventConfig.listener == listener && eventConfig.useCapture == useCapture && eventConfig.eventClass == eventClass)  {
				return;
			}
		}

		var callback : Function;
		if(eventClass != Event)  {
			callback = function(event : Event) : Void {
				routeEventToListener(event, listener, eventClass);
			}
;
		}

		else  {
			callback = listener;
		}

		eventConfig = new EventMapConfig(dispatcher, eventString, listener, eventClass, callback, useCapture);
		currentListeners.push(eventConfig);
		if(!_suspended)  {
			dispatcher.addEventListener(eventString, callback, useCapture, priority, useWeakReference);
		}
	}

	/**
	 * The same as calling <code>removeEventListener</code> directly on the <code>IEventDispatcher</code>,
	 * but updates our local list of listeners.
	 *
	 * @param dispatcher The <code>IEventDispatcher</code>
	 * @param eventString The <code>Event</code> type
	 * @param listener The <code>Event</code> handler
	 * @param eventClass Optional Event class for a stronger mapping. Defaults to <code>flash.events.Event</code>.
	 * @param useCapture
	 */	public function unmapListener(dispatcher : IEventDispatcher, eventString : String, listener : Function, eventClass : Class<Dynamic> = null, useCapture : Bool = false) : Void {
		eventClass ||= Event;
		var eventConfig : EventMapConfig;
		var currentListeners : Vector<EventMapConfig> = (_suspended) ? _suspendedListeners : _listeners;
		var i : Int = currentListeners.length;
		while(i--) {
			eventConfig = currentListeners[i];
			// todo: move test to EventMapConfig
			if(eventConfig.dispatcher == dispatcher && eventConfig.eventString == eventString && eventConfig.listener == listener && eventConfig.useCapture == useCapture && eventConfig.eventClass == eventClass)  {
				if(!_suspended)  {
					dispatcher.removeEventListener(eventString, eventConfig.callback, useCapture);
				}
				currentListeners.splice(i, 1);
				return;
			}
;
		}

	}

	/**
	 * Removes all listeners registered through <code>mapListener</code>
	 */	public function unmapListeners() : Void {
		var currentListeners : Vector<EventMapConfig> = (_suspended) ? _suspendedListeners : _listeners;
		var eventConfig : EventMapConfig;
		var dispatcher : IEventDispatcher;
		while(eventConfig = currentListeners.pop()) {
			if(!_suspended)  {
				dispatcher = eventConfig.dispatcher;
				dispatcher.removeEventListener(eventConfig.eventString, eventConfig.callback, eventConfig.useCapture);
			}
		}

	}

	public function suspend() : Void {
		if(_suspended) 
			return;
		_suspended = true;
		var eventConfig : EventMapConfig;
		var dispatcher : IEventDispatcher;
		while(eventConfig = _listeners.pop()) {
			dispatcher = eventConfig.dispatcher;
			dispatcher.removeEventListener(eventConfig.eventString, eventConfig.callback, eventConfig.useCapture);
			_suspendedListeners.push(eventConfig);
		}

	}

	public function resume() : Void {
		if(!_suspended) 
			return;
		_suspended = false;
		var eventConfig : EventMapConfig;
		var dispatcher : IEventDispatcher;
		while(eventConfig = _suspendedListeners.pop()) {
			dispatcher = eventConfig.dispatcher;
			dispatcher.addEventListener(eventConfig.eventString, eventConfig.callback, eventConfig.useCapture);
			_listeners.push(eventConfig);
		}

	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	/**
	 * Event Handler
	 *
	 * @param event The <code>Event</code>
	 * @param listener
	 * @param originalEventClass
	 */	function routeEventToListener(event : Event, listener : Function, originalEventClass : Class<Dynamic>) : Void {
		if(Std.is(event, originalEventClass))  {
			listener(event);
		}
	}

}

