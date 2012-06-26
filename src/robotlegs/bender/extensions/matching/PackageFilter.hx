//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.matching;

// TODO: review (location, design)
class PackageFilter implements ITypeFilter {
	public var descriptor(getDescriptor, never) : String;
	public var allOfTypes(getAllOfTypes, never) : Vector<Class<Dynamic>>;
	public var anyOfTypes(getAnyOfTypes, never) : Vector<Class<Dynamic>>;
	public var noneOfTypes(getNoneOfTypes, never) : Vector<Class<Dynamic>>;

	/*============================================================================*/	/* Public Properties                                                          */	/*============================================================================*/	var _descriptor : String;
	public function getDescriptor() : String {
		return _descriptor ||= createDescriptor();
	}

	public function getAllOfTypes() : Vector<Class<Dynamic>> {
		return emptyVector;
	}

	public function getAnyOfTypes() : Vector<Class<Dynamic>> {
		return emptyVector;
	}

	public function getNoneOfTypes() : Vector<Class<Dynamic>> {
		return emptyVector;
	}

	/*============================================================================*/	/* Protected Properties                                                       */	/*============================================================================*/	var emptyVector : Vector<Class<Dynamic>>;
	var _requirePackage : String;
	var _anyOfPackages : Vector<String>;
	var _noneOfPackages : Vector<String>;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(requiredPackage : String, anyOfPackages : Vector<String>, noneOfPackages : Vector<String>) {
		emptyVector = new Vector<Class<Dynamic>>();
		_requirePackage = requiredPackage;
		_anyOfPackages = anyOfPackages;
		_noneOfPackages = noneOfPackages;
		_anyOfPackages.sort(stringSort);
		_noneOfPackages.sort(stringSort);
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function matches(item : Dynamic) : Bool {
		var fqcn : String = Type.getClassName(item);
		var packageName : String;
		if(_requirePackage != null && (!matchPackageInFQCN(_requirePackage, fqcn))) 
			return false;
		for(packageName in _noneOfPackages/* AS3HX WARNING could not determine type for var: packageName exp: EIdent(_noneOfPackages) type: Vector<String>*/) {
			if(matchPackageInFQCN(packageName, fqcn)) 
				return false;
		}

		for(packageName in _anyOfPackages/* AS3HX WARNING could not determine type for var: packageName exp: EIdent(_anyOfPackages) type: Vector<String>*/) {
			if(matchPackageInFQCN(packageName, fqcn)) 
				return true;
		}

		if(_anyOfPackages.length > 0) 
			return false;
		if(_requirePackage != null) 
			return true;
		if(_noneOfPackages.length > 0) 
			return true;
		return false;
	}

	/*============================================================================*/	/* Protected Functions                                                        */	/*============================================================================*/	function stringSort(item1 : String, item2 : String) : Int {
		if(item1 > item2)  {
			return 1;
		}
		return -1;
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function createDescriptor() : String {
		return "require: " + _requirePackage + ", any of: " + _anyOfPackages.toString() + ", none of: " + _noneOfPackages.toString();
	}

	function matchPackageInFQCN(packageName : String, fqcn : String) : Bool {
		return (fqcn.indexOf(packageName) == 0);
	}

}

