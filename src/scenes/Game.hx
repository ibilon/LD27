package scenes;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.tmx.*;
import flash.display.BitmapData;

import entities.*;

class Game extends Scene
{
	private var portals : Map<String, Portal>;
	private var player : Player;
	
	override public function begin ()
	{
		addGraphic(new Image("gfx/back.png"));
		
		portals = new Map<String, Portal>();
		
		var map : TmxMap = new TmxMap(openfl.Assets.getText("maps/test.tmx"));
		var bitmapData : BitmapData = openfl.Assets.getBitmapData('gfx/tileset.png', true);
		
		var e = new TmxEntity(map);//, bitmapData, checkTiles, ["layer1"]);
		e.loadGraphic(bitmapData, ["layer1"]);
		//e.setCollidable(checkTiles, "ground");
		e.loadMask("collision", "solid");
		add(e);
		
		for(object in map.getObjectGroup("objects").objects)
		{
			switch (object.type)
			{
			case "portal":
				var p = add(new Portal(object));
				portals.set(object.name, p);
				
			case "kill":
				add(new Kill(object));
				
			case "bonus":
				add(new Bonus(object));
				
			case "platform":
				add(new Platform(object));
				
			default:
				trace("unknown type: " + object.type);
			}
		}		
		
		add(player = new Player());
	}
	
	public function teleport (id:String)
	{		
		var portal = portals.get(id);
		player.x = portal.ex;
		player.y = portal.ey;
	}
	
	public function died ()
	{
		trace("You died.");
	}
}
