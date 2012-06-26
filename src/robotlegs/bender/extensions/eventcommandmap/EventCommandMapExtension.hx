//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.eventcommandmap;

import robotlegs.bender.extensions.eventcommandmap.api.IEventCommandMap;
import robotlegs.bender.extensions.eventcommandmap.impl.EventCommandMap;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IContextExtension;

class EventCommandMapExtension implements IContextExtension {

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function extend(context : IContext) : Void {
		context.injector.map(IEventCommandMap).toSingleton(EventCommandMap);
	}


	public function new() {
	}
}

