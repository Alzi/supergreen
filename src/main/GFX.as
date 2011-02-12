package main 
{
	/**
	 * ...
	 * @author marc
	 * TODO get rid off 'GFX_'-prefixes
	 */
	public class GFX 
	{
		[Embed(source = '../assets/gfx/goodies.png')]
		public static const GFX_GOODIES:Class;
		
		[Embed(source = '../assets/gfx/level-tiles.png')]
		public static const GFX_LEVELTILES:Class;
		
		//TODO rename Gfx-File
		[Embed(source = '../assets/gfx/player.png')]
		public static const PLAYER:Class;
		
		[Embed(source = '../assets/gfx/ghost-tiles.png')]
		public static const GFX_ENEMIES:Class;
		
		[Embed(source = '../assets/gfx/background.jpg')]
		public static const GFX_BACKGROUND:Class;
		
		[Embed(source = '../assets/gfx/flower.png')]
		public static const GFX_FLOWER:Class;
		
		[Embed(source = '../assets/gfx/ghost-ghost.png')]
		public static const GFX_ENEMY_GHOST:Class;
		
		[Embed(source = '../assets/gfx/kill-points.png')]
		public static const GFX_KILL_POINTS:Class;
		
	}

}