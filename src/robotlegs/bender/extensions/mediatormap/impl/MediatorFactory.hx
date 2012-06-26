//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.impl;

import flash.events.EventDispatcher;
import flash.utils.Dictionary;
import org.swiftsuspenders.Injector;
import robotlegs.bender.extensions.mediatormap.api.IMediatorFactory;
import robotlegs.bender.extensions.mediatormap.api.IMediatorMapping;
import robotlegs.bender.extensions.mediatormap.api.MediatorFactoryEvent;
import robotlegs.bender.extensions.matching.ITypeFilter;
import robotlegs.bender.framework.impl.ApplyHooks;
import robotlegs.bender.framework.impl.GuardsApprove;

@:meta(Event(name="mediatorCreate",type="robotlegs.bender.extensions.mediatorMap.api.MediatorFactoryEvent"))
@:meta(Event(name="mediatorRemove",type="robotlegs.bender.extensions.mediatorMap.api.MediatorFactoryEvent"))
class MediatorFactory extends EventDispatcher, implements IMediatorFactory {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _mediators : Dictionary;
	var _injector : Injector;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(injector : Injector) {
		_mediators = new Dictionary();
		_injector = injector;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function getMediator(view : Dynamic, mapping : IMediatorMapping) : Dynamic {
		return (Reflect.field(_mediators, Std.string(view))) ? Reflect.field(Reflect.field(_mediators, Std.string(view)), Std.string(mapping)) : null;
	}

	public function createMediators(view : Dynamic, type : Class<Dynamic>, mappings : Array<Dynamic>) : Array<Dynamic> {
		var createdMediators : Array<Dynamic> = [];
		var filter : ITypeFilter;
		var mediator : Dynamic;
		for(mapping in mappings/* AS3HX WARNING could not determine type for var: mapping exp: EIdent(mappings) type: Array<Dynamic>*/) {
			mediator = getMediator(view, mapping);
			if(!mediator)  {
				filter = mapping.matcher;
				mapTypeForFilterBinding(filter, type, view);
				mediator = createMediator(view, mapping);
				unmapTypeForFilterBinding(filter, type, view);
			}
			if(mediator) 
				createdMediators.push(mediator);
		}

		return createdMediators;
	}

	public function removeMediators(view : Dynamic) : Void {
		var mediators : Dictionary = Reflect.field(_mediators, Std.string(view));
		if(mediators == null) 
			return;
		if(hasEventListener(MediatorFactoryEvent.MEDIATOR_REMOVE))  {
			for(mapping in Reflect.fields(mediators)) {
				dispatchEvent(new MediatorFactoryEvent(MediatorFactoryEvent.MEDIATOR_REMOVE, Reflect.field(mediators, mapping), view, try cast(mapping, IMediatorMapping) catch(e:Dynamic) null, this));
			}

		}
		This is an intentional compilation error. See the README for handling the delete keyword
		delete Reflect.field(_mediators, Std.string(view));
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function createMediator(view : Dynamic, mapping : IMediatorMapping) : Dynamic {
		var mediator : Dynamic = getMediator(view, mapping);
		if(mediator) 
			return mediator;
		if(guardsApprove(mapping.guards, _injector))  {
			mediator = _injector.getInstance(mapping.mediatorClass);
			_injector.map(mapping.mediatorClass).toValue(mediator);
			applyHooks(mapping.hooks, _injector);
			_injector.unmap(mapping.mediatorClass);
			addMediator(mediator, view, mapping);
		}
		return mediator;
	}

	function removeMediator(view : Dynamic, mapping : IMediatorMapping) : Void {
		var mediators : Dictionary = Reflect.field(_mediators, Std.string(view));
		if(mediators == null) 
			return;
		var mediator : Dynamic = Reflect.field(mediators, Std.string(mapping));
		if(!mediator) 
			return;
		This is an intentional compilation error. See the README for handling the delete keyword
		delete Reflect.field(mediators, Std.string(mapping));
		if(hasEventListener(MediatorFactoryEvent.MEDIATOR_REMOVE)) 
			dispatchEvent(new MediatorFactoryEvent(MediatorFactoryEvent.MEDIATOR_REMOVE, mediator, view, mapping, this));
	}

	function addMediator(mediator : Dynamic, view : Dynamic, mapping : IMediatorMapping) : Void {
		Reflect.field(_mediators, Std.string(view)) ||= new Dictionary();
		Reflect.setField(Reflect.setField(_mediators, Std.string(view), mediator), Std.string(mapping), );
		if(hasEventListener(MediatorFactoryEvent.MEDIATOR_CREATE)) 
			dispatchEvent(new MediatorFactoryEvent(MediatorFactoryEvent.MEDIATOR_CREATE, mediator, view, mapping, this));
	}

	function mapTypeForFilterBinding(filter : ITypeFilter, type : Class<Dynamic>, view : Dynamic) : Void {
		var requiredType : Class<Dynamic>;
		var requiredTypes : Vector<Class<Dynamic>> = requiredTypesFor(filter, type);
		for(requiredType in requiredTypes/* AS3HX WARNING could not determine type for var: requiredType exp: EIdent(requiredTypes) type: Vector<Class<Dynamic>>*/) {
			_injector.map(requiredType).toValue(view);
		}

	}

	function unmapTypeForFilterBinding(filter : ITypeFilter, type : Class<Dynamic>, view : Dynamic) : Void {
		var requiredType : Class<Dynamic>;
		var requiredTypes : Vector<Class<Dynamic>> = requiredTypesFor(filter, type);
		for(requiredType in requiredTypes/* AS3HX WARNING could not determine type for var: requiredType exp: EIdent(requiredTypes) type: Vector<Class<Dynamic>>*/) {
			if(_injector.map(requiredType)) 
				_injector.unmap(requiredType);
		}

	}

	function requiredTypesFor(filter : ITypeFilter, type : Class<Dynamic>) : Vector<Class<Dynamic>> {
		var requiredTypes : Vector<Class<Dynamic>> = filter.allOfTypes.concat(filter.anyOfTypes);
		if(requiredTypes.indexOf(type) == -1) 
			requiredTypes.push(type);
		return requiredTypes;
	}

}

