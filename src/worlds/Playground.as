package worlds 
{
	import entities.*;
	import main.*;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.tweens.misc.Alarm;
	
	
	
	/**
	 * ...
	 * @author marc
	 * 
	 * 
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
			add(new Enemy(96 + 32, 96));
			add(new Enemy(96 + 32, 96));
			
					
			
			var dataList:XMLList = new XMLList;
			dataList = room.xmlData.goodies.tile;
			var dataElement:XML;
			
			 
			for each (dataElement in dataList) {
				
				// is possible, cause all gfx set in level-editor are in first row
				switch (uint(dataElement.@tx)) {
					case 0:
					add(new Nuky(dataElement.@x, dataElement.@y));
					break;
					case 32:
					add(new Goody("water",dataElement.@x, dataElement.@y));
					break;
					case 64:
					add(new Goody("sun",dataElement.@x, dataElement.@y));
					break;
					case 96:
					add(new Goody("wind",dataElement.@x, dataElement.@y));
					break;
				}
			}
			
			addGraphic(scoreText);
		}
		
		override public function update ():void {
			scoreText.text = String(GV.points);
			super.update();
		}
		
	}

}