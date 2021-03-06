package com.mindscriptact.robotLegs2Test.controller.testing {
import com.mindscriptact.robotLegs2Test.model.MockModel;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class RobotWithModelCommViewsCommand  {
	
	[Inject]
	public var mockModel:MockModel;
	
	public function execute():void {
		//trace( "RobotWithModelCommViewsCommand.execute" );
		mockModel.invokeMediator();
	}

}
}