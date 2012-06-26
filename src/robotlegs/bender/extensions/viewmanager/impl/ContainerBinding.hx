//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager.impl;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.EventDispatcher;
import robotlegs.bender.extensions.viewmanager.api.IViewHandler;

@:meta(Event(name="bindingEmpty",type="robotlegs.bender.extensions.viewManager.impl.ContainerBindingEvent"))
class ContainerBinding extends EventDispatcher {
	public var parent(getParent, setParent) : ContainerBinding;
	public var container(getContainer, never) : DisplayObjectContainer;
	public var numHandlers(getNumHandlers, never) : UInt;

	/*============================================================================*/	/* Public Properties                                                          */	/*============================================================================*/	var _parent : ContainerBinding;
	public function getParent() : ContainerBinding {
		return _parent;
	}

	public function setParent(value : ContainerBinding) : ContainerBinding {
		_parent = value;
		return value;
	}

	var _container : DisplayObjectContainer;
	public function getContainer() : DisplayObjectContainer {
		return _container;
	}

	public function getNumHandlers() : UInt {
		return _handlers.length;
	}

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _handlers : Vector<IViewHandler>;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(container : DisplayObjectContainer) {
		_handlers = new Vector<IViewHandler>();
		_container = container;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function addHandler(handler : IViewHandler) : Void {
		if(_handlers.indexOf(handler) > -1) 
			return;
		_handlers.push(handler);
	}

	public function removeHandler(handler : IViewHandler) : Void {
		var index : Int = _handlers.indexOf(handler);
		if(index > -1)  {
			_handlers.splice(index, 1);
			if(_handlers.length == 0)  {
				dispatchEvent(new ContainerBindingEvent(ContainerBindingEvent.BINDING_EMPTY));
			}
		}
	}

	public function handleView(view : DisplayObject, type : Class<Dynamic>) : Void {
		var length : UInt = _handlers.length;
		var i : Int = 0;
		while(i < length) {
			var handler : IViewHandler = try cast(_handlers[i], IViewHandler) catch(e:Dynamic) null;
			handler.handleView(view, type);
			i++;
		}
	}

}

