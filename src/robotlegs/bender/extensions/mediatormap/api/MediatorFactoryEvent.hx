//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.api;

import flash.events.Event;

class MediatorFactoryEvent extends Event {
	public var mediator(getMediator, never) : Dynamic;
	public var view(getView, never) : Dynamic;
	public var mapping(getMapping, never) : IMediatorMapping;
	public var factory(getFactory, never) : IMediatorFactory;

	/*============================================================================*/	/* Public Static Properties                                                   */	/*============================================================================*/	static public inline var MEDIATOR_CREATE : String = "mediatorCreate";
	static public inline var MEDIATOR_REMOVE : String = "mediatorRemove";
	/*============================================================================*/	/* Public Properties                                                          */	/*============================================================================*/	var _mediator : Dynamic;
	public function getMediator() : Dynamic {
		return _mediator;
	}

	var _view : Dynamic;
	public function getView() : Dynamic {
		return _view;
	}

	var _mapping : IMediatorMapping;
	public function getMapping() : IMediatorMapping {
		return _mapping;
	}

	var _factory : IMediatorFactory;
	public function getFactory() : IMediatorFactory {
		return _factory;
	}

	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(type : String, mediator : Dynamic, view : Dynamic, mapping : IMediatorMapping, factory : IMediatorFactory) {
		super(type);
		_mediator = mediator;
		_view = view;
		_mapping = mapping;
		_factory = factory;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	override public function clone() : Event {
		return new MediatorFactoryEvent(type, _mediator, _view, _mapping, _factory);
	}

}

