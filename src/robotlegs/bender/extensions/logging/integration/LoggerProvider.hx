//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.logging.integration;

import flash.utils.Dictionary;
import org.swiftsuspenders.Injector;
import org.swiftsuspenders.dependencyproviders.DependencyProvider;
import robotlegs.bender.framework.api.IContext;

class LoggerProvider implements DependencyProvider {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _context : IContext;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(context : IContext) {
		_context = context;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function apply(targetType : Class<Dynamic>, activeInjector : Injector, injectParameters : Dictionary) : Dynamic {
		return _context.getLogger(targetType);
	}

}

