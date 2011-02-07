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
	public class EnemyRoom extends Entity
	{
		public var blockedGrid:Grid = new Grid(GC.SCREEN_WIDTH, GC.SCREEN_HEIGHT, 32, 32, 0, 0);
		public var xmlData:XML; 
		private var rawData:ByteArray;
		private	var byteString:String; 
		private var dataElement:XML;
		private	var dataList:XMLList = new XMLList();
		
		public function EnemyRoom(level:Class):void
		{
			super();
			//read Level-Data
			rawData = ByteArray(new level);
			byteString = rawData.readUTFBytes(rawData.length);
			xmlData = new XML(byteString);
			
			//building Collision-mask
			dataList = xmlData.ghostsBlocked.rect;
			for each (dataElement in dataList) {
				blockedGrid.setRect(dataElement.@x / 32, dataElement.@y / 32, dataElement.@w / 32, dataElement.@h / 32, true);
			}
			mask = blockedGrid;
			type = "enemy-room";
		}
	}
}