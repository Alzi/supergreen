package entities 
{
	import net.flashpunk.Entity;
	import main.GC;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	/**
	 * ...
	 * @author marc
	 */
	public class Nuky extends Entity 
	{
		public function Nuky(startX:int, startY:int) 
		{
			super(startX, startY);
			layer = GC.LAYER_GOODIES;
			var tiles:Tilemap = new Tilemap(GC.GOODIES_TILES, GC.SCREEN_WIDTH, GC.SCREEN_HEIGHT, 32, 32);
			tiles.setTile(0, 0, 0);
			graphic = tiles;
			setHitbox(24, 24, -3, -3);
			type = "goody";
		}
	}
}