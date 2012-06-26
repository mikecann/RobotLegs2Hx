//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.api;

import robotlegs.bender.extensions.mediatormap.dsl.IMediatorMapper;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorMappingFinder;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorUnmapper;
import robotlegs.bender.extensions.viewmanager.api.IViewHandler;
import robotlegs.bender.extensions.matching.ITypeMatcher;

interface IMediatorMap {

	function mapMatcher(matcher : ITypeMatcher) : IMediatorMapper;
	function map(type : Class<Dynamic>) : IMediatorMapper;
	function unmapMatcher(matcher : ITypeMatcher) : IMediatorUnmapper;
	function unmap(type : Class<Dynamic>) : IMediatorUnmapper;
	function mediate(item : Dynamic) : Void;
	function unmediate(item : Dynamic) : Void;
}

