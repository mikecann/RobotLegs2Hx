//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager.impl;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

class ManualStageObserver {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _registry : ContainerRegistry;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(containerRegistry : ContainerRegistry) {
		_registry = containerRegistry;
		// We care about all containers (not just roots)
		_registry.addEventListener(ContainerRegistryEvent.CONTAINER_ADD, onContainerAdd);
		_registry.addEventListener(ContainerRegistryEvent.CONTAINER_REMOVE, onContainerRemove);
		// We might have arrived late on the scene
		for(binding in _registry.bindings/* AS3HX WARNING could not determine type for var: binding exp: EField(EIdent(_registry),bindings) type: null*/) {
			addContainerListener(binding.container);
		}
;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function destroy() : Void {
		_registry.removeEventListener(ContainerRegistryEvent.CONTAINER_ADD, onContainerAdd);
		_registry.removeEventListener(ContainerRegistryEvent.CONTAINER_REMOVE, onContainerRemove);
		for(binding in _registry.bindings/* AS3HX WARNING could not determine type for var: binding exp: EField(EIdent(_registry),bindings) type: null*/) {
			removeContainerListener(binding.container);
		}

	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function onContainerAdd(event : ContainerRegistryEvent) : Void {
		addContainerListener(event.container);
	}

	function onContainerRemove(event : ContainerRegistryEvent) : Void {
		removeContainerListener(event.container);
	}

	function addContainerListener(container : DisplayObjectContainer) : Void {
		// We're interested in ALL container bindings
		// but just for normal, bubbling events
		container.addEventListener(ConfigureViewEvent.CONFIGURE_VIEW, onConfigureView);
	}

	function removeContainerListener(container : DisplayObjectContainer) : Void {
		// Release the container listener
		container.removeEventListener(ConfigureViewEvent.CONFIGURE_VIEW, onConfigureView);
	}

	function onConfigureView(event : ConfigureViewEvent) : Void {
		// Stop that event!
		event.stopImmediatePropagation();
		var container : DisplayObjectContainer = try cast(event.currentTarget, DisplayObjectContainer) catch(e:Dynamic) null;
		var view : DisplayObject = try cast(event.target, DisplayObject) catch(e:Dynamic) null;
		var type : Class<Dynamic> = Reflect.field(view, "constructor");
		_registry.getBinding(container).handleView(view, type);
	}

}

