package worlds 
{
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
		
		
		public function Playground() 
		{
			add(new Player);
			add(new Level);
			
			
			
		}
		
	}

}