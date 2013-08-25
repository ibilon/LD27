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
	public var sfx_button:Sfx;
	
	public var timer : Float = 10;
	public var alive : Bool = true;
	private var onPlatform : Platform;
	
	public function new (xx:Float, yy:Float)
	{
		super();
		
		graphic = new Image("gfx/player.png");
		setHitboxTo(graphic);
		type = "player";
		layer = 0;
		
		x = xx;
		y = yy;
		
		sfx_jump = new Sfx("sfx/jump.wav");
		sfx_teleport = new Sfx("sfx/teleport.wav");
		sfx_death = new Sfx("sfx/death.wav");
		sfx_bonus = new Sfx("sfx/coin.wav");
		sfx_button = new Sfx("sfx/button.wav");
	}
	
	override public function update ()
	{
		var img = cast(graphic, Image);
		
		timer -= HXP.elapsed;
		if (timer <= 0)
		{
			inJump = true;
			timer = 10;
			sens *= -1;
			
			
			img.scaleY = sens;
			
			if (sens == -1)
				img.y = img.height;
			else
				img.y = 0;
		}
		
		// Player input.
		var hInput:Int = 0;		
		if(Input.check(Key.LEFT)) { img.scaleX = -1; img.x = img.width; hInput -= 1; }
		if(Input.check(Key.RIGHT)) { img.scaleX = 1; img.x = 0; hInput += 1; }
		if(Input.pressed(Key.SPACE) && !inJump) { sfx_jump.play(); vy = -JUMP*sens; inJump = true; }
		
		// Update physics.
		vy += GRAVITY*sens;
		
		// Apply physics.
		var coll =  ["solid", "kill", "bonus", "door"];
		
		moveBy(HSPEED*hInput*HXP.elapsed, vy*HXP.elapsed, coll);
		if (onPlatform != null && !inJump)
			moveBy(onPlatform.move, 0, coll);
		
		// buttons
		var e = collide("button", x, y);
		if (e != null && Input.pressed(Key.CONTROL))
		{
			sfx_button.play();
			cast(scene, scenes.Game).open(cast(e, Button));
		}
				
		// portals
		var e = collide("portal", x, y);
		if (e != null && Input.pressed(Key.CONTROL))
		{
			sfx_teleport.play();
			cast(scene, scenes.Game).teleport(cast(e, Portal).to);
		}		
		
		if (x+width < 0 || y+height < 0 || x > HXP.screen.width || y > HXP.screen.height)
			cast(scene, scenes.Game).exit();
		
		super.update();
	}
	
	override public function moveCollideX (e:Entity) { return moveCollideBy(e, "X"); }
	override public function moveCollideY (e:Entity) { return moveCollideBy(e, "Y"); }	
	private function moveCollideBy (e:Entity, dir:String)
	{
		switch (e.type)
		{			
		case "kill":
			var k = cast(e, Kill);			
			if ( (y > k.y && k.etype == "top") || (y < k.y && k.etype == "bottom") )
			{
				if (vy*sens > 0) 
					inJump = false;
					
				vy = 0;
				return true;
			}
		
			sfx_death.play();
			alive = active = false;
			cast(scene, scenes.Game).died();
			
		case "door":
			return cast(e, Door).close;
		
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
