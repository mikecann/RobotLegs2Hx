//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.commandmap;

import robotlegs.bender.extensions.commandmap.api.ICommandMap;
import robotlegs.bender.extensions.commandmap.impl.CommandMap;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IContextExtension;

class CommandMapExtension implements IContextExtension {

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function extend(context : IContext) : Void {
		context.injector.map(ICommandMap).toSingleton(CommandMap);
	}


	public function new() {
	}
}

