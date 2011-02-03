package main 
{
	/**
	 * ...
	 * @author marc
	 */
	public class GC 
	{
		public static const SCREEN_WIDTH:Number = 640;
		public static const SCREEN_HEIGHT:Number = 480;
		public static const PLAYER_SPEED:Number = 2;
		public static const PLAYER_SPRITE_FR:Number = 1/4; // Player-Sprite Animation-Framerate
		
		[Embed(source = '../assets/gfx/level-tiles.png')]
		public static const ROOM_TILES:Class;
		public static const ROOM_TILES_RECT:Array = [192, 128];
		
	}	

}