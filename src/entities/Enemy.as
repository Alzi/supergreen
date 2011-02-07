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
		private var enemySprite:Spritemap = new Spritemap(GFX.GFX_ENEMIES, 32, 32);
		private var velX:int = 0;
		private var velY:int = 0;
		private var currentDirection:String;
	
		private var frameCounter:int = 0;
		
		public function Enemy(startX:int, startY:int) 
		{
			//for trying out the animation
			//TODO The Framerate should be controlled by a public const in GC
			enemySprite.add("left",  [6, 7,6,7,6,7,6,7,6,7,6,7,8,8], 1 / 4, true);
			enemySprite.add("right", [9, 10,9,10,9,10,9,10,9,10,9,10,11,11], 1 / 4, true);
			enemySprite.add("up", 	 [3, 4,3,4,3,4,3,4,3,4,3,4,3,4,5,5], 1 / 4, true);
			enemySprite.add("down",  [0, 1,0,1,0,1,0,1,0,1,0,1,2,2,2,2,2], 1 / 4, true);
			
			layer = GC.LAYER_ENEMIES;
			graphic = enemySprite;
			setHitbox(32, 32, 0, 0);
			
			//Start-Direction
			super(startX, startY);
		}
		
		private function getPossibleDirections():Array {
			var directions:Array = new Array();
			if (!collide("room", x + GC.ENEMY_SPEED,y) && currentDirection != "left") {
				directions.push("right");
			}
			if (collide("room", x - GC.ENEMY_SPEED,y) == null && currentDirection != "right") {
				directions.push("left");
			}
			if (collide("room", x, y + GC.ENEMY_SPEED) == null && currentDirection != "up") {
				directions.push("down");
			}
			if (collide("room", x, y - GC.ENEMY_SPEED) == null && currentDirection != "down") {
				directions.push("up");
			}
			return (directions);
		}
		
		private function isOnGrid():Boolean {
			if (x % 32 == 0 && y % 32 == 0) {
				return true;
			}
			return false;
		}
		
		
		override public function update():void {
			
			
						
			
			if (isOnGrid()) {
				
				var directions:Array = getPossibleDirections();
				currentDirection = FP.choose(directions);
				
				
				if (!collide("nuky", x, y) && !collide("goody",x,y)) {
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
		
		
		
		
		
	}

}