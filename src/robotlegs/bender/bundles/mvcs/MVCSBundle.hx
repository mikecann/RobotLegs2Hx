//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.bundles.mvcs;

import robotlegs.bender.bundles.shared.configs.ContextViewListenerConfig;
import robotlegs.bender.extensions.commandmap.CommandMapExtension;
import robotlegs.bender.extensions.contextview.ContextViewExtension;
import robotlegs.bender.extensions.eventcommandmap.EventCommandMapExtension;
import robotlegs.bender.extensions.eventdispatcher.EventDispatcherExtension;
import robotlegs.bender.extensions.localeventmap.LocalEventMapExtension;
import robotlegs.bender.extensions.logging.LoggingExtension;
import robotlegs.bender.extensions.logging.TraceLoggingExtension;
import robotlegs.bender.extensions.mediatormap.MediatorMapExtension;
import robotlegs.bender.extensions.modularity.ModularityExtension;
import robotlegs.bender.extensions.stagesync.StageSyncExtension;
import robotlegs.bender.extensions.viewmanager.ManualStageObserverExtension;
import robotlegs.bender.extensions.viewmanager.StageObserverExtension;
import robotlegs.bender.extensions.viewmanager.ViewManagerExtension;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IContextExtension;

/**
 * For that Classic Robotlegs flavour
 *
 * <p>This bundle installs a number of extensions commonly used in typical Robotlegs
 * applications and modules.</p>
 */class MVCSBundle implements IContextExtension {

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function extend(context : IContext) : Void {
		context.extend(LoggingExtension, TraceLoggingExtension, ContextViewExtension, EventDispatcherExtension, ModularityExtension, StageSyncExtension, CommandMapExtension, EventCommandMapExtension, LocalEventMapExtension, ViewManagerExtension, StageObserverExtension, ManualStageObserverExtension, MediatorMapExtension);
		context.configure(ContextViewListenerConfig);
	}


	public function new() {
	}
}

