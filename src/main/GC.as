package main 
{
	import worlds.Playground;
	/**
	 * ...
	 * @author marc
	 */
	public class GC 
	{
		
		//some defaults
		public static const SCREEN_WIDTH:uint = 640;
		public static const SCREEN_HEIGHT:uint = 480;
		
		public static const PLAYER_SPEED:uint = 2;				// Pixel per Frame;
		public static const PLAYER_SPRITE_FR:Number = 1 / 4; 	// Player-Sprite Animation-Framerate
		public static const PLAYER_POWERUP_TIME:Number = 250;
		public static const PLAYER_RESPAWN_TIME:Number = 250;
		public static const PLAYER_INVULNERABLE_TIME:Number = 64;
		
		public static const ENEMY_SPEED:Number = 1; 				// Pixel per Frame;
		public static const ENEMY_SPRITE_FR:Number = 1 / 4;		
		
		public static const GOODY_REGENERATION_TIME:Number = 600;
		public static const NUKY_RESPAWN_CHANCE:uint = 15;
		
		public static const MUSIC_VOLUME:Number = 1;
		public static const SOUND_VOLUME:Number = 1;
		
		
		//for handling the Ogmo-Level (tiles are defined by x and y - coords only) 
		public static const ROOM_TILES_COLLUMS:int = 7;
		
		
		// Graphic-layer
		public static const LAYER_PLAYER:int = 1;
		public static const LAYER_ENEMIES:int = 2;
		public static const LAYER_GOODIES:int = 3;
		public static const LAYER_INFOS:int = 4;
		public static const LAYER_ROOM:int = 50;
		public static const LAYER_BACKGROUND:int = 100;
		
		
		
		//Level-data
/*		[Embed(source = '../assets/levels/testlevel2.oel', mimeType = 'application/octet-stream')]
		public static const LEVEL_1:Class;
		
		[Embed(source = '../assets/levels/testlevel.oel', mimeType = 'application/octet-stream')]
		public static const LEVEL_2:Class;*/
		
		[Embed(source = '../assets/levels/level.oel', mimeType = 'application/octet-stream')]
		public static const LEVEL_3:Class;
		
		[Embed(source = '../assets/levels/level2.oel', mimeType = 'application/octet-stream')]
		public static const LEVEL_4:Class;
		
		
	}	

}