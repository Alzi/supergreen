package main 
{
	/**
	 * ...
	 * @author marc
	 */
	public class GC 
	{
		public static const SCREEN_WIDTH:Number = 480;
		public static const SCREEN_HEIGHT:Number = 640;
		public static const PLAYER_SPEED:Number = 3;
		public static const PLAYER_SPRITE_FR:Number = 6; // Player-Sprite Animation-Framerate
		
		[Embed(source = '../assets/gfx/level-tiles.png')]
		public static const ROOM_TILES:Class;
		public static const ROOM_TILES_RECT:Array = [192, 128];
		
	}	

}