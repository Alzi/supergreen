package entities 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import main.GFX;
	import main.GC;
	import main.GV;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import worlds.Playground;
	import entities.EnemyGhost;
	import main.SoundManager;
	
	/**
	 * 
	 * The little ghost should be able to do some things:
	 * moving:
	 * random movement, decide if change of direction should occur at crossroads, checking collision ahead
	 * 
	 * //TODO fleeing:
	 * if the Hero eats a goody and consequently has superpowers with an appetite for ghosts,
	 * they will try to put as much distance between them and the hungry guy, as they can.
	 * 
	 * spawn new Nukies:
	 * the aim of the game is to eat all Nukies, so the villains obviously have to play their role in preventing that.
	 * check collision with 'nuky', if not spawn one on grid (~ 20%?)
	 * 
	 * @author marc
	 */
	public class Enemy extends Entity 
	{
		private var enemySprite:Spritemap = new Spritemap(GFX.GFX_ENEMIES,32,32);
		private var velX:int = 0;
		private var velY:int = 0;
		private var currentDirection:String;
		private var _homeRect:Rectangle;
		private var homeCounter:Alarm = new Alarm(250, goToStartPoint);
		private var isAtHome:Boolean = true;
		private var _startRect:Rectangle;
		private var _color:String;
		private var _homePoint:Point;
		private var playground:Playground = Playground(FP.world);
		
		public function Enemy(homePoint:Point, startRect:Rectangle, color:String)
		{
			_startRect = startRect;
			_color = color;
			_homePoint = homePoint;
			
			super(_homePoint.x, _homePoint.y);
			
			switch (_color) {
				case "yellow":
				enemySprite.add("left",  [6,7,6,7,6,7,6,7,6,7,6,7,8,8], GC.ENEMY_SPRITE_FR, true);
				enemySprite.add("right", [9, 10,9,10,9,10,9,10,9,10,9,10,11,11], GC.ENEMY_SPRITE_FR, true);
				enemySprite.add("up", 	 [3, 4,3,4,3,4,3,4,3,4,3,4,3,4,5,5], GC.ENEMY_SPRITE_FR, true);
				enemySprite.add("down",  [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2, 2, 2, 2, 2], GC.ENEMY_SPRITE_FR, true);
				break;
				
				case "black":
				enemySprite.add("left",  [12,13,12,13,12,13,12,13,12,13,12,13,12,13,14,14], GC.ENEMY_SPRITE_FR, true);
				enemySprite.add("right", [15,16,15,16,15,16,15,16,15,16,15,16,15,16,17,17], GC.ENEMY_SPRITE_FR, true);
				enemySprite.add("up", 	 [21,22,21,22,21,22,21,22,21,22,21,22,21,22,23,23], GC.ENEMY_SPRITE_FR, true);
				enemySprite.add("down",  [18,19,18,19,18,19,18,19,18,19,18,19,18,19,20,20], GC.ENEMY_SPRITE_FR, true);
				break;
			}
			
			type = "enemy"; 
			layer = GC.LAYER_ENEMIES;
			graphic = enemySprite;
			setHitbox(32, 32, 0, 0);
			addTween(homeCounter, true);
		}
		
		override public function update():void {
			
			var player:Player = Player(collide("player", x, y));
			if (player && player.mood == "angry") {
				this.die();
			}
						
			if (isOnGrid()) {
				
				var directions:Array = getPossibleDirections();
				currentDirection = FP.choose(directions);
				
				if (!collide("nuky", x, y) && !collide("goody",x,y) && !isAtHome) {
					if (FP.rand(100) < GC.NUKY_RESPAWN_CHANCE) {
						FP.world.add(new Nuky(x, y));
						SoundManager.i.playSound("nuky_spawn");
					}
				}
			}
			
			switch (currentDirection) {
				case "right":
				velX = GC.ENEMY_SPEED;
				velY = 0;
				break;
				case "left":
				velX = -GC.ENEMY_SPEED;
				velY = 0;
				break;
				case "up":
				velX = 0;
				velY = -GC.ENEMY_SPEED;
				break;
				case "down":
				velX = 0;
				velY = GC.ENEMY_SPEED;
				break;
				default:
				velX = -velX;
				velY = -velY;
			}
			
			//doesn't reset if it is the same as last call
			enemySprite.play(currentDirection);
			x += velX;
			y += velY;
		}
		
		override public function removed():void {
			
		}
		
		private function goToStartPoint():void {
			isAtHome = false;
			
			x = Math.floor((FP.rand(_startRect.width) + _startRect.x)/32)*32;
			y = Math.floor((FP.rand(_startRect.height) + _startRect.y)/32)*32;
			
		}
		
		private function isOnGrid():Boolean {
			if (x % 32 == 0 && y % 32 == 0) {
				return true;
			}
			return false;
		}
		
		private function getPossibleDirections():Array {
			var directions:Array = new Array();
			if (!collide("enemy-room", x + GC.ENEMY_SPEED, y) && currentDirection != "left") {
				directions.push("right");
			}
			if (collide("enemy-room", x - GC.ENEMY_SPEED,y) == null && currentDirection != "right") {
				directions.push("left");
			}
			if (collide("enemy-room", x, y + GC.ENEMY_SPEED) == null && currentDirection != "up") {
				directions.push("down");
			}
			if (collide("enemy-room", x, y - GC.ENEMY_SPEED) == null && currentDirection != "down") {
				directions.push("up");
			}
			return (directions);
		}
		
		private function die():void {
			GV.points += 100;
			SoundManager.i.playSound("enemy_killed");
			this.world.add(new EnemyGhost(x, y, _homePoint, _color));
			this.world.add(new KillPointsEnemy(x, y));
			this.world.remove(this);
		}
	}
}