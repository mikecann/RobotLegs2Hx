//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager;

import org.swiftsuspenders.Injector;
import robotlegs.bender.extensions.viewmanager.impl.ManualStageObserver;
import robotlegs.bender.extensions.viewmanager.impl.ContainerRegistry;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IContextExtension;

class ManualStageObserverExtension implements IContextExtension {

	/*============================================================================*/	/* Private Static Properties                                                  */	/*============================================================================*/	// Really? Yes, there can be only one.
		static var _manualStageObserver : ManualStageObserver;
	static var _installCount : UInt;
	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _injector : Injector;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function extend(context : IContext) : Void {
		_installCount++;
		_injector = context.injector;
		context.lifecycle.whenInitializing(handleContextSelfInitialize);
		context.lifecycle.whenDestroying(handleContextSelfDestroy);
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function handleContextSelfInitialize() : Void {
		if(_manualStageObserver == null)  {
			var containerRegistry : ContainerRegistry = _injector.getInstance(ContainerRegistry);
			_manualStageObserver = new ManualStageObserver(containerRegistry);
		}
	}

	function handleContextSelfDestroy() : Void {
		_installCount--;
		if(_installCount == 0)  {
			_manualStageObserver.destroy();
			_manualStageObserver = null;
		}
	}


	public function new() {
	}
}

