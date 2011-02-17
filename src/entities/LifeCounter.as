package entities 
{
	import flash.display.Sprite;
	import flash.events.IMEEvent;
	import net.flashpunk.Entity;
	import main.GC;
	import main.GFX;
	import main.GV;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author marc
	 */
	public class LifeCounter extends Entity 
	{
		private var life1:Image = new Image(GFX.GFX_FLOWER);
		private var life2:Image = new Image(GFX.GFX_FLOWER);
		private var life3:Image = new Image(GFX.GFX_FLOWER);
		private var allLifes:Graphiclist = new Graphiclist(life1, life2, life3);
				
		public function LifeCounter(startX:uint, startY:uint):void
		{
			super(startX, startY);
			layer = GC.LAYER_INFOS;
			graphic = allLifes;
			life1.x = 0;
			life2.x = 23;
			life3.x = 46;
			type = "livecounter";
		}
		
		public function looseLife():void {
			if (GV.lifes > 0) {
				this["life"+GV.lifes].visible = false;
			}
		}
		
		
	}

}