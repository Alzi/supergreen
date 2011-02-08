package worlds 
{
	import entities.*;
	import flash.display.InteractiveObject;
	import flash.geom.Rectangle;
	import main.*;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Tween;
	import net.flashpunk.World;
	import main.GV;
	import net.flashpunk.utils.Ease;
	
	import net.flashpunk.tweens.motion.LinearMotion;
	
	/**
	 * ...
	 * @author marc
	 * The game-level.
	 * By now it isn't planned to have more than one.
	 * The player stays in this world until he/she looses 3 lifes
	 * everytime a player dies, the ghosts and the player are reset to their home
	 */
	public class Playground extends World 
	{
		private var room:Room = new Room(GC.LEVEL_4);
		private var scoreText:Text = new Text("0", 560, 408, 150, 20);
		
		//TODO implement a graphical life-counter
		private var lifeText:Text = new Text("3", 560, 319, 150, 20);
		
		//the 'home-zome' where the villains unpatiently await their awakening
		private var enemyHome:Rectangle = new Rectangle;
		private var enemyStart:Rectangle = new Rectangle;
		
		private var colorStack:Array;
		
		public function Playground() 
		{
			
		}
			
		/**
		 * level-setup
		 */
		override public function begin():void {
			
			add (new Background);
			add(room);			
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
			
			with (enemyHome) {
				x = room.xmlData.ghostsHome.rect.@x;
				y = room.xmlData.ghostsHome.rect.@y;
				w = room.xmlData.ghostsHome.rect.@w;
				h = room.xmlData.ghostsHome.rect.@h;
			}
			
			with (enemyStart) {
				x = room.xmlData.ghostsStart.rect.@x;
				y = room.xmlData.ghostsStart.rect.@y;
				w = room.xmlData.ghostsStart.rect.@w;
				h = room.xmlData.ghostsStart.rect.@h;
			}
			
			addGraphic (scoreText);
			addGraphic (lifeText);
			
			fillWithLife();
		}
		
		override public function update ():void {
			super.update();
			scoreText.text = String(GV.points);
			lifeText.text = String(GV.lifes);
			
		}
		
		private function fillWithLife():void {
			add(new Player(room.playerStartX, room.playerStartY));
			
			//add enemies
			setGhost("yellow");
			setGhost("black");
		}
		
		public function setGhost(color:String):void {
			trace ("setGhost!");
			var startX:int = Math.floor((FP.rand(enemyHome.width) + enemyHome.x) / 32) * 32;
			var startY:int = Math.floor((FP.rand(enemyHome.height) + enemyHome.y) / 32) * 32;
			add(new Enemy(startX, startY, enemyStart, color));
		}
		
		
		
	}

}