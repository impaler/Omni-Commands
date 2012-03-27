package omni.commands {

import org.osflash.signals.Signal;

/**
 * Used to script sequences of commands
 *
 */
public class CommandSequence implements ICommand {

	protected var _started:Signal;
	protected var _completed:Signal;
	protected var _error:Signal;
	protected var _nextCommandStarted:Signal;

	protected var _commands:Vector.<ICommand> = new Vector.<ICommand> ();
	protected var _isPlaying:Boolean = false;
	protected var _currentCommandIndex:int = 0;
	protected var _numberOfCommands:uint = 0;

	public function CommandSequence (commands:Array = null) {
		if (commands) {
			for (var i:int = 0; i < commands.length; i ++) {
				addCommand (commands[i]);
			}
		}
	}

	public function addCommand (command:ICommand):void {
		_commands.push (command);
		_numberOfCommands ++;
	}

	public function startNext ():void {
		if (_commands[_currentCommandIndex].isPlaying) {
			stopCurrentCommand ();
		}

		if (_currentCommandIndex >= _commands.length) {
			stop ();
		} else {
			var a:ICommand = _commands[_currentCommandIndex];
			a.completed.addOnce (onActionComplete);
			a.error.addOnce (dispatchError);
			a.isPlaying = true;
			a.start ();
		}
	}

	public function start ():void {
		if (_isPlaying) {
			stop ();
		}
		_currentCommandIndex = 0;
		_isPlaying = true;
		if (_started)started.dispatch ();

		execute ();
	}

	public function execute ():void {
		startNext ();
	}

	public function stop ():void {
		if (_isPlaying) {
			stopCurrentCommand ();
			_currentCommandIndex = - 1;
			_isPlaying = false;
		}
	}

	public function getCommandAt (index:int):ICommand {
		if (index < _commands.length && index > - 1)
			return _commands[index];

		return null;
	}

	public function removeCommand (command:ICommand):Boolean {
		for (var i:int = 0; i < _commands.length; i ++) {
			var commandCurrent:ICommand = _commands[i];
			if (command == commandCurrent) {
				_commands[i] = null;
				return true;
			}
		}
		return false
	}

	public function clear (destroy:Boolean = true):void {
		for each (var commandRef:ICommand in _commands) {
			commandRef.destroy ();
			commandRef = null;
		}
		_numberOfCommands = 0;
		_commands.length = 0;
	}

	protected function stopCurrentCommand ():void {
		if (_isPlaying && _currentCommandIndex < _commands.length) {
			var commandRef:ICommand = _commands[_currentCommandIndex];
			commandRef.completed.remove (onActionComplete);
			commandRef.stop ();
		}
	}

	protected function onActionComplete ():void {
		var commandRef:ICommand = _commands[_currentCommandIndex] as ICommand;
		commandRef.isPlaying = false;

		stopCurrentCommand ();

		if (++ _currentCommandIndex < _commands.length) {
			if(_nextCommandStarted) _nextCommandStarted.dispatch ();
			startNext ();
		} else {
			dispatchEnd ();
		}
	}

	public function dispatchEnd ():void {
		if (_completed) _completed.dispatch ();
	}

	public function dispatchError ():void {
		if (_error) _error.dispatch ();
	}

	public function get completed ():Signal {
		if (! _completed) _completed = new Signal ();
		return _completed;
	}

	public function get started ():Signal {
		if (! _started) _started = new Signal ();
		return _started;
	}

	public function get error ():Signal {
		if (! _error) _error = new Signal ();
		return _error;
	}

	public function get nextCommandStarted ():Signal {
		if (! _nextCommandStarted) _nextCommandStarted = new Signal ();
		return _nextCommandStarted;
	}

	public function get running ():Boolean {
		return _isPlaying;
	}

	public function get isPlaying ():Boolean {
		return _isPlaying;
	}

	public function set isPlaying (value:Boolean):void {
		_isPlaying = value;
	}

	public function get currentIndex ():int {
		return _currentCommandIndex;
	}

	public function clone ():CommandSequence {
		var chain:CommandSequence = new CommandSequence ();
		for (var i:int = 0; i < _commands.length; i ++) {
			chain.addCommand (_commands[i]);
		}

		return chain;
	}

	public function destroy ():void {
		for (var i:int = 0; i < _commands.length; i ++) {
			_commands[i].destroy ();
			_commands[i] = null;
		}
		_commands.length = 0;

		if (_completed)_completed.removeAll ();
		_completed = null;

		if (_started)_started.removeAll ();
		_started = null;

		if (_error)_error.removeAll ();
		_error = null;

		if (_nextCommandStarted)_nextCommandStarted.removeAll ();
		_nextCommandStarted = null;
	}

}

}
