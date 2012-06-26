//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.impl;

import flash.utils.Dictionary;
import robotlegs.bender.extensions.mediatormap.api.IMediatorMapping;
import robotlegs.bender.extensions.mediatormap.api.IMediatorViewHandler;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorMapper;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorMappingConfig;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorMappingFinder;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorUnmapper;
import robotlegs.bender.extensions.matching.ITypeMatcher;
import robotlegs.bender.extensions.matching.ITypeFilter;

class MediatorMapper implements IMediatorMapper, implements IMediatorMappingFinder, implements IMediatorUnmapper {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _mappings : Dictionary;
	var _matcher : ITypeFilter;
	var _handler : IMediatorViewHandler;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(matcher : ITypeFilter, handler : IMediatorViewHandler) {
		_mappings = new Dictionary();
		_matcher = matcher;
		_handler = handler;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function toMediator(mediatorClass : Class<Dynamic>) : IMediatorMappingConfig {
		return lockedMappingFor(mediatorClass) || createMapping(mediatorClass);
	}

	public function forMediator(mediatorClass : Class<Dynamic>) : IMediatorMapping {
		return Reflect.field(_mappings, Std.string(mediatorClass));
	}

	public function fromMediator(mediatorClass : Class<Dynamic>) : Void {
		var mapping : IMediatorMapping = Reflect.field(_mappings, Std.string(mediatorClass));
		This is an intentional compilation error. See the README for handling the delete keyword
		delete Reflect.field(_mappings, Std.string(mediatorClass));
		_handler.removeMapping(mapping);
	}

	public function fromMediators() : Void {
		for(mapping in _mappings/* AS3HX WARNING could not determine type for var: mapping exp: EIdent(_mappings) type: Dictionary*/) {
			This is an intentional compilation error. See the README for handling the delete keyword
			delete _mappings[mapping.mediatorClass];
			_handler.removeMapping(mapping);
		}

	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function createMapping(mediatorClass : Class<Dynamic>) : MediatorMapping {
		var mapping : MediatorMapping = new MediatorMapping(_matcher, mediatorClass);
		_handler.addMapping(mapping);
		Reflect.setField(_mappings, Std.string(mediatorClass), mapping);
		return mapping;
	}

	function lockedMappingFor(mediatorClass : Class<Dynamic>) : MediatorMapping {
		var mapping : MediatorMapping = Reflect.field(_mappings, Std.string(mediatorClass));
		if(mapping != null) 
			mapping.invalidate();
		return mapping;
	}

}

