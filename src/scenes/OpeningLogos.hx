package scenes;

import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;

import entities.Logo;

class OpeningLogos extends Scene
{
	private var logo : Logo;
	
	override public function begin ()
	{
		super.begin();
		
		addGraphic(new Image("gfx/back.png"));
		add(logo = new Logo("gfx/ibilon.png", step1));
	}	
	
	private function step1 ()
	{
		remove(logo);
		add(logo = new Logo("gfx/HaxePunk.png", step2));
	}
	
	private function step2 ()
	{
		HXP.scene = new MainMenu();
	}
}
