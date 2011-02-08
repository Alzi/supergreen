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
	 * 
	 * TODO provide consistency of sprite/spritemap vars in entities
	 * TODO check: startX und startY in every Entity -> int
	 * 
	 */
	public class Supergreen extends Engine
	{
		public function Supergreen():void 
		{
			super(GC.SCREEN_WIDTH, GC.SCREEN_HEIGHT, 64, true);
			FP.world = new Playground();
			//FP.console.enable();
			//FP.console.toggleKey = 111;
		}
		
		override public function init():void 
		{
			trace("I'm here!");
			
			//super.init();
		}
		
		
		
	}
	
}