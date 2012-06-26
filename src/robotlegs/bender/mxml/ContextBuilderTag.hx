//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.mxml;

import flash.display.DisplayObjectContainer;
import flash.utils.SetTimeout;
import mx.core.IMXMLObject;
import org.swiftsuspenders.DescribeTypeReflector;
import org.swiftsuspenders.Reflector;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IContextExtension;
import robotlegs.bender.framework.impl.Context;

@:meta(DefaultProperty(name="configs"))
/**
 * Apache Flex context builder tag
 */class ContextBuilderTag implements IMXMLObject {
	public var configs(getConfigs, setConfigs) : Array<Dynamic>;
	public var contextView(never, setContextView) : DisplayObjectContainer;
	public var context(getContext, never) : IContext;

	/*============================================================================*/	/* Public Properties                                                          */	/*============================================================================*/	var _configs : Array<Dynamic>;
	public function getConfigs() : Array<Dynamic> {
		return _configs;
	}

	public function setConfigs(value : Array<Dynamic>) : Array<Dynamic> {
		_configs = value;
		return value;
	}

	var _contextView : DisplayObjectContainer;
	public function setContextView(value : DisplayObjectContainer) : DisplayObjectContainer {
		_contextView = value;
		return value;
	}

	var _context : IContext;
	public function getContext() : IContext {
		return _context;
	}

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _reflector : Reflector;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function initialized(document : Dynamic, id : String) : Void {
		_contextView ||= try cast(document, DisplayObjectContainer) catch(e:Dynamic) null;
		// if the contextView is bound it will only be set a frame later
		setTimeout(configureBuilder, 1);
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function configureBuilder() : Void {
		for(config in _configs/* AS3HX WARNING could not determine type for var: config exp: EIdent(_configs) type: Array<Dynamic>*/) {
			(isExtension(config)) ? _context.extend(config) : _context.configure(config);
		}

		_contextView && _context.configure(_contextView);
		_configs.length = 0;
	}

	function isExtension(object : Dynamic) : Bool {
		return (Std.is(object, IContextExtension)) || (Std.is(object, Class && _reflector.typeImplements(Type.getClass(object), IContextExtension)));
	}


	public function new() {
		_configs = [];
		_context = new Context();
		_reflector = new DescribeTypeReflector();
	}
}

