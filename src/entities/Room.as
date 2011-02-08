package entities 
{
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.graphics.Tilemap;
	import main.GC;
	import main.GFX;
	/**
	 * ...
	 * @author marc
	 */
	public class Room extends Entity
	{
		public var roomTiles:Tilemap = new Tilemap(GFX.GFX_LEVELTILES, GC.SCREEN_WIDTH, GC.SCREEN_HEIGHT, 32, 32);
		public var goodies:Tilemap = new Tilemap(GFX.GFX_GOODIES, GC.SCREEN_WIDTH, GC.SCREEN_HEIGHT, 32, 32);
		public var blockedGrid:Grid = new Grid(GC.SCREEN_WIDTH, GC.SCREEN_HEIGHT, 32, 32, 0, 0);
		public var playerStartX:int;
		public var playerStartY:int;
		public var xmlData:XML; 
				
		private var rawData:ByteArray;
		private	var byteString:String; 
		private var dataElement:XML;
		private	var dataList:XMLList = new XMLList();
		
		public function Room(level:Class):void
		{
			//read Level-Data
			rawData = ByteArray(new level);
			byteString = rawData.readUTFBytes(rawData.length);
			xmlData = new XML(byteString);
			dataList = xmlData.walls.tile;
			for each (dataElement in dataList) {
				roomTiles.setTile(dataElement.@x / 32, dataElement.@y / 32, dataElement.@tx/32 + GC.ROOM_TILES_COLLUMS*(dataElement.@ty / 32));
			}
			//building Collision-mask
			dataList = xmlData.blocked.rect;
			for each (dataElement in dataList) {
				blockedGrid.setRect(dataElement.@x / 32, dataElement.@y / 32, dataElement.@w / 32, dataElement.@h / 32, true);
			}
			graphic = roomTiles;
			mask = blockedGrid;
			layer = GC.LAYER_ROOM;
			type = "room";
			
			playerStartX = xmlData.playerstart.rect.@x;
			playerStartY = xmlData.playerstart.rect.@y;
		}
	}
}