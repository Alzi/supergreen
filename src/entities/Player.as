package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import main.GC;
	import main.GV;
	/**
	 * ...
	 * @author marc
	 */
	public class Player extends Entity 
	{
		[Embed(source = '../assets/gfx/player.png')]
		private const PLAYER:Class;
		
		private var player_sprite:Spritemap = new Spritemap(PLAYER, 32, 32);
		private var currentVelX:int = 0;  	//Default-X-Velocity
		private var currentVelY:int = 0;	//Default-X-Velocity
		private var nextVelX:int = 0;		
		private var nextVelY:int = 0;
		private var currentOrientation:String = "right";
		private var nextOrientation:String;
		private var superheroTimer:Alarm = new Alarm(GC.PLAYER_POWERUP_TIME, goNormal);
		private var respawnTimer:Alarm = new Alarm(GC.PLAYER_RESPAWN_TIME, respawn);
		private var invulnerableTimer:Alarm = new Alarm(GC.PLAYER_INVULNERABLE_TIME, goNormal);
		private var isDead:Boolean = false;
		
		private var _startX:uint;
		private var _startY:uint;
		
		public var mood:String = "afraid";
		
		public function Player(startX:int, startY:int):void
		{
			_startX = startX;
			_startY = startY;
			super (_startX, _startY);
			
			addTween(superheroTimer);
			addTween(respawnTimer);
			addTween(invulnerableTimer);
			
			layer = GC.LAYER_PLAYER;
			type = "player";
			
			player_sprite.add("left-afraid", [4, 5, 6, 7, 5], GC.PLAYER_SPRITE_FR, true);
			player_sprite.add("right-afraid", [0,1,2,3,1], GC.PLAYER_SPRITE_FR, true);
			player_sprite.add("up-afraid", [8,9,10,11,9], GC.PLAYER_SPRITE_FR, true);
			player_sprite.add("down-afraid", [12, 13, 14, 15, 13], GC.PLAYER_SPRITE_FR, true);
			
			player_sprite.add("left-angry", [20, 21, 22, 23, 21], GC.PLAYER_SPRITE_FR, true);
			player_sprite.add("right-angry", [16,17,18,19,17], GC.PLAYER_SPRITE_FR, true);
			player_sprite.add("up-angry", [24, 25, 26, 27, 25], GC.PLAYER_SPRITE_FR, true);
			player_sprite.add("down-angry", [28, 29, 30, 31, 29], GC.PLAYER_SPRITE_FR, true);
			
			player_sprite.add("die", [32, 33, 34, 35, 36, 37, 38, 39,40], GC.PLAYER_SPRITE_FR, false);
						
			graphic = player_sprite;
						
			//define Inputs
			Input.define("left", Key.LEFT, Key.A);
			Input.define("right", Key.RIGHT, Key.D);
			Input.define("up", Key.UP, Key.W);
			Input.define("down", Key.DOWN, Key.S);
			
			//define Hitbox
			setHitbox(32, 32, 0, 0);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (collide("enemy", x, y) && mood=="afraid") {
				die();
			}
			
			//check Input
			if (Input.pressed("left")) {
				nextVelX = -GC.PLAYER_SPEED;
				nextVelY = 0;
				nextOrientation = "left"
				//player_sprite.play("left");
			}
			if (Input.pressed("right")) {
				nextVelX = GC.PLAYER_SPEED;
				nextVelY = 0;
				nextOrientation = "right";
				//player_sprite.play("right");
			}
			if (Input.pressed("up")) {
				nextVelY = -GC.PLAYER_SPEED;
				nextVelX = 0;
				nextOrientation = "up";
				//player_sprite.play("up");
			}
			if (Input.pressed("down")) {
				nextVelY = GC.PLAYER_SPEED;
				nextVelX = 0;
				nextOrientation = "down";
				//player_sprite.play("down");
			}
			
			if (!isDead) {
				checkCollision();
				player_sprite.play(currentOrientation+"-"+mood);
			
				x += currentVelX;
				y += currentVelY;
			}
			
			//TODO  hard-coded for the only existing level, maby needs to bee dynamic in future
			if ( x == 512 && currentOrientation == "right") x = 96;
			if ( x == 96 && currentOrientation == "left") x = 512;
		}
		
		private function respawn():void {
			x = _startX;
			y = _startY;
			mood = "angry";
			player_sprite.play("right-angry");
			currentOrientation = "right";
			isDead = false;
			collidable = true;
			invulnerableTimer.start();
		}
		
		private function checkCollision():void {
			
			if (collide("room", x + currentVelX, y + currentVelY)) {
				currentVelX = 0;
				currentVelY = 0;
				x = Math.floor(x / 32) * 32 +currentVelX;
				y = Math.floor(y / 32) * 32 +currentVelY;
				
			} 
			else 
			{
				if (collide("room", x + nextVelX, y + nextVelY) == null) {
					currentVelX = nextVelX;
					currentVelY = nextVelY;
					currentOrientation = nextOrientation;
				}
				var goody:Nuky = Nuky(collide("nuky", x, y));
				if (goody){
					goody.kill();
				}
			}
		}
		
		private function die():void {
			mood = "afraid";
			isDead = true;
			player_sprite.play("die");
			GV.lifes -= 1;
			respawnTimer.start();
			collidable = false;
		}
		
		public function goSuperhero():void {
			mood = "angry";
			superheroTimer.start();
		}
		
		private function goNormal():void {
			mood = "afraid";
		}
	}
}