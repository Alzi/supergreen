package main
{
	import net.flashpunk.Sfx;

	public final class SoundManager
	{
		private static var instance:SoundManager = new SoundManager();
		private var _currentMusic:Sfx;

		[Embed(source = '../assets/audio/munch.mp3')]
		public const MUNCH:Class;
		
		[Embed(source = '../assets/audio/goody-sun.mp3')]
		public const GOODY_SUN:Class;
		
		[Embed(source = '../assets/audio/goody-water.mp3')]
		public const GOODY_WATER:Class;
		
		[Embed(source = '../assets/audio/goody-wind.mp3')]
		public const GOODY_WIND:Class;
		
		[Embed(source = '../assets/audio/superhero-loop.mp3')]
		public const SUPERHERO:Class;
		
		[Embed(source = '../assets/audio/superhero-end.mp3')]
		public const SH_END:Class;
		
		[Embed(source = '../assets/audio/enemy-killed.mp3')]
		public const ENEMY_KILLED:Class;
		
		[Embed(source = '../assets/audio/hero-killed.mp3')]
		public const HERO_KILLED:Class;
		
		[Embed(source = '../assets/audio/goody-reapear.mp3')]
		public const GOODY_REAPEAR:Class;
		
		[Embed(source = '../assets/audio/nuky-spawn.mp3')]
		public const NUKY_SPAWN:Class;
		
		[Embed(source = '../assets/audio/supergreen-start.mp3')]
		public const PLAYER_START:Class;
		
		public var superheroLoop:Sfx = new Sfx(SUPERHERO);
		

		public static function get i():SoundManager
		{
			return instance;
		}

		public function get currentMusic():Sfx
		{
			return _currentMusic;
		}

		public function set currentMusic(music:Sfx):void
		{
			if(_currentMusic != music)
			{
			if(_currentMusic) _currentMusic.stop();
			_currentMusic = music;
			_currentMusic.volume = GC.MUSIC_VOLUME;
			_currentMusic.loop(GC.MUSIC_VOLUME);
			}
		}
		
		public function playSound(name:String, pad:Number=0, pan:Number=0, callback:Function=null):void
		{
			var s:Sfx = new Sfx(this[name.toUpperCase()], callback);
			s.play(GC.SOUND_VOLUME-pad, pan);
		}
		
		public function loopSound(sound:Sfx, vol:Number=1, delay:int = 0):void
		{
			sound.loop(vol,0, 51);
		}
		
		public function stopLoop(sound:Sfx):void
		{
			sound.stop();
		}
	}
}