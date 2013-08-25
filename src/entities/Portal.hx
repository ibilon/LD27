package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.tmx.TmxObject;

class Portal extends Entity
{
	public var id:String;
	public var to:String;
	
	public function new (obj:TmxObject)
	{
		super(obj.x, obj.y);
		
		type = "portal";
		layer = 1;
		
		var img = new Image("gfx/portal.png");
		img.color = Std.parseInt(obj.custom.resolve("color"));
		graphic = img;
		setHitboxTo(graphic);
		
		id = obj.name;
		to = obj.custom.resolve("to");
	}
}
