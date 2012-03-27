package omni.commands.commands {

import omni.commands.Command;

/**
 * Basic Command to call a defined function with parameters.
 *
 */
public class FunctionCommand extends Command {
	protected var _function:Function;
	protected var _params:Array;

	public function FunctionCommand (func:Function,params:Array = null) {
		super ();
		_function = func;
		_params = params;
	}

	override public function execute ():void {
		_function.apply (null,_params);
		dispatchEnd ();
	}

	override public function destroy ():void {
		_function = null;
		_params.length = 0;
		_params = null;
		super.destroy ();
	}
}
}
