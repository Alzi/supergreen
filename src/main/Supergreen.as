package main
{
	import net.flashpunk.Engine;
	import main.GC;
	import net.flashpunk.FP;
	import worlds.level1;
	
	/**
	 * ...
	 * @author marc
	 */
	public class Supergreen extends Engine
	{
		
		public function Supergreen():void 
		{
			super(GC.SCREEN_WIDTH, GC.SCREEN_HEIGHT);
			FP.world = new level1;
		}
		
		override public function init():void 
		{
			trace("I'm here!");
			super.init();
		}
		
	}
	
}