package entities 
{
	import flash.net.NetStreamPlayTransitions;
	import main.SoundManager;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import main.GC;
	import main.GV;
	import main.GFX;
	import net.flashpunk.World;
	import worlds.Playground;
	import net.flashpunk.utils.Ease
	/**
	 * ...
	 * @author marc
	 * TODO clean up code
	 */
	public class Player extends Entity 
	{
		private var player_sprite:Spritemap = new Spritemap(GFX.PLAYER, 32, 32);
		private var playerDies_sprite:Spritemap = new Spritemap(GFX.PLAYER_DIES, 32, 32, fadePlayerOut);
		private var currentVelX:int = 0;  	//Default-X-Velocity
		private var currentVelY:int = 0;	//Default-X-Velocity
		private var nextVelX:int = 0;		
		private var nextVelY:int = 0;
		private var currentOrientation:String = "left";
		private var nextOrientation:String;
		
		//Tweens
		private var superheroTimer:Alarm = new Alarm(GC.PLAYER_POWERUP_TIME, stopLoop);
		private var respawnTimer:Alarm = new Alarm(GC.PLAYER_RESPAWN_TIME, respawn);
		private var invulnerableTimer:Alarm = new Alarm(GC.PLAYER_INVULNERABLE_TIME, goNormal);
		private var fadeOut:VarTween = new VarTween();
		
		private var isDead:Boolean = false;
		private var speedUpgrade:Number = 0;
		
		//Energy-Mix-Flags
		private var hasEatenGoodyWater:Boolean = false;
		private var hasEatenGoodySun:Boolean = false;
		private var hasEatenGoodyWind:Boolean = false;
				
		private var _startX:uint;
		private var _startY:uint;
		
		private var _pg:Playground;
		
		public var mode:String = "normal";
		
		public function Player(startX:int, startY:int, pg:World):void
		{
			_startX = startX;
			_startY = startY;
			super (_startX, _startY);
					
			_pg = Playground(pg);
			
			layer = GC.LAYER_PLAYER;
			type = "player";
			
			addTween(superheroTimer);
			addTween(respawnTimer);
			addTween(invulnerableTimer);
			addTween(fadeOut);
						
			player_sprite.add("left", [0,0,1,2,3,4,5,2], GC.PLAYER_SPRITE_FR, true);
			player_sprite.add("right", [6,6,7,8,9,10,11,8], GC.PLAYER_SPRITE_FR, true);
			player_sprite.add("down", [12,12,13,14,15,16,17,14], GC.PLAYER_SPRITE_FR, true);
			player_sprite.add("up", [18,18,19,20,21,22,23,20], GC.PLAYER_SPRITE_FR, true);
			
			playerDies_sprite.add("die", [0,0,0,1,1,1,2,3,4,5,6,6,6,6,7,7,7,8,8,9], GC.PLAYER_SPRITE_FR, false);
						
			graphic = player_sprite;
						
			//define Inputs
			Input.define("left", Key.LEFT, Key.A);
			Input.define("right", Key.RIGHT, Key.D);
			Input.define("up", Key.UP, Key.W);
			Input.define("down", Key.DOWN, Key.S);
			
			//define Hitbox
			setHitbox(32,32);
			
			SoundManager.i.playSound("munch", 1);
		}
		
		override public function update():void 
		{
			super.update();
			
			GV.playerGridX = Math.round(x / 32) * 32;
			GV.playerGridY = Math.round(y / 32) * 32;
			var e:Enemy = Enemy(collide("enemy", x, y));
			
			if (e && !e.isAfraid) {
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
				player_sprite.play(currentOrientation);
				
				GV.playerVectorX = FP.sign(currentVelX);
				GV.playerVectorY = FP.sign(currentVelY);
				
				currentOrientation = nextOrientation;
				
				
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
			graphic = player_sprite;
			player_sprite.play(currentOrientation);
			
			fadeOut.active = false;
			playerDies_sprite.alpha = 1;
			
			
			mode = "super";
			isDead = false;
			collidable = true;
			SoundManager.i.playSound("sh_end", 0, 0, goNormal);
			invulnerableTimer.start();
			_pg.setEnemies();

		}
		
		private function checkCollision():void {
			
			if (collide("room", x + currentVelX, y + currentVelY)) {
				currentVelX = 0;
				currentVelY = 0;
				//x = Math.round(x / 32) * 32 +currentVelX;
				//y = Math.round(y / 32) * 32 +currentVelY;
			} 
			else 
			{
				if (collide("room", x + nextVelX, y + nextVelY) == null) {
					currentVelX = nextVelX;
					currentVelY = nextVelY;
					
				}
				var goody:Nuky = Nuky(collide("nuky", x, y));
				if (goody){
					goody.kill();
				}
			}
		}
		
		private function die():void {
			
			SoundManager.i.playSound("hero_killed");
			_pg.shakeScreen();
			GV.lifes -= 1;
			_pg.lifeCounter.looseLife();
			_pg.checkIfGameLost();
			mode = "normal";
			isDead = true;
			graphic = playerDies_sprite;
			playerDies_sprite.play("die",true);
			//var lifecounter:LiveCounter = new LiveCounter(0,0);
			//world.getClass(LiveCounter, lifecounter);
			//lifecounter.oneLifeLost();
			respawnTimer.start();
			collidable = false;
		}
		
		
		
		private function fadePlayerOut():void {
			fadeOut.tween(playerDies_sprite, "alpha", 0, 60);
		}
		
		private function goNormal():void {
			if (! superheroTimer.active ) {
				mode = "normal";
				GV.playersMode = "normal";
				_pg.setEnemiesNotAfraid();
			}
		}
		
		private function stopLoop():void {
			SoundManager.i.stopLoop(SoundManager.i.superheroLoop);
			SoundManager.i.playSound("sh_end",0,0,goNormal);
		}
		
		private function goSuperhero():void {
			mode = "super";
			GV.playersMode = "super";
			superheroTimer.start();
			SoundManager.i.playSound("go_superhero",0, 0);
			SoundManager.i.loopSound(SoundManager.i.superheroLoop, 0.8, 54);
			
			speedUpgrade = 0;
			_pg.setEnemiesAfraid();
		}
		
		public function goodyEaten(goodyType:String):void {
			
			if (mode == "normal") {
				_pg.energyMixDisplay[goodyType.toLowerCase()].visible = true;
				if (! this["hasEatenGoody" + goodyType]) {
					this["hasEatenGoody" + goodyType] = true;
					SoundManager.i.playSound("goody_" + goodyType);
				}
				else {
					SoundManager.i.playSound("goody_not_count",0.3);
				}
			}
			
			else {
				SoundManager.i.playSound("goody_not_count",0.2);
			}
			
			
			if (hasEatenGoodySun && hasEatenGoodyWater && hasEatenGoodyWind) {
				hasEatenGoodySun = hasEatenGoodyWater = hasEatenGoodyWind = false;
				_pg.energyMixDisplay.goSuperhero();
				goSuperhero();
			}
		}
		
		
		
		
	}
}