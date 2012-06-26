//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import robotlegs.bender.framework.api.LifecycleEvent;

class LifecycleTransition {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _fromStates : Vector<String>;
	var _dispatcher : MessageDispatcher;
	var _callbacks : Array<Dynamic>;
	var _name : String;
	var _lifecycle : Lifecycle;
	var _transitionState : String;
	var _finalState : String;
	var _preTransitionEvent : String;
	var _transitionEvent : String;
	var _postTransitionEvent : String;
	var _reverse : Bool;
	var _locked : Bool;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(name : String, lifecycle : Lifecycle) {
		_fromStates = new Vector<String>();
		_dispatcher = new MessageDispatcher();
		_callbacks = [];
		_name = name;
		_lifecycle = lifecycle;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function fromStates() : LifecycleTransition {
		for(state in states/* AS3HX WARNING could not determine type for var: state exp: EIdent(states) type: null*/)
			_fromStates.push(state);
		return this;
	}

	public function toStates(transitionState : String, finalState : String) : LifecycleTransition {
		_transitionState = transitionState;
		_finalState = finalState;
		return this;
	}

	public function withEvents(preTransitionEvent : String, transitionEvent : String, postTransitionEvent : String) : LifecycleTransition {
		_preTransitionEvent = preTransitionEvent;
		_transitionEvent = transitionEvent;
		_postTransitionEvent = postTransitionEvent;
		_reverse && _lifecycle.addReversedEventTypes(preTransitionEvent, transitionEvent, postTransitionEvent);
		return this;
	}

	public function inReverse() : LifecycleTransition {
		_reverse = true;
		_lifecycle.addReversedEventTypes(_preTransitionEvent, _transitionEvent, _postTransitionEvent);
		return this;
	}

	public function addBeforeHandler(handler : Function) : LifecycleTransition {
		_dispatcher.addMessageHandler(_name, handler);
		return this;
	}

	public function enter(callback : Function = null) : Void {
		// no more configuration beyond this point
		_locked = true;
		// immediately call back if we have already transitioned, and exit
		if(_lifecycle.state == _finalState)  {
			callback && safelyCallBack(callback, null, _name);
			return;
		}
;
		// queue this callback if we are mid transition, and exit
		if(_lifecycle.state == _transitionState)  {
			callback && _callbacks.push(callback);
			return;
		}
;
		// report invalid transition, and exit
		if(invalidTransition())  {
			reportError("Invalid transition", [callback]);
			return;
		}
;
		// store the initial lifecycle state in case we need to roll back
		var initialState : String = _lifecycle.state;
		// queue the first callback
		callback && _callbacks.push(callback);
		// put lifecycle into transition state
		setState(_transitionState);
		// run before handlers
		_dispatcher.dispatchMessage(_name, function(error : Dynamic) : Void {
			// revert state, report error, and exit
			if(error)  {
				setState(initialState);
				reportError(error, _callbacks);
				return;
			}
;
			// dispatch pre transition and transition events
			dispatch(_preTransitionEvent);
			dispatch(_transitionEvent);
			// put lifecycle into final state
			setState(_finalState);
			// process callback queue (dup and trash for safety)
			var callbacks : Array<Dynamic> = _callbacks.concat();
			_callbacks.length = 0;
			for(callback in callbacks/* AS3HX WARNING could not determine type for var: callback exp: EIdent(callbacks) type: Array<Dynamic>*/)
				safelyCallBack(callback, null, _name);
			// dispatch post transition event
			dispatch(_postTransitionEvent);
		}
, (_reverse) ? MessageDispatcher.REVERSE : 0);
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function invalidTransition() : Bool {
		return _fromStates.length > 0 && _fromStates.indexOf(_lifecycle.state) == -1;
	}

	function setState(state : String) : Void {
		state && _lifecycle.setCurrentState(state);
	}

	function dispatch(type : String) : Void {
		if(type != null && _lifecycle.hasEventListener(type)) 
			_lifecycle.dispatchEvent(new LifecycleEvent(type));
	}

	function reportError(message : Dynamic, callbacks : Array<Dynamic> = null) : Void {
		// turn message into Error
		var error : Error = Std.is(message, (Error) ? try cast(message, Error) catch(e:Dynamic) null : new Error(message));
		// dispatch error event if a listener exists, or throw
		if(_lifecycle.hasEventListener(LifecycleEvent.ERROR))  {
			var event : LifecycleEvent = new LifecycleEvent(LifecycleEvent.ERROR);
			event.error = error;
			_lifecycle.dispatchEvent(event);
			// process callback queue
			if(callbacks != null)  {
				for(callback in callbacks/* AS3HX WARNING could not determine type for var: callback exp: EIdent(callbacks) type: Array<Dynamic>*/)
					callback && safelyCallBack(callback, error, _name);
				callbacks.length = 0;
			}
;
		}

		else  {
			// explode!
			throw (error);
		}
;
	}

}

