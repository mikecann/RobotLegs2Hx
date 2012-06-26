package robotlegs.bender.extensions.mediatormap.api;

import robotlegs.bender.extensions.matching.ITypeFilter;

class MediatorMappingError extends Error {
	public var typeFilter(getTypeFilter, never) : ITypeFilter;
	public var mediatorClass(getMediatorClass, never) : Class<Dynamic>;

	public function new(message : String, typeFilter : ITypeFilter, mediatorClass : Class<Dynamic>) {
		super(message);
		_typeFilter = typeFilter;
		_mediatorClass = mediatorClass;
	}

	var _typeFilter : ITypeFilter;
	public function getTypeFilter() : ITypeFilter {
		return _typeFilter;
	}

	var _mediatorClass : Class<Dynamic>;
	public function getMediatorClass() : Class<Dynamic> {
		return _mediatorClass;
	}

}

