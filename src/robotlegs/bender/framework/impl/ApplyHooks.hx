//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import org.swiftsuspenders.Injector;

class ApplyHooks {

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	/**
	 * <p>A hook can be a function, object or class.</p>
	 *
	 * <p>When an object is passed it is expected to expose a "hook" method.</p>
	 *
	 * <p>When a class is passed, an instance of that class will be instantiated and called.
	 * If an injector is provided the instance will be created using that injector,
	 * otherwise the instance will be created manually.</p>
	 *
	 * @param hooks An array of hooks
	 * @param injector An optional Injector
	 */	static public function applyHooks(hooks : Array<Dynamic>, injector : Injector = null) : Void {
		for(hook in hooks/* AS3HX WARNING could not determine type for var: hook exp: EIdent(hooks) type: Array<Dynamic>*/) {
			if(Std.is(hook, Class))  {
				hook = (injector) ? injector.getInstance(Type.getClass(hook)) : new Hook();
				hook.hook();
			}

			else if(Std.is(hook, Function))  {
				hook();
			}

			else  {
				hook.hook();
			}

		}

	}


	public function new() {
	}
}

