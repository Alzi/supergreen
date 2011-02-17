package worlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.VarTween;
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
	public class GameWon extends World 
	{
		
		private var winnerText:Text = new Text("Congratulations!", 213, 109, 200, 30);
		private var clickText:Text = new Text("any key to play again", 200, 250, 250, 30);
		private var bigBoom:Emitter = new Emitter(GFX.GFX_FLOWER, 32, 32);
		private var delayTimer:Alarm = new Alarm(120, onDelayTimeUp);
		private var alphaTween:VarTween = new VarTween(onFadeIn);
		private var animationPlayed:Boolean = false;
		private var fireworkTimer:Alarm = new Alarm(50, onFireWorkTimeUp);
		
		public function GameWon() 
		{
			addTween(delayTimer, true);
			addTween(alphaTween, false);
			addTween(fireworkTimer, false);
			
			// addGraphic(winnerText);
			// addGraphic(clickText);
			clickText.alpha = 0;
			
			var g:Graphiclist = new Graphiclist(winnerText, bigBoom, clickText);
			addGraphic(g);
			
			bigBoom.newType("boom", [0]);
			bigBoom.setAlpha("boom", 1, 0);
			
			onFireWorkTimeUp();
						
		}
		
		override public function update():void {
			super.update();
			if (Input.check(Key.ANY) && animationPlayed) {
				FP.world = new Intro();
			}
		}
		
		public function onFireWorkTimeUp():void {
			fireworkTimer.start();
			
			bigBoom.setColor("boom", 0xFFFFFF, 0x10FF10);
			bigBoom.setMotion("boom", 90, 80, 60, FP.rand(90), FP.rand(300), FP.rand(240), Ease.quartOut);
			
			var x:int = GC.SCREEN_WIDTH - FP.rand(GC.SCREEN_WIDTH );
			var y:int = GC.SCREEN_HEIGHT - FP.rand(GC.SCREEN_HEIGHT / 3);
			
			for (var i:uint = 0; i < 100; i++) {
				bigBoom.emit("boom", x ,y );
			}
		}
		
		
				
		private function onDelayTimeUp():void {
			alphaTween.tween(clickText, "alpha", 1, 60, Ease.expoInOut);
		}
			
		private function onFadeIn():void {
			animationPlayed = true;
		}
	}

}