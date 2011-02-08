package worlds 
{
	import adobe.utils.CustomActions;
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
	import flash.geom.Point;
	
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
		
		//TODO change to Point-Stack
		private var enemyStart:Rectangle = new Rectangle;
		
		//the 'home-zome' where the villains unpatiently await their awakening
		private var startPointsStack:Array = new Array;
		
		public function Playground() 
		{
			super();
		}
		
		
		
		/**
		 * level-setup
		 */
		override public function begin():void {
			
			add (new Background); //bg-picture
			add(room);			
			add(new EnemyRoom(GC.LEVEL_4));
			
			//add Goodies to Room
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
			
			// save all possible Enemy-homepoints in a stack and shuffle it
			var collums:int = Math.floor(room.xmlData.ghostsHome.rect.@w / 32);
			var rows:int = Math.floor(room.xmlData.ghostsHome.rect.@h / 32);
			
			for (var c:int = 0; c < collums; c++) {
				for (var r:int = 0; r < rows; r++) {
					var point:Point = new Point(int(room.xmlData.ghostsHome.rect.@x) + c*32, int(room.xmlData.ghostsHome.rect.@y) + r*32);
					startPointsStack.push(point);
				}
			}
			
			FP.shuffle(startPointsStack);
			
			with (enemyStart) {
				x = room.xmlData.ghostsStart.rect.@x;
				y = room.xmlData.ghostsStart.rect.@y;
				w = room.xmlData.ghostsStart.rect.@w;
				h = room.xmlData.ghostsStart.rect.@h;
			}
			
			addGraphic (scoreText);
			addGraphic (lifeText);
			
			add(new Player(room.playerStartX, room.playerStartY));
			//add enemies (pick one of the shuffled homePoints (max 4 in this level...))
			setEnemy(startPointsStack.shift(), "yellow" );
			setEnemy(startPointsStack.shift(), "black" );
		}
		
		override public function update ():void {
			super.update();
			scoreText.text = String(GV.points);
			lifeText.text = String(GV.lifes);
		}
		
		
		// this needs to be called from outside
		public function setEnemy(homePoint:Point, color:String):void {
			add (new Enemy(homePoint, enemyStart, color));
		}
	}
}