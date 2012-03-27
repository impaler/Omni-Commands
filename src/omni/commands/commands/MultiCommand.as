package omni.commands.commands {

import omni.commands.Command;
import omni.commands.ICommand;

/**
 * Plays multiple commands in parallel
 *
 */
public class MultiCommand extends Command {

	protected var _commands:Vector.<ICommand> = new Vector.<ICommand> ();
	protected var _numberCompleted:uint = 0;

	public function MultiCommand (commands:Array = null) {
		super ();
		if (commands) {
			for (var i:int = 0; i < commands.length; i ++) {
				addCommand (commands[i])
			}
		}
	}

	public function addCommand (commandToAdd:ICommand):void {
		_commands.push (commandToAdd);
	}

	override public function destroy ():void {
		super.destroy ();
		stop ();
		_commands.length = 0;
		_commands = null;
	}

	override public function stop ():void {
		for each (var commandRef:ICommand in _commands) {
			commandRef.completed.remove (onCommandComplete);
			commandRef.stop ();
		}
	}

	override public function start ():void {
		super.start ();
		_numberCompleted = 0;
		for each (var commandRef:ICommand in _commands) {
			commandRef.completed.addOnce (onCommandComplete);
			commandRef.start ();
		}
	}

	protected function onCommandComplete ():void {
		if (++ _numberCompleted >= _commands.length)
			_completed.dispatch ();
	}

}
}
