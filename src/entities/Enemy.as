package entities 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import main.GFX;
	import main.GC;
	import main.GV;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.MultiVarTween;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import worlds.Playground;
	import entities.EnemyGhost;
	import main.SoundManager;
	import net.flashpunk.utils.Ease;
	
	
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
		
		public var isAfraid:Boolean = true;
		
		private var mode:String = "scatter";
		private var targetX:int = 0;
		private var targetY:int = 0;
		private var currentDirection:String;
		
		private var numOfModeChanges:int = 0;
				
		private var allDirections:Vector.<String> = new Vector.<String>();
		
		private var nextGridX:int = 0;
		private var nextGridY:int = 0;
		
		// tweens
		private var homeCounter:Alarm = new Alarm(120, onHomeTimeUp);
		private var motion:LinearMotion = new LinearMotion(onReachedNextGrid);
		private var startMotion:LinearMotion = new LinearMotion(onEnteredGame);
		private var fadeOut:VarTween = new VarTween(onFadeOut);
		private var fadeIn:VarTween = new VarTween(onFadeIn);
		private var modeTimer:Alarm = new Alarm(240, onModeTimer);
		private var levelTimer:NumTween = new NumTween(onLevelTimeUp);
		private var fader:NumTween = new NumTween(onFadeIn);
		
		private var _startPoint:Point = new Point();
		private var _homePoints:Vector.<Point> = new Vector.<Point>();
		private var _nickname:String;
		
		private var sprite:Spritemap;
		private var spriteAfraid:Spritemap;
		
		private var switchedToAfraid:Boolean = false;
		private var isAtHome:Boolean = true;
		
	
		
		
		//TODO startRect should be a Point as well
		public function Enemy(homePoints:Vector.<Point>, startPoint:Point, nickname:String)
		{
			_homePoints = homePoints;
			_nickname = nickname;
			
			var firstPoint:flash.geom.Point = FP.choose(_homePoints);
			super(firstPoint.x, firstPoint.y);
			
			_startPoint = startPoint;
			
			addTween(motion, false);
			addTween(homeCounter, true);
			addTween(fadeOut, false);
			addTween(fadeIn, false);
			addTween(modeTimer, true);
			addTween(levelTimer, false);
			addTween(startMotion, false);
			addTween(fader, false);
			
			sprite = new Spritemap(GFX[_nickname.toUpperCase()], 32, 32);
			spriteAfraid = new Spritemap(GFX.AFRAID_GHOST, 32, 32);
					
			sprite.add("left",  [0,1,0,1,0,1,0,1,0,1,0,1,0,1,2,2], GC.ENEMY_SPRITE_FR, true);
			sprite.add("right", [3,4,3,4,3,4,3,4,3,4,3,4,3,4,5,5], GC.ENEMY_SPRITE_FR, true);
			sprite.add("up", 	 [9,10,9,10,9,10,9,10,9,10,9,10,9,10,11,11], GC.ENEMY_SPRITE_FR, true);
			sprite.add("down",  [6, 7, 6, 7, 6, 7, 6, 7, 6, 7, 6, 7, 6, 7, 8, 8], GC.ENEMY_SPRITE_FR, true);
			
			spriteAfraid.add("move", [0, 1, 0, 1, 0, 1, 2, 3, 2, 3, 2, 3, 4, 5, 4, 5, 4, 5, 6, 7, 6, 7, 6, 7, 6, 7, 6, 7, 6, 7], GC.ENEMY_SPRITE_FR, true);
			spriteAfraid.play("move");
			
			graphic = sprite;
			type = "enemy";
			setHitbox(8, 8, -14,-14);
			layer = GC.LAYER_ENEMIES;
			
			allDirections.push("up", "right", "down", "left");
			sprite.play(FP.choose(allDirections));
			
			fadeOut.tween(sprite, "alpha", 0, 40, Ease.sineOut);
			levelTimer.tween(GC[_nickname.toUpperCase() + "_START_SPEED"], GC[_nickname.toUpperCase() + "_END_SPEED"], 60*30);
		}
		
		override public function update():void {
				
				if (! isAtHome) {
					
					if (collide("player", x, y) && isAfraid) {
					die();
					}
					
					if (isAfraid && !switchedToAfraid) {
						switchedToAfraid = true;
						graphic = spriteAfraid;
						uTurn();
					}
					
					if (!isAfraid && switchedToAfraid) {
						switchedToAfraid = 	false;						
						graphic = sprite;
						uTurn();
					}
					
					x = motion.x;
					y = motion.y;
				}
				
				if (startMotion.active) {
					x = startMotion.x;
					y = startMotion.y;
				}
		}
		
		public function respawn(startX:int, startY:int):void {
			collidable = true;
			x = startX;
			y = startY;
			isAtHome = true;
			graphic = sprite;
			homeCounter.start();
			fadeOut.start();
			visible = true;
			active = true;
		}
		
		private function die():void {
			this.world.add(new EnemyGhost(x, y, FP.choose(_homePoints), this));
			this.world.add(new KillPointsEnemy (x, y));
			SoundManager.i.playSound("enemy_killed");
			visible = false;
			active = false;
			collidable = false;
		}
		
		private function onLevelTimeUp():void {
			trace ("Level-Time-Up!");
			modeTimer.active = false;
			mode = "follow";
		}
		
		private function onEnteredGame():void {
			fadeIn.active = false;
			fadeOut.active = false;
			sprite.alpha = 1;
			isAtHome = false;
			isAfraid = false;
			switchedToAfraid = false;
			onReachedNextGrid();
		}
		
		private function uTurn():void {
			var motionFramesElapsed:Number;
			if (motion.percent != 0) {
				motionFramesElapsed = levelTimer.value * motion.percent;
			}
			else {
				motionFramesElapsed = levelTimer.value;
			}
			
			switch (currentDirection) {
				case "up":
				currentDirection = "down";
				nextGridY += 32;
				break;
				
				case "right":
				currentDirection = "left";
				nextGridX -= 32;
				break;
				
				case "down":
				currentDirection = "up";
				nextGridY -= 32;
				break;
				
				case "left":
				currentDirection = "right";
				nextGridX += 32;
				break;
			}
			
			motion.setMotion(x, y, nextGridX, nextGridY, motionFramesElapsed);
			motion.start();
		}
				
		private function onHomeTimeUp():void {
			
			startMotion.setMotion(x, y, _startPoint.x, _startPoint.y, 40);
			startMotion.start();
			currentDirection = GC[_nickname.toUpperCase() + "_START_DIRECTION"];
		}
		
		private function onFadeOut():void {
			var randomPoint:Point = new Point();
			randomPoint = FP.choose(_homePoints);
			x = randomPoint.x;
			y = randomPoint.y;
			sprite.play(FP.choose(allDirections));
			fadeIn.tween(sprite, "alpha", 1, 30, Ease.sineOut);			
		}
		
		private function onFadeIn():void {
			fadeOut.start();
		}
		
		private function onModeTimer():void {
			numOfModeChanges += 1;
			if (numOfModeChanges < 6 && !isAfraid ) {
				mode = mode == "scatter"?"follow":"scatter";
				modeTimer.reset(FP.rand(240) + 600);
			}
		}
		
		private function findNextGrid():void {
			
			var direction:String
			var smallesDistance:int = 100000;
			var distance:int = 0;
			var nextDirection:String;
			
			for each (direction in allDirections) {
				switch (direction) {
					case "up":
					if (!collide("enemy-room", x, y - 32) && currentDirection != "down") {
						distance = FP.distance(x, y-32, targetX, targetY);
						if (distance < smallesDistance) {
							nextGridX = x;
							nextGridY = y - 32;
							smallesDistance = distance;
							nextDirection = "up";
						}
					}
					break;
					
					case "right":
					if (!collide("enemy-room", x + 32, y) && currentDirection != "left") {
						distance = FP.distance(x+32, y, targetX, targetY);
						if (distance < smallesDistance) {
							nextGridX = x + 32;
							nextGridY = y;
							smallesDistance = distance;
							nextDirection = "right";
						}
					}
					break;
					
					case "down":
					if (!collide("enemy-room", x, y + 32) && currentDirection != "up") {
						distance = FP.distance(x, y+32, targetX, targetY);
						if (distance < smallesDistance) {
							nextGridX = x;
							nextGridY = y + 32;
							smallesDistance = distance;
							nextDirection = "down";
						}
					}
					break;
					
					case "left":
					if (!collide("enemy-room", x - 32, y) && currentDirection != "right") {
						distance = FP.distance(x-32, y, targetX, targetY);
						if (distance < smallesDistance) {
							nextGridX = x-32;
							nextGridY = y;
							smallesDistance = distance;
							nextDirection = "left";
						}
					}
					break;
				}
			}
			currentDirection = nextDirection;
		}
		
		private function onReachedNextGrid ():void {
			
			x = Math.round(x / 32) * 32;
			y = Math.round(y / 32) * 32;
			
			if (FP.rand(100) < GC.NUKY_RESPAWN_CHANCE && !collide("nuky", x, y) && !isAfraid && !isAtHome) {
				world.add(new Nuky(x, y));
				SoundManager.i.playSound("nuky_spawn");
			}
					
			switch (mode) {
					case "follow":
					targetX = GV.playerGridX + GC[_nickname.toUpperCase() + "_TILES_AHEAD_PLAYER"] * GV.playerVectorX * 32;
					targetY = GV.playerGridY + GC[_nickname.toUpperCase() + "_TILES_AHEAD_PLAYER"] * GV.playerVectorY * 32;
					break;
					
					case "scatter":
					targetX = GC[_nickname.toUpperCase()+"_TARGET_X"];
					targetY = GC[_nickname.toUpperCase()+"_TARGET_Y"];
					break;
			}
			
			findNextGrid();
			sprite.play(currentDirection);
			motion.setMotion(x, y, nextGridX, nextGridY, levelTimer.value);
			motion.start();
		}
	}
}