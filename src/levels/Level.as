package levels 
{
	import flash.display.Graphics;
	import main.GC;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	/**
	 * ...
	 * @author marc
	 */
	public class Level extends Entity 
	{
		protected var _roomTiles:Tilemap = new Tilemap(GC.ROOM_TILES, GC.SCREEN_WIDTH, GC.SCREEN_HEIGHT, 32, 32);
		private var _blockedGrid:Grid = new Grid(GC.SCREEN_WIDTH, GC.SCREEN_HEIGHT, 32, 32, 0, 0);
		
		public function Level() 
		{
			
			layer = 1;
			type = "blocked";
			mask = _blockedGrid;
			graphic = _roomTiles;
			
			
			_roomTiles.setTile(2, 3, 1);
			_roomTiles.setRect(3, 3, 3, 1, 2);
			_roomTiles.setTile(6, 3, 3);
			
			
			// Grid-mask as Collision-Map
			_blockedGrid.setTile(2, 3, true)
			_blockedGrid.setRect(3, 3, 3, 1,true);
			_blockedGrid.setTile(6, 3, true);
			
		}
		
		
		
	}

}