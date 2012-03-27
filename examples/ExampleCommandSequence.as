package {

import omni.commands.CommandSequence;
import omni.commands.commands.DelayedCallCommand;
import omni.commands.commands.FunctionCommand;

import flash.display.Sprite;

/**
 * This is an example of how to create a basic CommandSequence
 *
 */
public class ExampleCommandSequence extends Sprite {
	public function ExampleCommandSequence () {
		var chain:CommandSequence = new CommandSequence ();

		for (var i:int = 0; i < 100; i ++) {
			chain.addCommand (new FunctionCommand (traceTest,[i]));
			chain.addCommand (new DelayedCallCommand (1000,traceTest,[i," - delayed for 1000 ms"]));
		}

		chain.started.addOnce (function ():void {trace ("Started")});
		chain.completed.addOnce (function ():void {trace ("Completed")});
		chain.start ();
	}

	private static function traceTest (i:*,string:String = ""):void {
		trace ("Action " + i + string);
	}

}
}
