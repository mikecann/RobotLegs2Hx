//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap;

import org.swiftsuspenders.Injector;
import robotlegs.bender.extensions.mediatormap.api.IMediatorFactory;
import robotlegs.bender.extensions.mediatormap.api.IMediatorMap;
import robotlegs.bender.extensions.mediatormap.impl.DefaultMediatorManager;
import robotlegs.bender.extensions.mediatormap.impl.MediatorFactory;
import robotlegs.bender.extensions.mediatormap.impl.MediatorMap;
import robotlegs.bender.extensions.viewmanager.api.IViewManager;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IContextExtension;
import robotlegs.bender.extensions.viewmanager.api.IViewHandler;

class MediatorMapExtension implements IContextExtension {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _context : IContext;
	var _injector : Injector;
	var _mediatorMap : IMediatorMap;
	var _viewManager : IViewManager;
	var _mediatorManager : DefaultMediatorManager;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function extend(context : IContext) : Void {
		_context = context;
		_injector = context.injector;
		_injector.map(IMediatorFactory).toSingleton(MediatorFactory);
		_injector.map(IMediatorMap).toSingleton(MediatorMap);
		// todo: figure out why this is done as preInitialize
		_context.lifecycle.beforeInitializing(handleContextPreInitialize);
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function handleContextPreInitialize() : Void {
		_mediatorMap = _injector.getInstance(IMediatorMap);
		_mediatorManager = _injector.getInstance(DefaultMediatorManager);
		if(_injector.satisfiesDirectly(IViewManager))  {
			_viewManager = _injector.getInstance(IViewManager);
			_viewManager.addViewHandler(try cast(_mediatorMap, IViewHandler) catch(e:Dynamic) null);
		}
	}


	public function new() {
	}
}

