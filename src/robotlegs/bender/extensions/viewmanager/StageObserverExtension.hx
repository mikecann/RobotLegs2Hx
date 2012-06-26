//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager;

import org.swiftsuspenders.Injector;
import robotlegs.bender.extensions.viewmanager.impl.ContainerRegistry;
import robotlegs.bender.extensions.viewmanager.impl.StageObserver;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IContextExtension;

class StageObserverExtension implements IContextExtension {

	/*============================================================================*/	/* Private Static Properties                                                  */	/*============================================================================*/	// Really? Yes, there can be only one.
		static var _stageObserver : StageObserver;
	static var _installCount : UInt;
	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _injector : Injector;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function extend(context : IContext) : Void {
		_installCount++;
		_injector = context.injector;
		context.lifecycle.whenInitializing(handleContextSelfInitialize);
		context.lifecycle.whenDestroying(handleContextSelfDestroy);
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function handleContextSelfInitialize() : Void {
		if(_stageObserver == null)  {
			var containerRegistry : ContainerRegistry = _injector.getInstance(ContainerRegistry);
			_stageObserver = new StageObserver(containerRegistry);
		}
	}

	function handleContextSelfDestroy() : Void {
		_installCount--;
		if(_installCount == 0)  {
			_stageObserver.destroy();
			_stageObserver = null;
		}
	}


	public function new() {
	}
}

