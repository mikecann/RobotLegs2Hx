//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.matching;

import flash.errors.IllegalOperationError;

// TODO: review (location)
class PackageMatcher implements ITypeMatcher {

	/*============================================================================*/	/* Protected Properties                                                       */	/*============================================================================*/	var _requirePackage : String;
	var _anyOfPackages : Vector<String>;
	var _noneOfPackages : Vector<String>;
	var _typeFilter : ITypeFilter;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function createTypeFilter() : ITypeFilter {
		return _typeFilter ||= buildTypeFilter();
	}

	public function require(fullPackage : String) : PackageMatcher {
		if(_typeFilter != null) 
			throwSealedMatcherError();
		if(_requirePackage != null) 
			throw new IllegalOperationError("You can only set one required package on this PackageMatcher (two non-nested packages cannot both be required, and nested packages are redundant.)");
		_requirePackage = fullPackage;
		return this;
	}

	public function anyOf() : PackageMatcher {
		pushAddedPackagesTo(packages, _anyOfPackages);
		return this;
	}

	public function noneOf() : PackageMatcher {
		pushAddedPackagesTo(packages, _noneOfPackages);
		return this;
	}

	public function lock() : Void {
		createTypeFilter();
	}

	/*============================================================================*/	/* Protected Functions                                                        */	/*============================================================================*/	function buildTypeFilter() : ITypeFilter {
		if(((_requirePackage == null) || _requirePackage.length == 0) && (_anyOfPackages.length == 0) && (_noneOfPackages.length == 0))  {
			throw new TypeMatcherError(TypeMatcherError.EMPTY_MATCHER);
		}
		return new PackageFilter(_requirePackage, _anyOfPackages, _noneOfPackages);
	}

	function pushAddedPackagesTo(packages : Array<Dynamic>, targetSet : Vector<String>) : Void {
		_typeFilter && throwSealedMatcherError();
		pushValuesToStringVector(packages, targetSet);
	}

	function throwSealedMatcherError() : Void {
		throw new IllegalOperationError("This TypeMatcher has been sealed and can no longer be configured");
	}

	function pushValuesToStringVector(values : Array<Dynamic>, vector : Vector<String>) : Void {
		if(values.length == 1 && (Std.is(values[0], Array || Std.is(values[0], String))))  {
			for(packageName in values[0]/* AS3HX WARNING could not determine type for var: packageName exp: EArray(EIdent(values),EConst(CInt(0))) type: Array<Dynamic>*/) {
				vector.push(packageName);
			}

		}

		else  {
			for(packageName in values/* AS3HX WARNING could not determine type for var: packageName exp: EIdent(values) type: Array<Dynamic>*/) {
				vector.push(packageName);
			}

		}

	}


	public function new() {
		_anyOfPackages = new Vector<String>();
		_noneOfPackages = new Vector<String>();
	}
}

