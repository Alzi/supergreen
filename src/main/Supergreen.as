package main
{
	import net.flashpunk.Engine;
	import main.GC;
	import net.flashpunk.FP;
	import worlds.Playground;
	import flash.utils.*;
	
	/**
	 * ...
	 * @author marc
	 */
	public class Supergreen extends Engine
	{
		
		public function Supergreen():void 
		{
			super(GC.SCREEN_WIDTH, GC.SCREEN_HEIGHT, 64, true);
			FP.world = new Playground();
		}
		
		override public function init():void 
		{
			trace("I'm here!");
			super.init();
			//FP.console.toggleKey = 111;
			//FP.console.enable();
		}
		
	}
	
}