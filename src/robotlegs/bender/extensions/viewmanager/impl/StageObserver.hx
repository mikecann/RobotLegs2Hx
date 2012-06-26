//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager.impl;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

class StageObserver {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _registry : ContainerRegistry;
	var _filter : RegExp;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(containerRegistry : ContainerRegistry) {
		_filter = new EReg('^mx\\.|^spark\\.|^flash\\.', "");
		_registry = containerRegistry;
		// We only care about roots
		_registry.addEventListener(ContainerRegistryEvent.ROOT_CONTAINER_ADD, onRootContainerAdd);
		_registry.addEventListener(ContainerRegistryEvent.ROOT_CONTAINER_REMOVE, onRootContainerRemove);
		// We might have arrived late on the scene
		for(binding in _registry.rootBindings/* AS3HX WARNING could not determine type for var: binding exp: EField(EIdent(_registry),rootBindings) type: null*/) {
			addRootListener(binding.container);
		}
;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function destroy() : Void {
		_registry.removeEventListener(ContainerRegistryEvent.ROOT_CONTAINER_ADD, onRootContainerAdd);
		_registry.removeEventListener(ContainerRegistryEvent.ROOT_CONTAINER_REMOVE, onRootContainerRemove);
		for(binding in _registry.rootBindings/* AS3HX WARNING could not determine type for var: binding exp: EField(EIdent(_registry),rootBindings) type: null*/) {
			removeRootListener(binding.container);
		}

	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function onRootContainerAdd(event : ContainerRegistryEvent) : Void {
		addRootListener(event.container);
	}

	function onRootContainerRemove(event : ContainerRegistryEvent) : Void {
		removeRootListener(event.container);
	}

	function addRootListener(container : DisplayObjectContainer) : Void {
		// The magical, but extremely expensive, capture-phase ADDED_TO_STAGE listener
		container.addEventListener(Event.ADDED_TO_STAGE, onViewAddedToStage, true);
		// Watch the root container itself - nobody else is going to pick it up!
		container.addEventListener(Event.ADDED_TO_STAGE, onContainerRootAddedToStage);
	}

	function removeRootListener(container : DisplayObjectContainer) : Void {
		container.removeEventListener(Event.ADDED_TO_STAGE, onViewAddedToStage, true);
		container.removeEventListener(Event.ADDED_TO_STAGE, onContainerRootAddedToStage);
	}

	function onViewAddedToStage(event : Event) : Void {
		var view : DisplayObject = try cast(event.target, DisplayObject) catch(e:Dynamic) null;
		var qcn : String = Type.getClassName(view);
		var filtered : Bool = _filter.test(qcn);
		if(filtered) 
			return;
		var type : Class<Dynamic> = Reflect.field(view, "constructor");
		// Walk upwards from the nearest binding
		var binding : ContainerBinding = _registry.findParentBinding(view);
		while(binding) {
			binding.handleView(view, type);
			binding = binding.parent;
		}

	}

	function onContainerRootAddedToStage(event : Event) : Void {
		var container : DisplayObjectContainer = try cast(event.target, DisplayObjectContainer) catch(e:Dynamic) null;
		container.removeEventListener(Event.ADDED_TO_STAGE, onContainerRootAddedToStage);
		var type : Class<Dynamic> = Reflect.field(container, "constructor");
		var binding : ContainerBinding = _registry.getBinding(container);
		binding.handleView(container, type);
	}

}

