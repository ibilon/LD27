package graphs;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;

import flash.display.BitmapData;
import flash.geom.Point;

class PlatGr extends Graphic
{
	private var border : Image;
	private var center : Image;
	
	public function new (w:Int, h:Int)
	{
		super();
		
		border = Image.createRect(w, h, 0xA06421);
		center = Image.createRect(w-4, h-4, 0xE09A4C);		
	}
	
	override public function render(target:BitmapData, point:Point, camera:Point)
	{
		border.render(target, point, camera);
		center.render(target, new Point(point.x+2, point.y+2), camera);
	}
}
