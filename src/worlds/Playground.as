package worlds 
{
	import main.Background;
	import net.flashpunk.World;
	import levels.Level;
	import players.Player;
	import net.flashpunk.masks.Grid;
	
	
	/**
	 * ...
	 * @author marc
	 */
	public class Playground extends World 
	{
		[Embed(source = '../assets/levels/testlevel.oel', mimeType = 'application/octet-stream')]
		private const TESTLEVEL:Class;
		
		public function Playground() 
		{
			
			add(new Level(TESTLEVEL));
			add(new Player);
			add(new Background);
		}
		
	}

}