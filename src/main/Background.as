package main 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.IMEEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author marc
	 */
	public class Background extends Entity 
	{
		
		[Embed(source = '../assets/gfx/goodies.png')]
		private const BG:Class;
		
		private var bg:Image = new Image(new BitmapData(GC.SCREEN_WIDTH, GC.SCREEN_HEIGHT, true, 0xff000000));
		public function Background() 
		{
			layer = 1000;
			graphic = bg;
		}
		
	}

}