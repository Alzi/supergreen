package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.VarTween;
	import main.GFX;
	import main.GC;
	import net.flashpunk.utils.Ease;
	/**
	 * ...
	 * @author marc
	 */
	public class KillPointsEnemy extends Entity 
	{
		private var alphaTween:VarTween = new VarTween(onFadeOut);
		private var sprite:Image = new Image(GFX.GFX_KILL_POINTS);
		private var scaleTween:VarTween = new VarTween();
		
		public function KillPointsEnemy(startX:int, startY:int) 
		{
			super(startX, startY);
			layer = GC.LAYER_ENEMIES;
			collidable = false;
			graphic = sprite;
			sprite.originX = 16;
			sprite.originY = 16;
			
			alphaTween.tween(sprite, "alpha", 0, 60);
			scaleTween.tween(sprite, "scale", 2, 50, Ease.bounceOut); 
			addTween (alphaTween, true);
			addTween (scaleTween, true);
		}
		
		private function onFadeOut():void {
			world.remove(this);
		}
		
		//override public function update():void {
			//
		//}
		
	}

}