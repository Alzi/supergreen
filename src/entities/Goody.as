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
			// I don't understand it, but it it important for collision purposes to call this first
			// I think it is because the _class variable isn't set before this call
			super(startX, startY);
			
			type = "goody";
			_goodyType = goodyType;
			layer = GC.LAYER_GOODIES;
			setHitbox(30, 30, -1, -1);
					
			spriteMap.add("water", [1,8,9,10,8], 1/6, true);
			spriteMap.add("sun", [2,12,13,14,12], 1/6, true);
			spriteMap.add("wind", [3,16,17,18,16], 1/6, true);
			
			spriteMap.play(_goodyType);
			
			graphic = spriteMap;
			
		}
		
		override public function update():void {
			super.update();
		}
		
	}

}