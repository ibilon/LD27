package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import flash.geom.Point;

class Player extends Entity
{
	private static inline var HSPEED:Int = 80;
	private var GRAVITY:Int = 4;
	private static inline var JUMP:Int = 150;
	
	private var vect:Point;
	private var sens:Int = 1;
	private var inJump:Bool = true;
	
	override public function added ()
	{
		graphic = Image.createRect(20, 20, 0xFF0000);
		setHitboxTo(graphic);
		
		x = y = 5*32;
		vect = new Point();
	}
	
	override public function update ()
	{
		// Player input.
		var hInput:Int = 0;
		
		if(Input.check(Key.LEFT)) hInput -= 1;
		if(Input.check(Key.RIGHT)) hInput += 1;
		if(Input.pressed(Key.SPACE) && !inJump) { vect.y = -JUMP*sens; inJump = true; }
		if(Input.pressed(Key.A)) { sens *= -1; inJump = true; }
		
		// Update physics.
		vect.x = HSPEED * hInput;
		vect.y += GRAVITY*sens;
		
		// Apply physics.
		moveBy(vect.x*HXP.elapsed, vect.y*HXP.elapsed, "solid");
		
		super.update();
	}
	
	override public function moveCollideY (e:Entity)
	{
		if ( (sens == 1 && vect.y > 0) || (sens == -1 && vect.y < 0) ) inJump = false;
		vect.y = 0;
		return true;
	}
}
