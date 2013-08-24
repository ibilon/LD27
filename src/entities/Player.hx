package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import flash.geom.Point;

class Player extends Entity
{
	private static inline var HSPEED:Int = 80;
	private var GRAVITY:Int = 4;
	private static inline var JUMP:Int = 200;
	
	private var vy:Float = 0;
	private var sens:Int = 1;
	private var inJump:Bool = true;
	
	private var sfx_jump:Sfx;
	private var sfx_teleport:Sfx;
	private var sfx_death:Sfx;
	private var sfx_bonus:Sfx;
	
	private var timer : Float = 10;
	private var alive : Bool = true;
	private var onPlatform : Platform;
	
	override public function added ()
	{
		graphic = Image.createRect(20, 20, 0xFF0000);
		setHitboxTo(graphic);
		type = "player";
		
		x = y = 6*32;
		
		sfx_jump = new Sfx("sfx/jump.wav");
		sfx_teleport = new Sfx("sfx/teleport.wav");
		sfx_death = new Sfx("sfx/death.wav");
		sfx_bonus = new Sfx("sfx/coin.wav");
	}
	
	override public function update ()
	{
		timer -= HXP.elapsed;
		if (timer <= 0)
		{
			timer = 10;
			sens *= -1;
			inJump = true;
		}
		
		// Player input.
		var hInput:Int = 0;		
		if(Input.check(Key.LEFT)) hInput -= 1;
		if(Input.check(Key.RIGHT)) hInput += 1;
		if(Input.pressed(Key.SPACE) && !inJump) { sfx_jump.play(); vy = -JUMP*sens; inJump = true; }
		
		// Update physics.
		vy += GRAVITY*sens;
		
		// Apply physics.
		moveBy(HSPEED*hInput*HXP.elapsed, vy*HXP.elapsed, ["solid", "portal", "kill", "bonus"]);
		if (onPlatform != null && !inJump)
			moveBy(onPlatform.move, 0, ["solid", "portal", "kill", "bonus"]);
		
		super.update();
	}
	
	override public function moveCollideX (e:Entity) { return moveCollideBy(e, "X"); }
	override public function moveCollideY (e:Entity) { return moveCollideBy(e, "Y"); }	
	private function moveCollideBy (e:Entity, dir:String)
	{
		switch (e.type)
		{
		case "portal":
			sfx_teleport.play();
			cast(scene, scenes.Game).teleport(cast(e, Portal).to);
			inJump = true;			
			
		case "kill":
			sfx_death.play();
			active = false;
			cast(scene, scenes.Game).died();
			
		case "bonus":
			sfx_bonus.play();
			scene.remove(e);
			return false;
		
		case "solid":
			if (dir == "Y")
			{			
				if (vy*sens > 0) 
				{
					inJump = false;
					onPlatform = Std.is(e, Platform) ? cast(e, Platform) : null;
				}
				vy = 0;
			}
		}
			
		return true;
	}
}
