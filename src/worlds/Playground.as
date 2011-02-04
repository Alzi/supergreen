package worlds 
{
	import entities.Nuky;
	import entities.Player;
	import entities.Room;
	import main.Background;
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import levels.Level1;
	import main.GC;
	
	
	/**
	 * ...
	 * @author marc
	 */
	public class Playground extends World 
	{
		public function Playground() 
		{
			var room:Room = new Room(GC.LEVEL_1);
			add(room);
			add(new Player(room.playerStartX, room.playerStartY));
			
			var dataList:XMLList = new XMLList;
			dataList = room.xmlData.goodies.tile;
			var dataElement:XML;
			for each (dataElement in dataList) {
				//trace (dataElement.@x);
				if (dataElement.@tx == 0 && dataElement.@ty == 0) {
					add(new Nuky(dataElement.@x, dataElement.@y));
				}
			}
			
		}
		
	}

}