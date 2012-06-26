//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.matching;

interface ITypeFilter {
	var allOfTypes(getAllOfTypes, never) : Vector<Class<Dynamic>>;
	var anyOfTypes(getAnyOfTypes, never) : Vector<Class<Dynamic>>;
	var descriptor(getDescriptor, never) : String;
	var noneOfTypes(getNoneOfTypes, never) : Vector<Class<Dynamic>>;

	function getAllOfTypes() : Vector<Class<Dynamic>>;
	function getAnyOfTypes() : Vector<Class<Dynamic>>;
	function getDescriptor() : String;
	function getNoneOfTypes() : Vector<Class<Dynamic>>;
	function matches(item : Dynamic) : Bool;
}

