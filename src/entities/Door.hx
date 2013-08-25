package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.tmx.TmxObject;

class Door extends Entity
{
	public var close:Bool = true;
	
	public function new (obj:TmxObject)
	{
		super(obj.x, obj.y);
		
		type = "door";
		layer = 1;
		graphic = new Image("gfx/door.png");
		setHitboxTo(graphic);
	}
	
	public function open ()
	{
		close = false;
		graphic = null;
	}
}
