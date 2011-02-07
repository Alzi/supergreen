package entities 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import main.GFX;
	import main.GC;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	
	/**
	 * The little ghost should be able to do some things:
	 * moving:
	 * random movement, decide if change of direction should occur at crossroads, checking collision ahead
	 * fleeing:
	 * if the Hero eats a goody and consequently has superpowers with an appetite for ghosts,
	 * they will try to put as much distance between them and the hungry guy, as they can.
	 * 
	 * spawn new Nukies:
	 * the aim of the game is to eat all Nukies, so the villains obviously have to play their role in preventing that.
	 * check collision with 'nuky', if not spawn one on grid
	 * 
	 * 
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
		private var atHome:Boolean = false;
		private var _startRect:Rectangle;
		private var _color:String;
		
		public function Enemy(homeRect:Rectangle, startRect:Rectangle, color:String)
		{
			_startRect = startRect;
			_homeRect = homeRect;
			_color = color;
			
			//set start-point on a random grid-tile at home area
			super(Math.floor((FP.rand(_homeRect.width)+homeRect.x) / 32)*32, Math.floor((FP.rand(_homeRect.height)+homeRect.y)/32)*32);
			
			//for trying out the animation
			//TODO The Framerate should be controlled by a public const in GC
			
			switch (_color) {
				case "yellow":
				enemySprite.add("left",  [6,7,6,7,6,7,6,7,6,7,6,7,8,8], 1 / 4, true);
				enemySprite.add("right", [9, 10,9,10,9,10,9,10,9,10,9,10,11,11], 1 / 4, true);
				enemySprite.add("up", 	 [3, 4,3,4,3,4,3,4,3,4,3,4,3,4,5,5], 1 / 4, true);
				enemySprite.add("down",  [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2, 2, 2, 2, 2], 1 / 4, true);
				break;
				
				case "black":
				enemySprite.add("left",  [12,13,12,13,12,13,12,13,12,13,12,13,12,13,14,14], 1 / 4, true);
				enemySprite.add("right", [15,16,15,16,15,16,15,16,15,16,15,16,15,16,17,17], 1 / 4, true);
				enemySprite.add("up", 	 [21,22,21,22,21,22,21,22,21,22,21,22,21,22,23,23], 1 / 4, true);
				enemySprite.add("down",  [18,19,18,19,18,19,18,19,18,19,18,19,18,19,20,20], 1 / 4, true);
				break;
			}
			
			type = "enemy"; 
			layer = GC.LAYER_ENEMIES;
			graphic = enemySprite;
			setHitbox(32, 32, 0, 0);
			addTween(homeCounter, false);
		}
		
		override public function update():void {
			
			var player:Player = Player(collide("player", x, y));
			if (player && player.mood == "angry") {
				this.world.add(new Enemy(_homeRect, _startRect, _color));
				this.world.remove(this);
			}
			
			
						
			if (isOnGrid()) {
				if (collideRect(x, y, _homeRect.x, _homeRect.y, _homeRect.width, _homeRect.height)) {
					isAtHome();
				}
				
				var directions:Array = getPossibleDirections();
				currentDirection = FP.choose(directions);
				
				if (!collide("nuky", x, y) && !collide("goody",x,y) && !atHome) {
					if (FP.rand(100) > 80) {
						FP.world.add(new Nuky(x, y));
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
		
		private function isAtHome():void {
			if (!atHome) {
				atHome = true;
				homeCounter.start();
			}
			
		}
		
		private function goToStartPoint():void {
			atHome = false;
			
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
	}
}