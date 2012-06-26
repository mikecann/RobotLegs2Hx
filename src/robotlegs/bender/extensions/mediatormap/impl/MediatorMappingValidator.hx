package robotlegs.bender.extensions.mediatormap.impl;

import robotlegs.bender.extensions.matching.ITypeFilter;
import robotlegs.bender.extensions.mediatormap.api.MediatorMappingError;

class MediatorMappingValidator {
	var valid(getValid, never) : Bool;

	var CANT_CHANGE_GUARDS_AND_HOOKS : String;
	var STORED_ERROR_EXPLANATION : String;
	var _guards : Array<Dynamic>;
	var _hooks : Array<Dynamic>;
	var _matcher : ITypeFilter;
	var _mediatorClass : Class<Dynamic>;
	var _storedError : MediatorMappingError;
	var _valid : Bool;
	public function new(guards : Array<Dynamic>, hooks : Array<Dynamic>, matcher : ITypeFilter, mediatorClass : Class<Dynamic>) {
		CANT_CHANGE_GUARDS_AND_HOOKS = "You can't change the guards and hooks on an existing mapping. Unmap first.";
		STORED_ERROR_EXPLANATION = " The stacktrace for this error was stored at the time when you duplicated the mapping - you may have failed to add guards and hooks that were already present.";
		_valid = false;
		_guards = guards;
		_hooks = hooks;
		_matcher = matcher;
		_mediatorClass = mediatorClass;
		super();
	}

	function getValid() : Bool {
		return _valid;
	}

	function invalidate() : Void {
		_valid = false;
		_storedError = new MediatorMappingError(CANT_CHANGE_GUARDS_AND_HOOKS + STORED_ERROR_EXPLANATION, _matcher, _mediatorClass);
	}

	function validate(guards : Array<Dynamic>, hooks : Array<Dynamic>) : Void {
		if((!arraysMatch(_guards, guards)) || (!arraysMatch(_hooks, hooks))) 
			throwStoredError() || throwMappingError();
		_valid = true;
		_storedError = null;
	}

	function checkGuards(guards : Array<Dynamic>) : Void {
		if(changesContent(_guards, guards)) 
			throwMappingError();
	}

	function checkHooks(hooks : Array<Dynamic>) : Void {
		if(changesContent(_hooks, hooks)) 
			throwMappingError();
	}

	function changesContent(current : Array<Dynamic>, proposed : Array<Dynamic>) : Bool {
		proposed = flatten(proposed);
		for(item in proposed/* AS3HX WARNING could not determine type for var: item exp: EIdent(proposed) type: Array<Dynamic>*/) {
			if(current.indexOf(item) == -1) 
				return true;
		}

		return false;
	}

	function arraysMatch(arr1 : Array<Dynamic>, arr2 : Array<Dynamic>) : Bool {
		arr1 = arr1.slice();
		if(arr1.length != arr2.length) 
			return false;
		var foundAtIndex : Int;
		var iLength : UInt = arr2.length;
		var i : UInt = 0;
		while(i < iLength) {
			foundAtIndex = arr1.indexOf(arr2[i]);
			if(foundAtIndex == -1) 
				return false;
			arr1.splice(foundAtIndex, 1);
			i++;
		}
		return true;
	}

	public function flatten(array : Array<Dynamic>) : Array<Dynamic> {
		var flattened : Array<Dynamic> = [];
		for(obj in array/* AS3HX WARNING could not determine type for var: obj exp: EIdent(array) type: null*/) {
			if(Std.is(obj, Array))  {
				flattened = flattened.concat(flatten(try cast(obj, Array) catch(e:Dynamic) null));
			}

			else  {
				flattened.push(obj);
			}

		}

		return flattened;
	}

	function throwMappingError() : Void {
		throw (new MediatorMappingError(CANT_CHANGE_GUARDS_AND_HOOKS, _matcher, _mediatorClass));
	}

	function throwStoredError() : Bool {
		if(_storedError != null) 
			throw _storedError;
		return false;
	}

}

