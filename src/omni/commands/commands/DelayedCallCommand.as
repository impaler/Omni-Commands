package omni.commands.commands {

import omni.commands.CommandSequence;

/**
 * Combines a PauseCommand and a FunctionCommand to make a delayed function call.
 *
 */
public class DelayedCallCommand extends CommandSequence {
	public function DelayedCallCommand ($nTime:Number,$call:Function,$params:Array = null) {
		var pause:PauseCommand = new PauseCommand ($nTime);
		var functionCommand:FunctionCommand = new FunctionCommand ($call,$params);

		super ([pause,functionCommand]);
	}
}
}
