package scenes;

import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class MainMenu extends Scene
{
	override public function begin ()
	{		
		addGraphic(new Image("gfx/back.png"));
		var opt = {color: 0, size: 30, align: "center", font: "font/LinLibertine_R.ttf"};
		
		var title = new Text("0.1 Hertz", {color: 0, size: 68, align: "center", font: "font/LinLibertine_R.ttf"});
		addGraphic(title, 0, HXP.halfWidth - title.width/2, 35);
		
		var ld = new Text("Ludum Dare 27\nAugust 23rd-26th\nTheme: 10 Seconds", opt);
		addGraphic(ld, 0, HXP.halfWidth - ld.width/2, 140);
		
		var cp = new Text("A game by Valentin Lemiere\nhttp://www.ibilon.com/", opt);
		addGraphic(cp, 0, HXP.halfWidth - cp.width/2, 290);
		
		var space = new Text("PRESS SPACE TO START", opt);
		addGraphic(space, 0, HXP.halfWidth - space.width/2, 420);
	}
	
	override public function update ()
	{
		if (Input.check(Key.SPACE))
			HXP.scene = new Game();
	}
}
