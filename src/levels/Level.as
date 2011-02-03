package levels 
{
	import flash.display.Graphics;
	import main.GC;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author marc
	 */
	public class Level extends Entity 
	{
		protected var _roomTiles:Tilemap = new Tilemap(GC.ROOM_TILES, GC.SCREEN_WIDTH, GC.SCREEN_HEIGHT, 32, 32);
		private var _blockedGrid:Grid = new Grid(GC.SCREEN_WIDTH, GC.SCREEN_HEIGHT, 32, 32, 0, 0);
		
		public function Level(xml:Class) 
		{
			
			layer = 1;
			type = "blocked";
			mask = _blockedGrid;
			graphic = _roomTiles;
			
			
			//_roomTiles.setTile(2, 3, 1);
			//_roomTiles.setRect(3, 3, 3, 1, 2);
			//_roomTiles.setTile(6, 3, 3);
			
			
			// Grid-mask as Collision-Map
			//_blockedGrid.setTile(2, 3, true)
			//_blockedGrid.setRect(3, 3, 3, 1,true);
			//_blockedGrid.setTile(6, 3, true);
			
			loadLevel(xml);
		}
		
		private function loadLevel(xml:Class):void {
			
			var rawData:ByteArray = ByteArray(new xml);
			var byteString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(byteString);
			var dataElement:XML;
			var dataList:XMLList = new XMLList();
			dataList = xmlData.blocked.rect;
			
			
			for each (dataElement in dataList) {
				_roomTiles.setRect(dataElement.@x / 32, dataElement.@y / 32, dataElement.@w / 32, dataElement.@h / 32);
				_blockedGrid.setRect(dataElement.@x / 32, dataElement.@y / 32, dataElement.@w / 32, dataElement.@h / 32);
			}
			
		}
		
		
		
	}

}