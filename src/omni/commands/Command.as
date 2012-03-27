package omni.commands {

import org.osflash.signals.Signal;

/**
 * Base for Commands to extend upon
 *
 */
public class Command implements ICommand {
	protected var _started:Signal;
	protected var _completed:Signal;
	protected var _error:Signal;

	protected var _isPlaying:Boolean = false;

	public function Command () {
		super ();
	}

	public function start ():void {
		if (_started) _started.dispatch ();
		execute ();
	}

	public function execute ():void {
		//put your custom code to execute here

		//when code completed make sure you include;
		//dispatchEnd (); to signal that this omni.command is completed
	}

	public function stop ():void {
	}

	public function dispatchEnd ():void {
		if (_completed) _completed.dispatch ();
	}

	public function dispatchError ():void {
		if (_error) _error.dispatch ();
	}

	public function get error ():Signal {
		if (! _error) _error = new Signal ();
		return _error;
	}

	public function get completed ():Signal {
		if (! _completed) _completed = new Signal ();
		return _completed;
	}

	public function get started ():Signal {
		if (! _started) _started = new Signal ();
		return _started;
	}

	public function get isPlaying ():Boolean {
		return _isPlaying;
	}

	public function set isPlaying (value:Boolean):void {
		if (value !== _isPlaying) {
			_isPlaying = value;
		}
	}

	public function destroy ():void {
		if (_completed)_completed.removeAll ();
		_completed = null;

		if (_started)_started.removeAll ();
		_started = null;

		if (_error)_error.removeAll ();
		_error = null;
	}

}

}
