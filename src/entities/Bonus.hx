package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.tmx.TmxObject;

class Bonus extends Entity
{	
	public function new (obj:TmxObject)
	{
		super(obj.x, obj.y);
		
		type = "bonus";
		layer = 1;
		setHitbox(obj.width, obj.height);
		
		var s = new Spritemap("gfx/bonus.png", 20, 20);
		s.add("bonusing", [1,2,3,4,5,6,7], 10, true);
		s.play("bonusing");
		graphic = s;
	}
}
