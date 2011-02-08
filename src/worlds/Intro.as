package worlds 
{
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.World;
	import main.SoundManager;
	import net.flashpunk.utils.Input;
	import main.GC;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Ease;
	/**
	 * ...
	 * @author marc
	 */
	
	 
	public class Intro extends World 
	{
		
		private var welcomeText:Text = new Text("Welcome to Supergreen!", 213, 109, 200, 30);
		private var clickText:Text = new Text("press any key!",250,300,150,30);
		private var hasPlayedSound:Boolean = false;
		private var fadeIn:VarTween = new VarTween();
		
		
		public function Intro() 
		{
			super();
		}
		
		override public function begin():void {
			addGraphic(welcomeText);
			clickText.alpha = 0;
			fadeIn.tween(clickText, "alpha", 1, 15, Ease.quartOut);
			SoundManager.i.playSound("player_start",0,0,onSoundPlayed);
		}
			
		override public function update():void {
			if (Input.check(Key.ANY) && hasPlayedSound) {
				FP.world = new Playground();
			}
		}
				
		private function onSoundPlayed():void {
			addTween(fadeIn, true);
			addGraphic(clickText);
			hasPlayedSound = true;
		}
	
		
	}

}