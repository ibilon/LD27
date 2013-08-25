package scenes;

import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import flash.text.TextFormatAlign;

class End extends Scene
{
	override public function begin ()
	{		
		addGraphic(new Image("gfx/back.png"));
		
		#if flash
		var opt = {color: 0, size: 30, align: TextFormatAlign.CENTER, font: "font/LinLibertine_R.ttf"};
		#else
		var opt = {color: 0, size: 30, align: "center", font: "font/LinLibertine_R.ttf"};
		#end
		
		#if flash
		var title = new Text("0.1 Hertz", {color: 0, size: 68, align: TextFormatAlign.CENTER, font: "font/LinLibertine_R.ttf"});
		#else
		var title = new Text("0.1 Hertz", {color: 0, size: 68, align: "center", font: "font/LinLibertine_R.ttf"});
		#end
		addGraphic(title, 0, HXP.halfWidth - title.width/2, 35);
		
		var ld = new Text("You've won :)\nCongratulation!", opt);
		addGraphic(ld, 0, HXP.halfWidth - ld.width/2, 140);
		
		var cp = new Text("A game by Valentin Lemiere\nhttp://www.ibilon.com/", opt);
		addGraphic(cp, 0, HXP.halfWidth - cp.width/2, 290);
		
		var space = new Text("PRESS SPACE TO RELAUNCH", opt);
		addGraphic(space, 0, HXP.halfWidth - space.width/2, 420);
	}
	
	override public function update ()
	{
		if (Input.pressed(Key.SPACE))
			HXP.scene = new MainMenu();
	}
}
