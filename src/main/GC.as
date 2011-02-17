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
		public static const PLAYER_POWERUP_TIME:Number = 600;
		public static const PLAYER_RESPAWN_TIME:Number = 250;
		public static const PLAYER_INVULNERABLE_TIME:Number = 64;
		
		public static const PLAYERS_START_LIFES:int = 4;
		public static const PLAYERS_START_POINTS:int = 0;
		
		public static const ENEMY_SPRITE_FR:Number = 1 / 10;
		
		//Blacky's and Yelly's Target-Points - if they're in scatter-mode
		public static const BLACKY_TARGET_X:int = 0;
		public static const BLACKY_TARGET_Y:int = 0;
		public static const BLACKY_TILES_AHEAD_PLAYER:int = 0;
		public static const BLACKY_START_SPEED:Number = 22;
		public static const BLACKY_END_SPEED:Number = 20;
		public static const BLACKY_START_DIRECTION:String = "left";
		
		
		public static const YELLY_TARGET_X:int = SCREEN_WIDTH;
		public static const YELLY_TARGET_Y:int = SCREEN_HEIGHT;
		public static const YELLY_TILES_AHEAD_PLAYER:int = 4;
		public static const YELLY_START_SPEED:Number = 20;
		public static const YELLY_END_SPEED:Number = 17;
		public static const YELLY_START_DIRECTION:String = "right";
				
		public static const GOODY_REGENERATION_TIME:Number = 600;
		public static const NUKY_RESPAWN_CHANCE:uint = 5;
		
		public static const MUSIC_VOLUME:Number = 0.5;
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