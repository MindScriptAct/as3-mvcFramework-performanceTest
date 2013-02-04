//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.viewProcessorMap
{
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.extensions.viewManager.api.IViewHandler;
	import robotlegs.bender.extensions.viewManager.api.IViewManager;
	import robotlegs.bender.extensions.viewProcessorMap.api.IViewProcessorMap;
	import robotlegs.bender.extensions.viewProcessorMap.impl.IViewProcessorFactory;
	import robotlegs.bender.extensions.viewProcessorMap.impl.ViewProcessorFactory;
	import robotlegs.bender.extensions.viewProcessorMap.impl.ViewProcessorMap;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;

	/**
	 * This extension install a View Processor Map into a context
	 */
	public class ViewProcessorMapExtension implements IExtension
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _injector:Injector;

		private var _viewProcessorMap:IViewProcessorMap;

		private var _viewManager:IViewManager;

		private var _viewProcessorFactory:IViewProcessorFactory;

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function extend(context:IContext):void
		{
			_injector = context.injector;
			_injector.map(IViewProcessorFactory).toValue(new ViewProcessorFactory(_injector.createChildInjector()));
			_injector.map(IViewProcessorMap).toSingleton(ViewProcessorMap);
			context.beforeInitializing(beforeInitializing);
			context.beforeDestroying(beforeDestroying);
			context.whenDestroying(whenDestroying);
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function beforeInitializing():void
		{
			_viewProcessorMap = _injector.getInstance(IViewProcessorMap);
			_viewProcessorFactory = _injector.getInstance(IViewProcessorFactory);
			if (_injector.satisfiesDirectly(IViewManager))
			{
				_viewManager = _injector.getInstance(IViewManager);
				_viewManager.addViewHandler(_viewProcessorMap as IViewHandler);
			}
		}

		private function beforeDestroying():void
		{
			_viewProcessorFactory.runAllUnprocessors();

			if (_injector.satisfiesDirectly(IViewManager))
			{
				_viewManager = _injector.getInstance(IViewManager);
				_viewManager.removeViewHandler(_viewProcessorMap as IViewHandler);
			}
		}

		private function whenDestroying():void
		{
			if (_injector.satisfiesDirectly(IViewProcessorMap))
			{
				_injector.unmap(IViewProcessorMap);
			}
			if (_injector.satisfiesDirectly(IViewProcessorFactory))
			{
				_injector.unmap(IViewProcessorFactory);
			}
		}
	}
}
