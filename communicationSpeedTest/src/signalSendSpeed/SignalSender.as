package signalSendSpeed {
import constants.TestConfig;
import flash.display.Sprite;
import flash.geom.Point;
import org.osflash.signals.Signal;

/**
 * COMMENT
 * @author Raimundas Banevicius (raima156@yahoo.com)
 */
public class SignalSender extends Sprite {
	
	public var simpleSignal:Signal = new Signal(String);
	
	public var complexSignal:Signal = new Signal(SignalVO);
	
	public function SignalSender() {
	
	}
	
	public function runTest():void {
		for (var i:int = 0; i < TestConfig.MESSAGE_COUNT; i++) {
			simpleSignal.dispatch(TestConfig.SIMPLE_STRING);
		}
	}
	
	public function runComplexTest():void {
		for (var i:int = 0; i < TestConfig.MESSAGE_COUNT; i++) {
			complexSignal.dispatch(new SignalVO(TestConfig.COMPlEX_STRING, TestConfig.COMPlEX_INT, TestConfig.COMPlEX_NUMBER, TestConfig.COMPlEX_ARRAY, TestConfig.COMPlEX_POINT));
		}
	}

}
}