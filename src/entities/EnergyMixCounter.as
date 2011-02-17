package entities 
{
	import flash.display.Sprite;
	import flash.events.IMEEvent;
	import net.flashpunk.Entity;
	import main.GC;
	import main.GFX;
	import main.GV;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author marc
	 */
	public class EnergyMixCounter extends Entity 
	{
		public var water:Spritemap = new Spritemap(GFX.ENERGY_MIX, 22, 21);
		public var sun:Spritemap = new Spritemap(GFX.ENERGY_MIX, 22, 21);
		public var wind:Spritemap = new Spritemap(GFX.ENERGY_MIX, 22, 21);
		private var energyMix:Graphiclist = new Graphiclist(water, sun, wind);
		
		private var fadeOutWater:VarTween = new VarTween(onFadeOutWater)
		private var bounceInWater:VarTween = new VarTween(onBounceInWater);
		
		private var fadeOutSun:VarTween = new VarTween(onFadeOutSun)
		private var bounceInSun:VarTween = new VarTween(onBounceInSun);
		
		private var fadeOutWind:VarTween = new VarTween(onFadeOutWind)
		private var bounceInWind:VarTween = new VarTween(onBounceInWind);
		
		private var superHeroTimer:Alarm = new Alarm(GC.PLAYER_POWERUP_TIME, setInvisible);
		
		public function EnergyMixCounter(startX:uint, startY:uint):void
		{
			super(startX, startY);
			layer = GC.LAYER_INFOS;
			graphic = energyMix;
			water.x = 0;
			sun.x = 23;
			wind.x = 46;
			type = "energymix";
			
			water.setFrame(0, 0);
			sun.setFrame(1,0);
			wind.setFrame(2, 0);
			
			addTween(fadeOutWater, false);
			addTween(fadeOutSun, false);
			addTween(fadeOutWind, false);
			
			addTween(bounceInWater, false);
			addTween(bounceInSun, false);
			addTween(bounceInWind, false);
			
			addTween (superHeroTimer, false);
			
			setInvisible();
		}
		
		
		public function setInvisible():void {
			water.visible = false;
			sun.visible = false;
			wind.visible = false;
			fadeOutSun.active = fadeOutWater.active = fadeOutWind.active = false;
			bounceInSun.active = bounceInWater.active = bounceInWind.active = false;
			water.alpha = 1;
			water.scale = 1;
			sun.alpha = 1;
			sun.scale = 1;
			wind.alpha = 1;
			wind.scale = 1;
		}
		
		public function goSuperhero():void {
			superHeroTimer.start();
			fadeOutWater.tween(water, "alpha", 0, 15, Ease.circIn);
			
		}
		
		private function onFadeOutWater():void {
			water.scale = 1;
			water.alpha = 0.8;
			fadeOutSun.tween(sun, "alpha", 0, 15, Ease.circIn);
			bounceInWater.tween(water, "scale", 1, 15, Ease.bounceOut);
		}
		
		private function onFadeOutSun():void {
			sun.alpha = 1;
			sun.scale = 0.8;
			fadeOutWind.tween(wind, "alpha", 0, 15, Ease.circIn);
			bounceInSun.tween(sun, "scale", 1, 15, Ease.bounceOut);
		}
		
		
		private function onFadeOutWind():void {
			wind.alpha = 1;
			wind.scale = 0.8;
			bounceInWind.tween(wind, "scale", 1, 15, Ease.bounceOut);
		}
			
		
		private function onBounceInWater():void {
			fadeOutWater.start();
		}
				
		private function onBounceInSun():void {
			fadeOutSun.start();
		}
				
		private function onBounceInWind():void {
			fadeOutWind.start();
		}
	}

}