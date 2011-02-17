package main
{
	import entities.splash.Splash;
	import net.flashpunk.Engine;
	import main.GC;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import worlds.*
	import flash.utils.*;
	
	/**
	 * ...
	 * @author 		marc wesemeier 2011
	 * @version 	0.4
	 * 
	 * @poweredBy 	flashpunk 1.5 
	 * @web 		http://www.flashpunk.net
	 * 
	 * Flashpunk Copyright © 2010 Chevy Ray Johnston
	 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
	 * files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
	 * modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software 
	 * is furnished to do so, subject to the following conditions:
	 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
	
	 * TODO provide consistency of sprite\spritemap vars in entities
	 * TODO check: startX und startY in every Entity -> point ?
	 * TODO implement things: Player-Follow, 'Energy-Mix', Fleeing(?)
	 * 
	 */
	public class Supergreen extends Engine
	{
		public function Supergreen():void 
		{
			super(GC.SCREEN_WIDTH, GC.SCREEN_HEIGHT, 64, true);
		}
		
		override public function init():void 
		{
			var s:Splash = new Splash(0xFF3366,0x202020, 40, 80, 30, 720);
			FP.world.add(s);
			s.start(new Intro);
		}
		
		private function onSplashComplete():void {
			//FP.world = new GameLost();
			//FP.world = new GameWon();
			
			//FP.world = new Playground();
			//FP.console.enable();
			//FP.console.toggleKey = 111;
			//FP.world = new Intro();
		}
		
		
		
		
	}
	
}