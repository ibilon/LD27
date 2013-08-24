import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;

class Main extends Engine
{
	static var music : Sfx;
	
	public function new ()
	{
		super(640, 480, 60);
	}
	
	override public function init()
	{
		music = new Sfx("sfx/bu-the-forests-villages.mp3");
		
	#if debug
		HXP.console.enable();
		HXP.scene = new scenes.Game();
	#else		
		music.loop();		
		HXP.scene = new scenes.OpeningLogos();
	#end
	}

	public static function main() 
	{
		new Main();
	}
}
