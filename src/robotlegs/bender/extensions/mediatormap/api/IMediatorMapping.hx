//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.api;

import robotlegs.bender.extensions.matching.ITypeFilter;

interface IMediatorMapping {
	var matcher(getMatcher, never) : ITypeFilter;
	var mediatorClass(getMediatorClass, never) : Class<Dynamic>;
	var guards(getGuards, never) : Array<Dynamic>;
	var hooks(getHooks, never) : Array<Dynamic>;

	function getMatcher() : ITypeFilter;
	function getMediatorClass() : Class<Dynamic>;
	function getGuards() : Array<Dynamic>;
	function getHooks() : Array<Dynamic>;
}

