package entities 
{
	import flash.display.Sprite;
	import net.flashpunk.Entity;
	import main.GC;
	import main.GFX;
	import net.flashpunk.graphics.Graphiclist;
	
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author marc
	 */
	public class LiveCounter extends Entity 
	{
		private var sprite:Image = new Image(GFX.GFX_FLOWER);
		
		public function LiveCounter(startX:uint, startY:uint):void
		{
			super(startX, startY);
			layer = GC.LAYER_INFOS;
			graphic = sprite;
			type = "livecounter";
		}
		
	}

}