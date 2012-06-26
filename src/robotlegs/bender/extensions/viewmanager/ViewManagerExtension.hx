//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager;

import org.swiftsuspenders.Injector;
import robotlegs.bender.extensions.viewmanager.api.IViewManager;
import robotlegs.bender.extensions.viewmanager.impl.ContainerRegistry;
import robotlegs.bender.extensions.viewmanager.impl.ViewManager;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IContextExtension;

class ViewManagerExtension implements IContextExtension {

	/*============================================================================*/	/* Private Static Properties                                                  */	/*============================================================================*/	// Really? Yes, there can be only one.
		static var _containerRegistry : ContainerRegistry;
	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _injector : Injector;
	var _viewManager : IViewManager;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function extend(context : IContext) : Void {
		_injector = context.injector;
		// Just one Container Registry
		_containerRegistry ||= new ContainerRegistry();
		_injector.map(ContainerRegistry).toValue(_containerRegistry);
		// But you get your own View Manager
		_injector.map(IViewManager).toSingleton(ViewManager);
		context.lifecycle.whenInitializing(handleContextSelfInitialize);
		context.lifecycle.whenDestroying(handleContextSelfDestroy);
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function handleContextSelfInitialize() : Void {
		_viewManager = _injector.getInstance(IViewManager);
	}

	function handleContextSelfDestroy() : Void {
		_viewManager.removeAllHandlers();
		_injector.unmap(IViewManager);
		_injector.unmap(ContainerRegistry);
	}


	public function new() {
	}
}

