package signalSendSpeed {
import flash.geom.Point;

/**
 * COMMENT
 * @author Raimundas Banevicius (raima156@yahoo.com)
 */
public class SignalVO {
	public var testData:String;
	public var testInt:int;
	public var testNr:Number;
	public var testArray:Array;
	public var testPoint:Point;
	
	public function SignalVO(testData:String, testInt:int, testNr:Number, testArray:Array, testPoint:Point) {
		this.testData = testData;
		this.testInt = testInt;
		this.testNr = testNr;
		this.testArray = testArray;
		this.testPoint = testPoint;
	
	}

}
}