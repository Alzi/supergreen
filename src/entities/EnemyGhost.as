package entities 
{
	import main.GC;
	import main.GFX;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.utils.Ease;
	import worlds.Playground;
	import net.flashpunk.FP;
	
	
	/**
	 * ...
	 * @author marc
	 */
	public class EnemyGhost extends Entity 
	{
		private var sprite:Spritemap = new Spritemap(GFX.GFX_ENEMY_GHOST, 32, 32);
		private var motion:LinearMotion = new LinearMotion(onMotionEnd);
		private var playground:Playground = Playground(FP.world);
		
		public function EnemyGhost(startX:int, startY:int, targetX:int, targetY:int)
		{
			super (startX, startY);
			layer = GC.LAYER_ENEMIES;
			sprite.add("moving", [0, 1, 0, 1, 2, 3, 2, 3, 4, 5, 4, 5, 6, 7, 6, 7], GC.ENEMY_SPRITE_FR, true);
			collidable = false;
			graphic = sprite;
			sprite.play("moving");
			motion.setMotion(startX, startY, targetX, targetY, 200, Ease.expoOut);
			addTween(motion, true);
		}
		
		override public function update():void {
			x = motion.x;
			y = motion.y;
		}
		
		private function onMotionEnd():void {
			var color:String = FP.choose("yellow", "black");
			playground.setGhost(color);
			playground.remove(this);
		}
		
		
	}

}