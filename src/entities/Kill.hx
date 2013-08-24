package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.tmx.TmxObject;

class Kill extends Entity
{	
	public function new (obj:TmxObject)
	{
		super(obj.x, obj.y);
		
		type = "kill";
		setHitbox(obj.width, obj.height);
	}
}
