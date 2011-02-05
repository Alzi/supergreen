package worlds 
{
	import entities.*;
	import main.*;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	
	
	
	/**
	 * ...
	 * @author marc
	 */
	public class Playground extends World 
	{
		private var scoreText:Text = new Text("0",560,408,150,20);
		public function Playground() 
		{
			add (new Background);
			var room:Room = new Room(GC.LEVEL_3);
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
			
			addGraphic(scoreText);
			
		}
		
		override public function update ():void {
			super.update();
			scoreText.text = String(GV.points);
		}
		
	}

}