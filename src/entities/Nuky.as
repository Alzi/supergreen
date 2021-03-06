package entities 
{
	import main.GV;
	import net.flashpunk.Entity;
	import main.GC;
	import main.GFX;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Tilemap;
	import main.SoundManager;
	/**
	 * ...
	 * @author marc
	 */
	public class Nuky extends Entity 
	{
		private var sprite:Spritemap = new Spritemap(GFX.GFX_GOODIES, 32, 32, animationEnd);
		public function Nuky(startX:int, startY:int) 
		{
			super(startX, startY);
			layer = GC.LAYER_GOODIES;
			sprite.add("still", [0], 0, false);
			sprite.add("explode", [4, 5, 6, 7], 1, false);
			sprite.play("still");
			graphic = sprite;
			setHitbox(14, 14, -8, -8);
			type = "nuky";
		}
		
		public function kill():void {
			sprite.play("explode");
			SoundManager.i.playSound("munch",0.95);
		}
		
		public function animationEnd():void {
			switch (sprite.currentAnim) {
				case "explode":
				this.world.remove(this);
				break;
				default:
				break;
					
			}
		}
		
		override public function removed():void {
			GV.points += 10;
		}
	}
}