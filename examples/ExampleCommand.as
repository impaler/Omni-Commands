package {

import omni.commands.Command;

/**
 * This is an example of how to create a new omni.command, extend upon this for your needs.
 *
 */
public class ExampleCommand extends Command {
	public function ExampleCommand () {
		super ();
	}

	override public function execute ():void {
		// Put your main omni.command code here.

		// Make sure to call dispatchEnd(); when the omni.command code is completed for this to work in sequences etc
	}

	override public function stop ():void {
		super.stop ();
		// Put your code here to abort the omni.command.
	}

	override public function destroy ():void {
		super.destroy ();
		// Put your garbage collection code in here.
	}

}
}
