//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.logging.impl;

import org.swiftsuspenders.InjectionEvent;
import org.swiftsuspenders.Injector;
import org.swiftsuspenders.MappingEvent;
import robotlegs.bender.framework.api.ILogger;

class InjectorListener {

	/*============================================================================*/	/* Private Static Properties                                                  */	/*============================================================================*/	static inline var INJECTION_TYPES : Array<Dynamic> = [InjectionEvent.POST_CONSTRUCT, InjectionEvent.POST_INSTANTIATE, InjectionEvent.PRE_CONSTRUCT];
	static inline var MAPPING_TYPES : Array<Dynamic> = [// MappingEvent.MAPPING_OVERRIDE, // TODO: re-enable on next Swiftsuspenders update
	MappingEvent.POST_MAPPING_CHANGE, MappingEvent.POST_MAPPING_CREATE, MappingEvent.POST_MAPPING_REMOVE, MappingEvent.PRE_MAPPING_CHANGE, MappingEvent.PRE_MAPPING_CREATE];
	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _injector : Injector;
	var _logger : ILogger;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(injector : Injector, logger : ILogger) {
		_injector = injector;
		_logger = logger;
		addListeners();
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function destroy() : Void {
		var type : String;
		for(type in INJECTION_TYPES/* AS3HX WARNING could not determine type for var: type exp: EIdent(INJECTION_TYPES) type: Array<Dynamic>*/) {
			_injector.removeEventListener(type, onInjectionEvent);
		}

		for(type in MAPPING_TYPES/* AS3HX WARNING could not determine type for var: type exp: EIdent(MAPPING_TYPES) type: Array<Dynamic>*/) {
			_injector.removeEventListener(type, onMappingEvent);
		}

	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function addListeners() : Void {
		var type : String;
		for(type in INJECTION_TYPES/* AS3HX WARNING could not determine type for var: type exp: EIdent(INJECTION_TYPES) type: Array<Dynamic>*/) {
			_injector.addEventListener(type, onInjectionEvent);
		}

		for(type in MAPPING_TYPES/* AS3HX WARNING could not determine type for var: type exp: EIdent(MAPPING_TYPES) type: Array<Dynamic>*/) {
			_injector.addEventListener(type, onMappingEvent);
		}

	}

	function onInjectionEvent(event : InjectionEvent) : Void {
		_logger.debug("Injection event of type {0}. Instance: {1}. Instance type: {2}", [event.type, event.instance, event.instanceType]);
	}

	function onMappingEvent(event : MappingEvent) : Void {
		_logger.debug("Mapping event of type {0}. Mapped type: {1}. Mapped name: {2}", [event.type, event.mappedType, event.mappedName]);
	}

}

