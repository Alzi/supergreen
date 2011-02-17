package worlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.motion.CircularMotion;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Emitter;
	import main.GFX;
	import net.flashpunk.utils.Ease;
	import main.GC;
	
	
	/**
	 * ...
	 * @author marc
	 */
	public class GameLost extends World 
	{
		
		private var winnerText:Text = new Text("You lost!", 213, 109, 200, 30);
		private var clickText:Text = new Text("any key to play again", 200, 250, 250, 30);
		private var bigBoom:Emitter = new Emitter(GFX.GFX_ENEMY_GHOST, 32, 32);
		private var animationPlayed:Boolean = false;
		private var animationTimer:Alarm = new Alarm(240, onAnimationPlayed);
		
		private var circMotion:CircularMotion = new CircularMotion();
		
		
		
		public function GameLost() 
		{
			
		}
		
		override public function update():void {
			
			super.update();
			if (Input.check(Key.ANY) && animationPlayed) {
				FP.world = new Intro();
			}
			
			if (circMotion.active) {
				bigBoom.emit("boom", circMotion.x, circMotion.y);
				
				bigBoom.setMotion("boom", -circMotion.x, 20, 240, 30, 500, 20, Ease.bounceIn);
			}
			
			
		}
		
		override public function begin():void {
			// addGraphic(winnerText);
			// addGraphic(clickText);
			
			addTween(animationTimer, true);
			addTween(circMotion, false);
			
			var g:Graphiclist = new Graphiclist(winnerText, bigBoom);
						
			bigBoom.newType("boom", [0, 1, 2, 3, 4, 5, 6, 7]);
			addGraphic(g);
			bigBoom.setAlpha("boom", 1, 0);
			bigBoom.setColor("boom", 0xFFFFFF, 0xFF0000);
			circMotion.setMotion(GC.SCREEN_WIDTH / 2, GC.SCREEN_HEIGHT / 2, 150, 180, true, 240);
			circMotion.start();
			
		}
		
		private function onAnimationPlayed():void {
			addGraphic(clickText);
			animationPlayed = true;
		}
			
	}

}