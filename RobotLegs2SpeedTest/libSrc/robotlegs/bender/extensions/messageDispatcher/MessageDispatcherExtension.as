//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.messageDispatcher
{
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;
	import robotlegs.bender.framework.api.IMessageDispatcher;
	import robotlegs.bender.framework.impl.MessageDispatcher;

	public class MessageDispatcherExtension implements IExtension
	{

		//============================================================================
		/* Private Properties                                                         */
		//============================================================================

		private var _messageDispatcher:IMessageDispatcher;

		//============================================================================
		/* Constructor                                                                */
		//============================================================================

		public function MessageDispatcherExtension(messageDispatcher:IMessageDispatcher = null)
		{
			_messageDispatcher = messageDispatcher || new MessageDispatcher();
		}

		//============================================================================
		/* Public Functions                                                           */
		//============================================================================

		public function extend(context:IContext):void
		{
			context.injector.map(IMessageDispatcher).toValue(_messageDispatcher);
		}

	}
}
