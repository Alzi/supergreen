package worlds 
{
	import adobe.utils.CustomActions;
	import entities.*;
	import flash.display.InteractiveObject;
	import flash.geom.Rectangle;
	import main.*;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.World;
	import main.GV;
	import net.flashpunk.utils.Ease;
	import flash.geom.Point;
	import net.flashpunk.Sfx;
	
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
		private var enemyStartPoints:Vector.<Point> = new Vector.<Point>();
		
		//the 'home-zome' where the villains unpatiently await their awakening
		private var homePointsStack:Vector.<Point> = new Vector.<Point>;
		
		private var enemies:Vector.<Enemy> = new Vector.<Enemy>();
		private var enemySprites:Graphiclist = new Graphiclist();
		private var hero:Player;
		
		private var shakeTween:Alarm = new Alarm(20, onShakedScreen);
		private var looseGameTime:Alarm = new Alarm (200, onLoosingTimeUp);
		private var enemyJump:VarTween = new VarTween(onEnemyJumped);
		private var enemyLand:VarTween = new VarTween(onEnemyLanded);
		
		public var lifeCounter:LifeCounter;
		public var energyMixDisplay:EnergyMixCounter;
		
		public function Playground() 
		{
			super();
		}
				
		/**
		 * level-setup
		 */
		override public function begin():void {
			
			addTween(shakeTween);
			addTween(enemyJump);
			addTween(enemyLand);
			addTween(looseGameTime);
			
			add (new Background); //bg-picture
			lifeCounter = new LifeCounter(557, 319);
			add(lifeCounter);
			
			energyMixDisplay = new EnergyMixCounter(557, 105);
			add(energyMixDisplay);
			
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
					add(new Goody("Water",dataElement.@x, dataElement.@y));
					break;
					case 64:
					add(new Goody("Sun",dataElement.@x, dataElement.@y));
					break;
					case 96:
					add(new Goody("Wind",dataElement.@x, dataElement.@y));
					break;
				}
			}
			
			// save all possible Enemy-homepoints in a stack and shuffle it
			var collums:int = Math.floor(room.xmlData.ghostsHome.rect.@w / 32);
			var rows:int = Math.floor(room.xmlData.ghostsHome.rect.@h / 32);
			
			for (var c:int = 0; c < collums; c++) {
				for (var r:int = 0; r < rows; r++) {
					var point:Point = new Point(int(room.xmlData.ghostsHome.rect.@x) + c*32, int(room.xmlData.ghostsHome.rect.@y) + r*32);
					homePointsStack.push(point);
				}
			}
			
			FP.shuffle(homePointsStack);
					
			addGraphic (scoreText);
			addGraphic (enemySprites, GC.LAYER_ENEMIES);
			
			hero = new Player(room.playerStartX, room.playerStartY, this);
			add (hero);
			setEnemies();
			GV.reset();
			
		}
		
		private function onLoosingTimeUp():void {
			FP.world = new GameLost();
		}
		
		
		private function onEnemyJumped():void {
			enemyLand.tween(enemySprites, "y", 10, 20, Ease.backOut);
		}
		
		private function onEnemyLanded():void {
			enemyJump.tween(enemySprites, "y", - 10, 20, Ease.backOut);
		}
		
		private function onShakedScreen():void {
			FP.resetCamera();
			
		}		
		
		private function winGame():void {
			
			
		}
		
		private function looseGame():void {
			looseGameTime.start();
			getType("enemy", enemies);
			hero.active = false;
			
			for each (var e:Enemy in enemies) {
				e.active = false;
				enemySprites.add(e.graphic);
				e.visible = false;
				e.graphic.x = e.x;
				e.graphic.y = e.y;
			}
			enemyJump.tween(enemySprites, "y", - 10, 20, Ease.circOut);
		}
				
		public function checkIfGameLost():void {
			//TODO wait and make some wining / loosing - animation inside the level-screen 
			if (GV.lifes <= 1) {
				looseGame();
				//FP.world = new GameLost();
			}
		}
		
		public function setEnemiesAfraid():void {
			getType("enemy", enemies);
			for each (var e:Enemy in enemies) {
				e.isAfraid = true;
			}
		}
		
		public function setEnemiesNotAfraid():void {
			getType("enemy", enemies);
			for each (var e:Enemy in enemies) {
				e.isAfraid = false;
			}
		}
		
		public function setEnemies():void {
			this.getType("enemy", enemies);
			if (enemies.length > 0) {
				removeList(enemies);
			}
			add (new Enemy(homePointsStack, new Point(room.xmlData.ghostsStart.rect.@x, room.xmlData.ghostsStart.rect.@y), "Blacky"));
			add (new Enemy(homePointsStack, new Point(room.xmlData.ghostsStart.rect.@x, room.xmlData.ghostsStart.rect.@y), "Yelly"));
		}
		
		public function shakeScreen():void {
			shakeTween.start();
		}
		
		
		override public function update ():void {
			super.update();
			scoreText.text = String(GV.points);
			
			if (shakeTween.active) {
				camera.x = FP.rand(6) - 3;
				camera.y = FP.rand(6) - 3;
				//camera.x = camera.y = shakeTween.value;
			}
			
			//TODO wait and make some wining / loosing - animation inside the level-screen 
			
			
			if (typeCount("nuky") == 0) {
				SoundManager.i.stopLoop(SoundManager.i.superheroLoop);
				FP.world = new GameWon ();
			}
		}
	}
}
	