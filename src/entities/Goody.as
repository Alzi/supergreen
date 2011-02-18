package entities 
{
	import main.GC;
	import main.GFX;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.Alarm;
	import main.SoundManager;
	
	/**
	 * ...
	 * @author marc
	 */
	public class Goody extends Entity 
	{
		public var _goodyType:String;
		
		private var spriteMap:Spritemap = new Spritemap(GFX.GFX_GOODIES, 32, 32);
		private var inactiveCounter:Alarm = new Alarm(GC.GOODY_REGENERATION_TIME, setActive);
		
		public var isActive:Boolean = true;
		
		
		public function Goody(goodyType:String,startX:uint, startY:uint) 
		{
			// I don't understand it, but it it important for collision purposes to call this first
			// I think it is because the _class variable isn't set before this call
			super(startX, startY);
			
			
			addTween(inactiveCounter);
			
			type = "goody";
			_goodyType = goodyType;
			layer = GC.LAYER_GOODIES;
			setHitbox(30, 30, -1, -1);
					
			spriteMap.add("Water", [1,8,9,10,8], 1/6, true);
			spriteMap.add("Sun", [2,12,13,14,12], 1/6, true);
			spriteMap.add("Wind", [3, 16, 17, 18, 16], 1 / 6, true);
			spriteMap.add("inactive", [11], 0, false);
			
			spriteMap.play(_goodyType);
			
			graphic = spriteMap;
			
		}
		
		override public function update():void {
			
			var hero:Player = Player(collide("player", x, y));
			
			
			if (hero && isActive) {
				isActive = false;
				spriteMap.play("inactive");
				inactiveCounter.start();
				hero.goodyEaten(_goodyType);
				
				
				
			}
			
		}
		
		private function setActive():void {
			SoundManager.i.playSound("goody_reapear");
			spriteMap.play(_goodyType);
			isActive = true;
		}
		
	}

}