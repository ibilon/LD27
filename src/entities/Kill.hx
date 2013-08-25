package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.tmx.TmxObject;

class Kill extends Entity
{	
	public var etype:String;
	
	public function new (obj:TmxObject)
	{
		super(obj.x, obj.y);
		
		type = "kill";
		layer = 1;
		setHitbox(obj.width, obj.height);
		
		etype = obj.custom.resolve("etype");
	}
}
