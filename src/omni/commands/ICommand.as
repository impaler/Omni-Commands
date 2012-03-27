package omni.commands {

import org.osflash.signals.Signal;

/**
 * The interface for Commands
 *
 */
public interface ICommand {

	function stop ():void;

	function destroy ():void;

	function start ():void;

	function execute ():void;

	function dispatchEnd ():void;

	function dispatchError():void;

	function get completed ():Signal;

	function get error ():Signal;

	function get started ():Signal;

	function get isPlaying ():Boolean;

	function set isPlaying (value:Boolean):void;

}

}
