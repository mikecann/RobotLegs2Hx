//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.impl;

import flash.utils.Dictionary;
import robotlegs.bender.extensions.mediatormap.api.IMediatorFactory;
import robotlegs.bender.extensions.mediatormap.api.IMediatorMap;
import robotlegs.bender.extensions.mediatormap.api.IMediatorViewHandler;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorMapper;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorMappingFinder;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorUnmapper;
import robotlegs.bender.extensions.matching.ITypeMatcher;
import robotlegs.bender.extensions.matching.TypeMatcher;
import flash.display.DisplayObject;
import robotlegs.bender.extensions.viewmanager.api.IViewHandler;

class MediatorMap implements IMediatorMap, implements IViewHandler {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _mappers : Dictionary;
	var _handler : IMediatorViewHandler;
	var _factory : IMediatorFactory;
	var NULL_UNMAPPER : IMediatorUnmapper;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(factory : IMediatorFactory, handler : IMediatorViewHandler = null) {
		_mappers = new Dictionary();
		NULL_UNMAPPER = new NullMediatorUnmapper();
		_factory = factory;
		_handler = handler || new MediatorViewHandler(_factory);
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function mapMatcher(matcher : ITypeMatcher) : IMediatorMapper {
		return _mappers[matcher.createTypeFilter().descriptor] ||= createMapper(matcher);
	}

	public function map(type : Class<Dynamic>) : IMediatorMapper {
		var matcher : ITypeMatcher = new TypeMatcher().allOf(type);
		return mapMatcher(matcher);
	}

	public function unmapMatcher(matcher : ITypeMatcher) : IMediatorUnmapper {
		return _mappers[matcher.createTypeFilter().descriptor] || NULL_UNMAPPER;
	}

	public function unmap(type : Class<Dynamic>) : IMediatorUnmapper {
		var matcher : ITypeMatcher = new TypeMatcher().allOf(type);
		return unmapMatcher(matcher);
	}

	public function handleView(view : DisplayObject, type : Class<Dynamic>) : Void {
		_handler.handleView(view, type);
	}

	public function mediate(item : Dynamic) : Void {
		var type : Class<Dynamic> = item.constructor;
		_handler.handleItem(item, type);
	}

	public function unmediate(item : Dynamic) : Void {
		_factory.removeMediators(item);
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function createMapper(matcher : ITypeMatcher, viewType : Class<Dynamic> = null) : IMediatorMapper {
		return new MediatorMapper(matcher.createTypeFilter(), _handler);
	}

}

