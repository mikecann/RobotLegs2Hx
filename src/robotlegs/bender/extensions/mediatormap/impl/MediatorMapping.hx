//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.impl;

import robotlegs.bender.extensions.mediatormap.api.IMediatorFactory;
import robotlegs.bender.extensions.mediatormap.api.IMediatorMapping;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorMappingConfig;
import robotlegs.bender.extensions.matching.ITypeFilter;
import robotlegs.bender.extensions.mediatormap.api.MediatorMappingError;

class MediatorMapping implements IMediatorMapping, implements IMediatorMappingConfig {
	public var matcher(getMatcher, never) : ITypeFilter;
	public var mediatorClass(getMediatorClass, never) : Class<Dynamic>;
	public var guards(getGuards, never) : Array<Dynamic>;
	public var hooks(getHooks, never) : Array<Dynamic>;

	var _locked : Bool;
	var _validator : MediatorMappingValidator;
	/*============================================================================*/	/* Public Properties                                                          */	/*============================================================================*/	var _matcher : ITypeFilter;
	public function getMatcher() : ITypeFilter {
		validate();
		return _matcher;
	}

	var _mediatorClass : Class<Dynamic>;
	public function getMediatorClass() : Class<Dynamic> {
		return _mediatorClass;
	}

	var _guards : Array<Dynamic>;
	public function getGuards() : Array<Dynamic> {
		return _guards;
	}

	var _hooks : Array<Dynamic>;
	public function getHooks() : Array<Dynamic> {
		return _hooks;
	}

	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(matcher : ITypeFilter, mediatorClass : Class<Dynamic>) {
		_locked = false;
		_guards = [];
		_hooks = [];
		_matcher = matcher;
		_mediatorClass = mediatorClass;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function withGuards() : IMediatorMappingConfig {
		_validator && _validator.checkGuards(guards);
		_guards = _guards.concat.apply(null, guards);
		return this;
	}

	public function withHooks() : IMediatorMappingConfig {
		_validator && _validator.checkHooks(hooks);
		_hooks = _hooks.concat.apply(null, hooks);
		return this;
	}

	function invalidate() : Void {
		if(_validator != null) 
			_validator.invalidate()
		else createValidator();
		_guards = [];
		_hooks = [];
	}

	function validate() : Void {
		if(_validator == null)  {
			createValidator();
		}

		else if(!_validator.valid)  {
			_validator.validate(_guards, _hooks);
		}
	}

	function createValidator() : Void {
		_validator = new MediatorMappingValidator(_guards.slice(), _hooks.slice(), _matcher, _mediatorClass);
	}

}

