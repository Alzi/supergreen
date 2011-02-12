package worlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
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
		private var bigBoom:Emitter = new Emitter(GFX.GFX_ENEMY_GHOST, 32, 32);	
		public function GameWon() 
		{
			
		}
		
		override public function update():void {
			
			super.update();
			//if (Input.check(Key.ANY)) {
				//FP.world = new Intro();
			//}
		}
		
		override public function begin():void {
			// addGraphic(winnerText);
			// addGraphic(clickText);
			
			var g:Graphiclist = new Graphiclist(winnerText, bigBoom);
						
			bigBoom.newType("boom", [0, 1, 2, 3, 4, 5, 6, 7]);
			addGraphic(g);
			bigBoom.setAlpha("boom", 1, 0);
			bigBoom.setColor("boom");
			bigBoom.setMotion("boom", 0, 120, 500, 360, -50, -130, Ease.quartOut);
			for (var i:uint = 0; i < 100; i++) {
				bigBoom.emit("boom", GC.SCREEN_WIDTH / 2, GC.SCREEN_HEIGHT / 2);
			}
			
			
			
		}
			
	}

}