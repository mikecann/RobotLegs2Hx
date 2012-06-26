//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.scopedmessagedispatcher;

import org.swiftsuspenders.Injector;
import robotlegs.bender.framework.api.IMessageDispatcher;
import robotlegs.bender.framework.impl.MessageDispatcher;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IContextExtension;

/**
 * This extensions maps a series of named IMessageDispatcher instances
 * provided those names have not been mapped by a parent context.
 */class ScopedMessageDispatcherExtension implements IContextExtension {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _names : Array<Dynamic>;
	var _injector : Injector;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new() {
		_names = ((names.length > 0)) ? names : ["global"];
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function extend(context : IContext) : Void {
		_injector = context.injector;
		context.lifecycle.whenInitializing(handleContextSelfInitialize);
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function handleContextSelfInitialize() : Void {
		for(name in _names/* AS3HX WARNING could not determine type for var: name exp: EIdent(_names) type: Array<Dynamic>*/) {
			if(!_injector.satisfies(IMessageDispatcher, name))  {
				_injector.map(IMessageDispatcher, name).toValue(new MessageDispatcher());
			}
		}

	}

}

