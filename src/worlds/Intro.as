package worlds 
{
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import main.SoundManager;
	import main.GC;
	import main.GFX;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.tweens.misc.NumTween;
	
	import net.flashpunk.utils.Input;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author marc
	 */
	
	public class Intro extends World 
	{
		
		private var welcomeText:Text = new Text("Welcome to Supergreen!", 213, 109, 200, 30);
		private var clickText:Text = new Text("press any key!",250,430,150,30);
		private var hasPlayedSound:Boolean = false;
		private var fadeIn:VarTween = new VarTween();
		private var titlePic:Image = new Image(GFX.TITLE_SCREEN);
		private var playerSprite:Spritemap = new Spritemap (GFX.PLAYER, 32, 32);
		private var goodyWater:Spritemap = new Spritemap (GFX.GFX_GOODIES, 32, 32);
		private var goodySun:Spritemap = new Spritemap (GFX.GFX_GOODIES, 32, 32);
		private var goodyWind:Spritemap = new Spritemap (GFX.GFX_GOODIES, 32, 32);
		private var enemyBlack:Spritemap = new Spritemap (GFX.BLACKY, 32, 32);
		private var enemyYellow:Spritemap = new Spritemap (GFX.YELLY, 32, 32);
		private var nuky:TiledImage = new TiledImage(GFX.GFX_GOODIES, 32, 32);
		private var nukyList:Graphiclist = new Graphiclist();
		private var movePlayer:NumTween = new NumTween (onEatenAllGoodies);
						
		public function Intro() 
		{
			super();
		}
		
		override public function begin():void {
			FP.screen.color = 0x000000;
			titlePic.x = 15;
			clickText.alpha = 0;
			
			
			//TODO maby I should use real entities for this...
			
			//nukyList.add (new TiledImage(GFX.GFX_GOODIES, 32, 32));
			//nukyList.add (new TiledImage(GFX.GFX_GOODIES, 32, 32)).x = 32;
			//nukyList.add (new TiledImage(GFX.GFX_GOODIES, 32, 32)).x = 64;
			//nukyList.add (new TiledImage(GFX.GFX_GOODIES, 32, 32)).x = 96;
			//nukyList.y = 347;
			//nukyList.x = 150;
					
						
			playerSprite.add("right", [6, 6, 7, 8, 9, 10, 11, 8], GC.PLAYER_SPRITE_FR, true);
			playerSprite.add("left", [0,0,1,2,3,4,5,2], GC.PLAYER_SPRITE_FR, true);
			playerSprite.play("right");
			
			goodyWater.add("move", [1, 8, 9, 10, 8], 1 / 6, true);
			goodyWater.play("move");
			goodyWater.x = 350;
			goodyWater.scale = 0.8;
			
			goodySun.add("move", [2,12,13,14,12], 1 / 6, true);
			goodySun.play("move");
			goodySun.x = 400;
			goodySun.scale = 0.8;
			
			goodyWind.add("move", [3, 16, 17, 18, 16], 1 / 6, true);
			goodyWind.play("move");
			goodyWind.x = 450;
			goodyWind.scale = 0.8;
			
			goodyWater.y = goodySun.y = goodyWind.y = 350;
			
			playerSprite.y = 345;
					
			addGraphic(titlePic);
			addGraphic(clickText);
			
			addGraphic(goodyWater);
			addGraphic(goodySun);
			addGraphic(goodyWind);
			addGraphic(nukyList);
			
			addGraphic(playerSprite);
			
			addTween(fadeIn, true);
			addTween(movePlayer);
			movePlayer.tween( -10, 450, 220);
			
			SoundManager.i.playSound("player_start",0.6, 0, onSoundPlayed);
		}
			
		override public function update():void {
			super.update();
			playerSprite.x = movePlayer.value;
			
				
			if (movePlayer.value >= goodyWater.x) {
				goodyWater.visible = false;
			}
			
			if (movePlayer.value >= goodySun.x) {
				goodySun.visible = false;
			}
			
			if (movePlayer.value >= goodyWind.x) {
				goodyWind.visible = false;
			}
			
			
			if (Input.check(Key.ANY) && hasPlayedSound) {
				FP.world = new Playground();
			}
		}
		
		private function onSoundPlayed():void {
			fadeIn.tween(clickText, "alpha", 1, 15, Ease.quartOut);
			hasPlayedSound = true;
		}
		
		private function onEatenAllGoodies():void {
			playerSprite.play("left");
			if (movePlayer.value > 400) {
				movePlayer.tween(450, -40, 180);
			}
			
		}
	}
}