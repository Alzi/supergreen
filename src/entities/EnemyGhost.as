package entities 
{
	import flash.geom.Point;
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
		private var _targetPoint:Point;
		private var _targetColor:String;
		
		public function EnemyGhost(startX:int, startY:int, targetPoint:Point, color:String)
		{
			super (startX, startY);
			_targetPoint = targetPoint;
			_targetColor = color;
			
			layer = GC.LAYER_ENEMIES;
			sprite.add("moving", [0, 1, 0, 1, 2, 3, 2, 3, 2,3,2,3,2,3, 4, 5, 4, 5, 6, 7, 6, 7], GC.ENEMY_SPRITE_FR, true);
			collidable = false;
			graphic = sprite;
			sprite.play("moving");
			motion.setMotion(startX, startY, _targetPoint.x, _targetPoint.y, 200, Ease.expoOut);
			addTween(motion, true);
		}
		
		override public function update():void {
			x = motion.x;
			y = motion.y;
		}
		
		private function onMotionEnd():void {
			playground.setEnemy(_targetPoint, _targetColor);
			playground.remove(this);
		}
		
		
	}

}