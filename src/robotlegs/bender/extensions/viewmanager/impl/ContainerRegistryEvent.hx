//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager.impl;

import flash.display.DisplayObjectContainer;
import flash.events.Event;

class ContainerRegistryEvent extends Event {
	public var container(getContainer, never) : DisplayObjectContainer;

	/*============================================================================*/	/* Public Static Properties                                                   */	/*============================================================================*/	static public inline var CONTAINER_ADD : String = "containerAdd";
	static public inline var CONTAINER_REMOVE : String = "containerRemove";
	static public inline var ROOT_CONTAINER_ADD : String = "rootContainerAdd";
	static public inline var ROOT_CONTAINER_REMOVE : String = "rootContainerRemove";
	/*============================================================================*/	/* Public Properties                                                          */	/*============================================================================*/	var _container : DisplayObjectContainer;
	public function getContainer() : DisplayObjectContainer {
		return _container;
	}

	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(type : String, container : DisplayObjectContainer) {
		super(type);
		_container = container;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	override public function clone() : Event {
		return new ContainerRegistryEvent(type, _container);
	}

}

