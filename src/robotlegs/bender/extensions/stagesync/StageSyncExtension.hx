//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.stagesync;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import org.hamcrest.object.InstanceOf;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IContextExtension;
import robotlegs.bender.framework.impl.UID;
import robotlegs.bender.framework.api.ILogger;

/**
 * <p>This Extension waits for a DisplayObjectContainer to be added as a configuration,
 * and initializes and destroys the context based on that container's stage presence.</p>
 *
 * <p>It should be installed before context initialization.</p>
 */class StageSyncExtension implements IContextExtension {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _uid : String;
	var _context : IContext;
	var _contextView : DisplayObjectContainer;
	var _logger : ILogger;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function extend(context : IContext) : Void {
		_context = context;
		_logger = context.getLogger(this);
		_context.addConfigHandler(instanceOf(DisplayObjectContainer), handleContextView);
	}

	public function toString() : String {
		return _uid;
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function handleContextView(view : DisplayObjectContainer) : Void {
		_contextView = view;
		if(_contextView.stage)  {
			initializeContext();
		}

		else  {
			_logger.debug("Context view is not yet on stage. Waiting...");
			_contextView.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

	}

	function onAddedToStage(event : Event) : Void {
		_contextView.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		initializeContext();
	}

	function initializeContext() : Void {
		_logger.debug("Context view is now on stage. Initializing context...");
		_context.initialize();
		_contextView.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}

	function onRemovedFromStage(event : Event) : Void {
		_logger.debug("Context view has left the stage. Destroying context...");
		_contextView.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		_context.destroy();
	}


	public function new() {
		_uid = UID.create(StageSyncExtension);
	}
}

