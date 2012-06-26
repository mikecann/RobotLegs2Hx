//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager.impl;

import flash.display.DisplayObjectContainer;
import robotlegs.bender.extensions.viewmanager.api.IViewHandler;
import robotlegs.bender.extensions.viewmanager.api.IViewManager;

class ViewManager implements IViewManager {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _containers : Vector<DisplayObjectContainer>;
	var _handlers : Vector<IViewHandler>;
	var _registry : ContainerRegistry;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(containerRegistry : ContainerRegistry) {
		_containers = new Vector<DisplayObjectContainer>();
		_handlers = new Vector<IViewHandler>();
		_registry = containerRegistry;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function addContainer(container : DisplayObjectContainer) : Void {
		if(!validContainer(container)) 
			return;
		_containers.push(container);
		for(handler in _handlers/* AS3HX WARNING could not determine type for var: handler exp: EIdent(_handlers) type: Vector<IViewHandler>*/) {
			_registry.addContainer(container).addHandler(handler);
		}

	}

	public function removeContainer(container : DisplayObjectContainer) : Void {
		var index : Int = _containers.indexOf(container);
		if(index == -1) 
			return;
		_containers.splice(index, 1);
		var binding : ContainerBinding = _registry.getBinding(container);
		for(handler in _handlers/* AS3HX WARNING could not determine type for var: handler exp: EIdent(_handlers) type: Vector<IViewHandler>*/) {
			binding.removeHandler(handler);
		}

	}

	public function addViewHandler(handler : IViewHandler) : Void {
		if(_handlers.indexOf(handler) != -1) 
			return;
		_handlers.push(handler);
		for(container in _containers/* AS3HX WARNING could not determine type for var: container exp: EIdent(_containers) type: Vector<DisplayObjectContainer>*/) {
			_registry.addContainer(container).addHandler(handler);
		}

	}

	public function removeViewHandler(handler : IViewHandler) : Void {
		var index : Int = _handlers.indexOf(handler);
		if(index == -1) 
			return;
		_handlers.splice(index, 1);
		for(container in _containers/* AS3HX WARNING could not determine type for var: container exp: EIdent(_containers) type: Vector<DisplayObjectContainer>*/) {
			_registry.getBinding(container).removeHandler(handler);
		}

	}

	public function removeAllHandlers() : Void {
		for(container in _containers/* AS3HX WARNING could not determine type for var: container exp: EIdent(_containers) type: Vector<DisplayObjectContainer>*/) {
			var binding : ContainerBinding = _registry.getBinding(container);
			for(handler in _handlers/* AS3HX WARNING could not determine type for var: handler exp: EIdent(_handlers) type: Vector<IViewHandler>*/) {
				binding.removeHandler(handler);
			}

		}

	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function validContainer(container : DisplayObjectContainer) : Bool {
		for(registeredContainer in _containers/* AS3HX WARNING could not determine type for var: registeredContainer exp: EIdent(_containers) type: Vector<DisplayObjectContainer>*/) {
			if(container == registeredContainer) 
				return false;
			if(registeredContainer.contains(container) || container.contains(registeredContainer)) 
				throw new Error("Containers can not be nested");
		}

		return true;
	}

}

