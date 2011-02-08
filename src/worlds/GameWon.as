package worlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author marc
	 */
	public class GameWon extends World 
	{
		
		private var winnerText:Text = new Text("Congratulations!", 213, 109, 200, 30);
		private var clickText:Text = new Text("any key to play again", 200, 250, 250, 30);
		
		public function GameWon() 
		{
			
		}
		
		override public function update():void {
			if (Input.check(Key.ANY)) {
				FP.world = new Intro();
			}
		}
		
		override public function begin():void {
			addGraphic(winnerText);
			addGraphic(clickText);
		}
			
	}

}