package entities 
{
	import main.GC;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author marc
	 */
	public class Goody extends Entity 
	{
		public var _goodyType:String;
		
		private var spriteMap:Spritemap = new Spritemap(GC.GOODIES_TILES, 32, 32);
		
		
		public function Goody(goodyType:String,startX:uint, startY:uint) 
		{
			type = "goody";
			_goodyType = goodyType;
			
			spriteMap.add("water", [1], 0, false);
			spriteMap.add("sun", [2], 0, false);
			spriteMap.add("wind", [3], 0, false);
			
			spriteMap.play(_goodyType);
			
			graphic = spriteMap;
			super(startX, startY)
		}
		
	}

}