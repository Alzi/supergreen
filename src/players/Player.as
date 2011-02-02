package players 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import main.GC;
	
	/**
	 * ...
	 * @author marc
	 */
	public class Player extends Entity 
	{
		[Embed(source = '../assets/gfx/player.png')]
		private const PLAYER:Class;
		private var player_sprite:Image;
		private var direction:Number;
		
		public function Player() 
		{
			//FIXME maskierung ändern, (tileSet benutzen)
			player_sprite = new Image(PLAYER, new Rectangle(0, 0, 32, 32));
			graphic = player_sprite;
			
			//define Inputs
			Input.define("left", Key.LEFT, Key.A);
			Input.define("right", Key.RIGHT, Key.D);
			Input.define("up", Key.UP, Key.W);
			Input.define("down", Key.DOWN, Key.S);
					
			// set Player to Coordinates (x,y)
			super(60, 40);
		}
		
		override public function update():void 
		{
			//check Input
			if (Input.pressed("left")) {
				this.direction = 1;
			}
			if (Input.pressed("right")) {
				this.direction = 2;
			}
			if (Input.pressed("up")) {
				this.direction = 3;
			}
			if (Input.pressed("down")) {
				this.direction = 4;
			}
			
			//move character
			switch(this.direction) {
				case 1:
				x -= GC.PLAYER_SPEED;
				break;
				case 2:
				x += GC.PLAYER_SPEED;
				break;
				case 3:
				y -= GC.PLAYER_SPEED;
				break;
				case 4:
				y += GC.PLAYER_SPEED;
			}
			super.update();
		}
		
	}

}