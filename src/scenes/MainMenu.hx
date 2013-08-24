package scenes;

import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;

import entities.Menu;

class MainMenu extends Scene
{
	private var menu : Menu;
	
	override public function begin ()
	{		
		addGraphic(new Image("gfx/back.png"));
		
		var title = new Image("gfx/title.png");
		var title_e = addGraphic(title, 0, HXP.halfWidth - title.width/2, 60);
		
		var items = new Array<String>();
		items[items.length] = " New ";
		items[items.length] = " Continue ";
		
		add(menu = new Menu(items, menuClicked, this));
	}
	
	private function menuClicked (id:Int)
	{
		menu.active = false;
		
		switch (id)
		{
		case 0:
			HXP.scene = new scenes.Game();
		case 1:
			HXP.scene = new scenes.Instructions();
		case 2:
			HXP.scene = new scenes.Options();
		case 3:
			HXP.scene = new scenes.Credits();
		default:
			trace("[Error] Unrecognise menu item id: " + id);
		}
	}
}
