package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.tmx.TmxObject;

class Portal extends Entity
{
	public var ex:Float;
	public var ey:Float;
	public var id:String;
	public var to:String;
	
	public function new (obj:TmxObject)
	{
		super(obj.x, obj.y);
		
		type = "portal";
		graphic = Image.createRect(16, 32, 0x0000FF);
		setHitboxTo(graphic);
		
		ex = x + 17;
		ey = y;
		id = obj.name;
		to = obj.custom.resolve("to");
	}
}
