package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.tmx.TmxObject;

class Platform extends Entity
{
	private var length:Float;
	private var start:Float;
	private var sens:Int = 1;
	private var speed:Int;
	
	public var move:Float = 0;
	
	public function new (obj:TmxObject)
	{
		super(obj.x, obj.y);
		
		type = "solid";
		width = Std.parseInt(obj.custom.resolve("length"))*32;
		height = obj.height;		
		graphic = Image.createRect(width, obj.height, 0x111111);
		
		length = obj.width;
		speed = Std.parseInt(obj.custom.resolve("speed"));
		start = x;
	}
	
	override public function update ()
	{
		if ( (sens == 1 && x-start+width >= length) || (sens == -1 && x <= start) )
			sens *= -1;
		
		moveBy(move = speed*sens*HXP.elapsed, 0, ["solid", "player"]);
	}
}
