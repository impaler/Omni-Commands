package omni.commands.commands {

import flash.utils.clearTimeout;
import flash.utils.setTimeout;

import omni.commands.Command;

/**
 * Sets a pause into a omni.command
 *
 */
public class PauseCommand extends Command {
	protected var _timeout:uint;
	protected var _duration:int;

	public function PauseCommand (duration:Number) {
		super ();
		_duration = duration;
	}

	override public function execute ():void {
		clearTimeout (_timeout);
		_timeout = setTimeout (dispatchEnd,_duration);
	}

	override public function stop ():void {
		clearTimeout (_timeout);
	}

	override public function dispatchEnd ():void {
		clearTimeout (_timeout);
		super.dispatchEnd ();
	}

	public function get duration ():Number {
		return _duration;
	}

}
}
