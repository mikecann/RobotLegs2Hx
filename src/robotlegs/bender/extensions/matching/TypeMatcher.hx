//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.matching;

import flash.errors.IllegalOperationError;

class TypeMatcher implements ITypeMatcher, implements ITypeMatcherFactory {

	/*============================================================================*/	/* Protected Properties                                                       */	/*============================================================================*/	var _allOfTypes : Vector<Class<Dynamic>>;
	var _anyOfTypes : Vector<Class<Dynamic>>;
	var _noneOfTypes : Vector<Class<Dynamic>>;
	var _typeFilter : ITypeFilter;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	// TODO - make the API nice DSL
		public function allOf() : TypeMatcher {
		pushAddedTypesTo(types, _allOfTypes);
		return this;
	}

	public function anyOf() : TypeMatcher {
		pushAddedTypesTo(types, _anyOfTypes);
		return this;
	}

	public function noneOf() : TypeMatcher {
		pushAddedTypesTo(types, _noneOfTypes);
		return this;
	}

	public function createTypeFilter() : ITypeFilter {
		// calling this seals the matcher
		return _typeFilter ||= buildTypeFilter();
	}

	public function lock() : ITypeMatcherFactory {
		createTypeFilter();
		return this;
	}

	public function clone() : TypeMatcher {
		return new TypeMatcher().allOf(_allOfTypes).anyOf(_anyOfTypes).noneOf(_noneOfTypes);
	}

	/*============================================================================*/	/* Protected Functions                                                        */	/*============================================================================*/	function buildTypeFilter() : ITypeFilter {
		if((_allOfTypes.length == 0) && (_anyOfTypes.length == 0) && (_noneOfTypes.length == 0))  {
			throw new TypeMatcherError(TypeMatcherError.EMPTY_MATCHER);
		}
		return new TypeFilter(_allOfTypes, _anyOfTypes, _noneOfTypes);
	}

	function pushAddedTypesTo(types : Array<Dynamic>, targetSet : Vector<Class<Dynamic>>) : Void {
		_typeFilter && throwSealedMatcherError();
		pushValuesToClassVector(types, targetSet);
	}

	function throwSealedMatcherError() : Void {
		throw new IllegalOperationError("This TypeMatcher has been sealed and can no longer be configured");
	}

	function pushValuesToClassVector(values : Array<Dynamic>, vector : Vector<Class<Dynamic>>) : Void {
		if(values.length == 1 && (Std.is(values[0], Array || Std.is(values[0], Class<Dynamic>))))  {
			for(type in values[0]/* AS3HX WARNING could not determine type for var: type exp: EArray(EIdent(values),EConst(CInt(0))) type: Array<Dynamic>*/) {
				vector.push(type);
			}

		}

		else  {
			for(type in values/* AS3HX WARNING could not determine type for var: type exp: EIdent(values) type: Array<Dynamic>*/) {
				vector.push(type);
			}

		}

	}


	public function new() {
		_allOfTypes = new Vector<Class<Dynamic>>();
		_anyOfTypes = new Vector<Class<Dynamic>>();
		_noneOfTypes = new Vector<Class<Dynamic>>();
	}
}

