import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;

class Main extends Engine
{	
	public function new ()
	{
		super(640, 480, 60);
	}
	
	override public function init()
	{
		
	#if debug 
		HXP.console.enable();
		HXP.scene = new scenes.Game();
	#else	
		HXP.scene = new scenes.MainMenu();
	#end
	}

	public static function main() 
	{
		new Main();
	}
}
