//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.localeventmap;

import robotlegs.bender.extensions.localeventmap.api.IEventMap;
import robotlegs.bender.extensions.localeventmap.impl.EventMap;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IContextExtension;

/**
 * todo: extension description
 */class LocalEventMapExtension implements IContextExtension {

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function extend(context : IContext) : Void {
		context.injector.map(IEventMap).toType(EventMap);
	}


	public function new() {
	}
}

