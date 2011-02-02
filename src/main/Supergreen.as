package main
{
	import net.flashpunk.Engine;
	import main.GC;
	
	/**
	 * ...
	 * @author Alzi
	 */
	public class Supergreen extends Engine
	{
		
		public function Supergreen():void 
		{
			super(GC.SCREEN_WIDTH, GC.SCREEN_HEIGHT);
		}
		
		override public function init():void 
		{
			trace("I'm here!");
			super.init();
		}
		
	}
	
}