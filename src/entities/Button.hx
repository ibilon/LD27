package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.tmx.TmxObject;

class Button extends Entity
{	
	public var dest:String;
	
	public function new (obj:TmxObject)
	{
		super(obj.x, obj.y);
		
		type = "button";
		layer = 1;
		graphic = new Image("gfx/button.png");
		setHitboxTo(graphic);
		
		dest = obj.custom.resolve("activate");
	}
	
	public function click ()
	{
		type = "";
		graphic = null;
	}
}
