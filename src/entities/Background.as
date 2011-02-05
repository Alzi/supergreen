package entities 
{
	import flash.display.BitmapData;
	import flash.events.TextEvent;
	import main.GC;
	import main.GFX;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author marc
	 */
	
	public class Background extends Entity 
	{
		
		private var bg:Image = new Image(GFX.GFX_BACKGROUND);
		public function Background() 
		{
			layer = GC.LAYER_BACKGROUND;
			graphic = bg;
		}
		
	}

}