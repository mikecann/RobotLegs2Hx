//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.messagecommandmap.impl;

import flash.utils.DescribeType;
import org.swiftsuspenders.Injector;
import robotlegs.bender.framework.impl.SafelyCallBack;
import robotlegs.bender.framework.api.IMessageDispatcher;
import robotlegs.bender.extensions.commandmap.api.ICommandMapping;
import robotlegs.bender.extensions.commandmap.api.ICommandTrigger;
import robotlegs.bender.framework.impl.GuardsApprove;
import robotlegs.bender.framework.impl.ApplyHooks;

class MessageCommandTrigger implements ICommandTrigger {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _mappings : Vector<ICommandMapping>;
	var _injector : Injector;
	var _dispatcher : IMessageDispatcher;
	var _message : Dynamic;
	var _once : Bool;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(injector : Injector, dispatcher : IMessageDispatcher, message : Dynamic, once : Bool = false) {
		_mappings = new Vector<ICommandMapping>();
		_injector = injector.createChildInjector();
		_dispatcher = dispatcher;
		_message = message;
		_once = once;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function addMapping(mapping : ICommandMapping) : Void {
		verifyCommandClass(mapping);
		_mappings.push(mapping);
		if(_mappings.length == 1) 
			addHandler();
	}

	public function removeMapping(mapping : ICommandMapping) : Void {
		var index : Int = _mappings.indexOf(mapping);
		if(index != -1)  {
			_mappings.splice(index, 1);
			if(_mappings.length == 0) 
				removeHandler();
		}
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function verifyCommandClass(mapping : ICommandMapping) : Void {
	}

	function addHandler() : Void {
		_dispatcher.addMessageHandler(_message, handleMessage);
	}

	function removeHandler() : Void {
		_dispatcher.removeMessageHandler(_message, handleMessage);
	}

	function handleMessage(message : Dynamic, callback : Function) : Void {
		var mappings : Vector<ICommandMapping> = _mappings.concat().reverse();
		next(mappings, callback);
	}

	function next(mappings : Vector<ICommandMapping>, callback : Function) : Void {
		// Try to keep things synchronous with a simple loop,
		// forcefully breaking out for async handlers and recursing.
		// We do this to avoid increasing the stack depth unnecessarily.
		var mapping : ICommandMapping;
		while(mapping = mappings.pop()) {
			if(guardsApprove(mapping.guards, _injector))  {
				_once && removeMapping(mapping);
				_injector.map(mapping.commandClass).asSingleton();
				var command : Dynamic = _injector.getInstance(mapping.commandClass);
				var handler : Function = command.execute;
				applyHooks(mapping.hooks, _injector);
				_injector.unmap(mapping.commandClass);
				if(handler.length == 0) 
					// sync handler: ()
				 {
					handler();
				}

				else if(handler.length == 1) 
					// sync handler: (message)
				 {
					handler(_message);
				}

				else if(handler.length == 2) 
					// sync or async handler: (message, callback)
				 {
					var handled : Bool;
					handler(_message, function(error : Dynamic = null, msg : Dynamic = null) : Void {
						// handler must not invoke the callback more than once
						if(handled) 
							return;
						handled = true;
						if(error || mappings.length == 0)  {
							callback && safelyCallBack(callback, error, _message);
						}

						else  {
							next(mappings, callback);
						}

					}
);
					// IMPORTANT: MUST break this loop with a RETURN. See above.
					return;
				}

				else // ERROR: this should NEVER happen
				 {
				}
;
			}
		}

		// If we got here then this loop finished synchronously.
		// Nobody broke out, so we are done.
		// This relies on the various return statements above. Be careful.
		callback && safelyCallBack(callback, null, _message);
	}

}

