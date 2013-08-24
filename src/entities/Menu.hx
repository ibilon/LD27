package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Text;

class Menu extends Entity
{
	private var onClick : Int->Void;
	private var objs : Array<Item>;
	private var current:Int = 0;
	
	public function new (it:Array<String>, click:Int->Void, menu:scenes.MainMenu)
	{
		super();
		
		onClick = click;		
		objs = new Array<Item>();
		
		for (i in 0...it.length)
		{
			objs[i] = new Item(it[i], i, menu);
		}
		
		objs[0].hover();
	}
	
	override public function update ()
	{
		super.update();
		
		objs[current].leave();
		
		var e = HXP.scene.collidePoint("menuitem", Input.mouseX+HXP.camera.x, Input.mouseY+HXP.camera.y);	
		
		if (e != null) // Mouse on a menu item.
		{
			var i = cast(e, Item);
			current = i.id;
		}
		else
		{
			if (Input.pressed(Key.UP)) current--;
			if (Input.pressed(Key.DOWN)) current++;
			
			current = current < 0 ? 0 : (current > objs.length - 1 ? objs.length - 1 : current);
		}
		
		objs[current].hover();	
		
		if (Input.pressed(Key.ENTER) || (Input.mouseReleased && e != null)) onClick(current);
	}
}
