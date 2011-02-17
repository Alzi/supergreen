package main 
{
	import main.GC;
	
	/**
	 * ...
	 * @author marc
	 */
	public class GV 
	{
		public static var points:int = 0;
		public static var lifes:int = 0;
		
		public static var playerGridX:int = 0;
		public static var playerGridY:int = 0;
		
		public static var playerVectorX:int;
		public static var playerVectorY:int;
		
		public static var playersMode:String;
		
		public static function reset():void 
		{
			lifes = GC.PLAYERS_START_LIFES;
			points = GC.PLAYERS_START_POINTS;
			playerVectorX = 0;
			playerVectorY = 0;
		}
		
		
		
	}

}