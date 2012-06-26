//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.messagecommandmap;

import robotlegs.bender.extensions.messagecommandmap.api.IMessageCommandMap;
import robotlegs.bender.extensions.messagecommandmap.impl.MessageCommandMap;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IContextExtension;

class MessageCommandMapExtension implements IContextExtension {

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function extend(context : IContext) : Void {
		context.injector.map(IMessageCommandMap).toSingleton(MessageCommandMap);
	}


	public function new() {
	}
}

