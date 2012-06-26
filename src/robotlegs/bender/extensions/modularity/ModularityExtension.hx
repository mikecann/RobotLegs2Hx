//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.modularity;

import flash.display.DisplayObjectContainer;
import org.swiftsuspenders.Injector;
import robotlegs.bender.extensions.modularity.events.ModularContextEvent;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IContextExtension;
import robotlegs.bender.framework.impl.UID;
import robotlegs.bender.framework.api.ILogger;

/**
 * <p>This extension allows a context to inherit dependencies from a parent context,
 * and to expose its dependencies to child contexts.</p>
 *
 * <p>It should be installed before context initialization.</p>
 */class ModularityExtension implements IContextExtension {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _uid : String;
	var _context : IContext;
	var _injector : Injector;
	var _logger : ILogger;
	var _inherit : Bool;
	var _export : Bool;
	var _contextView : DisplayObjectContainer;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	/**
	 * Modularity
	 *
	 * @param inherit Should this context inherit dependencies?
	 * @param export Should this context expose its dependencies?
	 */	public function new(inherit : Bool = true, export : Bool = true) {
		_uid = UID.create(ModularityExtension);
		_inherit = inherit;
		_export = export;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function extend(context : IContext) : Void {
		_context = context;
		_injector = context.injector;
		_logger = context.getLogger(this);
		_context.lifecycle.beforeInitializing(handleContextPreInitialize);
		_context.lifecycle.beforeDestroying(handleContextPreDestroy);
	}

	public function toString() : String {
		return _uid;
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function handleContextPreInitialize() : Void {
		if(!_injector.satisfiesDirectly(DisplayObjectContainer)) 
			throw new Error("This extension requires a DisplayObjectContainer to mapped.");
		_contextView = _injector.getInstance(DisplayObjectContainer);
		_inherit && broadcastExistence();
		_export && addExistenceListener();
	}

	function handleContextPreDestroy() : Void {
		_logger.debug("Removing modular context existence event listener...");
		_export && _contextView.removeEventListener(ModularContextEvent.CONTEXT_ADD, onContextAdd);
	}

	function broadcastExistence() : Void {
		_logger.debug("Modular context configured to inherit. Broadcasting existence event...");
		_contextView.dispatchEvent(new ModularContextEvent(ModularContextEvent.CONTEXT_ADD, _context));
	}

	function addExistenceListener() : Void {
		_logger.debug("Modular context configured to export. Listening for existence events...");
		_contextView.addEventListener(ModularContextEvent.CONTEXT_ADD, onContextAdd);
	}

	function onContextAdd(event : ModularContextEvent) : Void {
		_logger.debug("Modular context existence message caught. Configuring child module...");
		event.stopImmediatePropagation();
		event.context.injector.parentInjector = _context.injector;
	}

}

