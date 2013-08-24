package entities;

import com.haxepunk.Entity;
import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;

class Item extends Entity
{
	private var text : Text;
	public var id : Int;
	
	public function new (t:String, i:Int, menu:Scene)
	{
		super();
		type = "menuitem";
		
		id = i;
		text = new Text(t, {size: 40, color: 0, font: "font/angelina.ttf"});
		graphic = text;
		setHitboxTo(text);
		
		x = HXP.halfWidth - text.width/2;
		y = 180 + 60*id;
		
		menu.add(this);
	}
	
	public function hover ()
	{
		text.color = 0x0000FF;
	}
	
	public function leave ()
	{
		text.color = 0;
	}
}
