//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.matching;

class TypeFilter implements ITypeFilter {
	public var allOfTypes(getAllOfTypes, never) : Vector<Class<Dynamic>>;
	public var anyOfTypes(getAnyOfTypes, never) : Vector<Class<Dynamic>>;
	public var descriptor(getDescriptor, never) : String;
	public var noneOfTypes(getNoneOfTypes, never) : Vector<Class<Dynamic>>;

	/*============================================================================*/	/* Public Properties                                                          */	/*============================================================================*/	// TODO: Discuss whether we should return a slice here instead
		// of references to actual vectors. Overhead vs encapsulation.
		var _allOfTypes : Vector<Class<Dynamic>>;
	public function getAllOfTypes() : Vector<Class<Dynamic>> {
		return _allOfTypes;
	}

	var _anyOfTypes : Vector<Class<Dynamic>>;
	public function getAnyOfTypes() : Vector<Class<Dynamic>> {
		return _anyOfTypes;
	}

	var _descriptor : String;
	public function getDescriptor() : String {
		return _descriptor ||= createDescriptor();
	}

	var _noneOfTypes : Vector<Class<Dynamic>>;
	public function getNoneOfTypes() : Vector<Class<Dynamic>> {
		return _noneOfTypes;
	}

	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(allOf : Vector<Class<Dynamic>>, anyOf : Vector<Class<Dynamic>>, noneOf : Vector<Class<Dynamic>>) {
		if(allOf == null || anyOf == null || noneOf == null) 
			throw cast(("TypeFilter parameters can not be null"), ArgumentError);
		_allOfTypes = allOf;
		_anyOfTypes = anyOf;
		_noneOfTypes = noneOf;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function matches(item : Dynamic) : Bool {
		var i : UInt = _allOfTypes.length;
		while(i--) {
			if(!(Std.is(item, Reflect.field(_allOfTypes, Std.string(i)))))  {
				return false;
			}
		}

		i = _noneOfTypes.length;
		while(i--) {
			if(Std.is(item, Reflect.field(_noneOfTypes, Std.string(i))))  {
				return false;
			}
		}

		if(_anyOfTypes.length == 0 && (_allOfTypes.length > 0 || _noneOfTypes.length > 0))  {
			return true;
		}
		i = _anyOfTypes.length;
		while(i--) {
			if(Std.is(item, Reflect.field(_anyOfTypes, Std.string(i))))  {
				return true;
			}
		}

		return false;
	}

	/*============================================================================*/	/* Protected Functions                                                        */	/*============================================================================*/	function alphabetiseCaseInsensitiveFCQNs(classVector : Vector<Class<Dynamic>>) : Vector<String> {
		var fqcn : String;
		var allFCQNs : Vector<String> = Vector.ofArray(cast []);
		var iLength : UInt = classVector.length;
		var i : UInt = 0;
		while(i < iLength) {
			fqcn = Type.getClassName(Reflect.field(classVector, Std.string(i)));
			allFCQNs[allFCQNs.length] = fqcn;
			i++;
		}
		allFCQNs.sort(stringSort);
		return allFCQNs;
	}

	function createDescriptor() : String {
		var allOf_FCQNs : Vector<String> = alphabetiseCaseInsensitiveFCQNs(allOfTypes);
		var anyOf_FCQNs : Vector<String> = alphabetiseCaseInsensitiveFCQNs(anyOfTypes);
		var noneOf_FQCNs : Vector<String> = alphabetiseCaseInsensitiveFCQNs(noneOfTypes);
		return "all of: " + allOf_FCQNs.toString() + ", any of: " + anyOf_FCQNs.toString() + ", none of: " + noneOf_FQCNs.toString();
	}

	function stringSort(item1 : String, item2 : String) : Int {
		if(item1 < item2)  {
			return 1;
		}
		return -1;
	}

}

