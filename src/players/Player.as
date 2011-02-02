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
		private var player_sprite:Spritemap = new Spritemap(PLAYER, 32, 32);
		private var direction:Number = 1; //Default-Direction = left
		
		public function Player() 
		{
			player_sprite.add("left", [0,1,2,1], GC.PLAYER_SPRITE_FR, true);
			player_sprite.add("right", [4,5,6,5], GC.PLAYER_SPRITE_FR, true);
			player_sprite.add("up", [8,9,10,9], GC.PLAYER_SPRITE_FR, true);
			player_sprite.add("down", [12,13,14,13], GC.PLAYER_SPRITE_FR, true);
			
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
				player_sprite.play("left");
			}
			if (Input.pressed("right")) {
				this.direction = 2;
				player_sprite.play("right");
			}
			if (Input.pressed("up")) {
				this.direction = 3;
				player_sprite.play("up");
			}
			if (Input.pressed("down")) {
				this.direction = 4;
				player_sprite.play("down");
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