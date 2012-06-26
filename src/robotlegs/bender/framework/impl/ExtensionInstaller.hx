//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import flash.utils.Dictionary;
import org.swiftsuspenders.DescribeTypeReflector;
import org.swiftsuspenders.Reflector;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.ILogger;

class ExtensionInstaller {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _classes : Dictionary;
	var _reflector : Reflector;
	var _context : IContext;
	var _logger : ILogger;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(context : IContext) {
		_classes = new Dictionary(true);
		_reflector = new DescribeTypeReflector();
		_context = context;
		_logger = _context.getLogger(this);
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function install(extension : Dynamic) : Void {
		if(Std.is(extension, Class))  {
			Reflect.field(_classes, Std.string(extension)) || install(new Extension());
		}

		else  {
			var extensionClass : Class<Dynamic> = _reflector.getClass(extension);
			if(Reflect.field(_classes, Std.string(extensionClass))) 
				return;
			_logger.debug("Installing extension {0}", [extension]);
			Reflect.setField(_classes, Std.string(extensionClass), true);
			extension.extend(_context);
		}

	}

}

