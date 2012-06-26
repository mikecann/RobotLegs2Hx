//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.contextview;

import flash.display.DisplayObjectContainer;
import org.hamcrest.object.InstanceOf;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IContextExtension;
import robotlegs.bender.framework.impl.UID;
import robotlegs.bender.framework.api.ILogger;

/**
 * <p>This Extension waits for a DisplayObjectContainer to be added as a configuration
 * and maps that container into the context's injector.</p>
 *
 * <p>It should be installed before context initialization.</p>
 */class ContextViewExtension implements IContextExtension {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _uid : String;
	var _context : IContext;
	var _logger : ILogger;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	// todo: accept contextView via constructor and use that if provided
		public function extend(context : IContext) : Void {
		_context = context;
		_logger = context.getLogger(this);
		_context.addConfigHandler(instanceOf(DisplayObjectContainer), handleContextView);
	}

	public function toString() : String {
		return _uid;
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function handleContextView(view : DisplayObjectContainer) : Void {
		_logger.debug("Mapping provided DisplayObjectContainer as contextView...");
		_context.injector.map(DisplayObjectContainer).toValue(view);
	}


	public function new() {
		_uid = UID.create(ContextViewExtension);
	}
}

