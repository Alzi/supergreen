package worlds 
{
	import entities.*;
	import flash.geom.Rectangle;
	import main.*;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.tweens.misc.Alarm;
	import main.GFX;
	
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
			var room:Room = new Room(GC.LEVEL_4);
			add(room);
			add(new Player(room.playerStartX, room.playerStartY));
			add(new EnemyRoom(GC.LEVEL_4));
					
			
			// add Goodies
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
			
			var enemyHome:Rectangle = 
				new Rectangle(room.xmlData.ghostsHome.rect.@x,
							  room.xmlData.ghostsHome.rect.@y,
							  room.xmlData.ghostsHome.rect.@w,
							  room.xmlData.ghostsHome.rect.@h);
			
			var enemyStart:Rectangle = 
				new Rectangle(room.xmlData.ghostsStart.rect.@x,
							  room.xmlData.ghostsStart.rect.@y,
							  room.xmlData.ghostsStart.rect.@w,
							  room.xmlData.ghostsStart.rect.@h);
							  
							  
							  
			
			
			//add enemies
			add(new Enemy(enemyHome, enemyStart, "yellow"));
			add(new Enemy(enemyHome, enemyStart, "black"));
			
			
			
			addGraphic(scoreText);
		}
		
		
		
			
		
		override public function update ():void {
			scoreText.text = String(GV.points);
			super.update();
		}
		
	}

}