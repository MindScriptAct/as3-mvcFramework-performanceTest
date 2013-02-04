//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.mediatorMap.impl
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import robotlegs.bender.extensions.matching.ITypeMatcher;
	import robotlegs.bender.extensions.matching.TypeMatcher;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorFactory;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorViewHandler;
	import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorMapper;
	import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorUnmapper;
	import robotlegs.bender.extensions.viewManager.api.IViewHandler;

	public class MediatorMap implements IMediatorMap, IViewHandler
	{

		//============================================================================
		/* Private Properties                                                         */
		//============================================================================

		private const _mappers:Dictionary = new Dictionary();

		private var _handler:IMediatorViewHandler;

		private var _factory:IMediatorFactory;

		private const NULL_UNMAPPER:IMediatorUnmapper = new NullMediatorUnmapper();

		//============================================================================
		/* Constructor                                                                */
		//============================================================================

		public function MediatorMap(factory:IMediatorFactory, handler:IMediatorViewHandler = null)
		{
			_factory = factory;
			_handler = handler || new MediatorViewHandler(_factory);
		}

		//============================================================================
		/* Public Functions                                                           */
		//============================================================================

		public function mapMatcher(matcher:ITypeMatcher):IMediatorMapper
		{
			return _mappers[matcher.createTypeFilter().descriptor] ||= createMapper(matcher);
		}

		public function map(type:Class):IMediatorMapper
		{
			return mapMatcher(new TypeMatcher().allOf(type));
		}

		public function unmapMatcher(matcher:ITypeMatcher):IMediatorUnmapper
		{
			return _mappers[matcher.createTypeFilter().descriptor] || NULL_UNMAPPER;
		}

		public function unmap(type:Class):IMediatorUnmapper
		{
			return unmapMatcher(new TypeMatcher().allOf(type));
		}

		public function handleView(view:DisplayObject, type:Class):void
		{
			_handler.handleView(view, type);
		}

		public function mediate(item:Object):void
		{
			_handler.handleItem(item, item.constructor as Class);
		}

		public function unmediate(item:Object):void
		{
			_factory.removeMediators(item);
		}

		//============================================================================
		/* Private Functions                                                          */
		//============================================================================

		private function createMapper(matcher:ITypeMatcher):IMediatorMapper
		{
			return new MediatorMapper(matcher.createTypeFilter(), _handler);
		}
	}
}