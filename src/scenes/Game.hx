package scenes;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.Sfx;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Tilemap;
import com.haxepunk.masks.Grid;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.tmx.*;

import entities.*;

class Game extends Scene
{
	private var portals : Map<String, Portal>;
	private var doors : Map<String, Door>;
	
	private var player : Player;
	private var music : Sfx;
	private var counter : Text;
	
	private var levels : Array<String>;
	private var currentLvl : Int;
	private var paused : Bool = false;
	private var paused_ent : Entity;
	
	override public function begin ()
	{
	#if !debug
		music = new Sfx("sfx/bu-the-forests-villages.mp3");
		music.loop();
	#end
		
		levels = ["level0", "level1", "level2", "level3", "level4", "level5", "level6", "level7"];
		
	#if debug
		currentLvl = 7;
	#else
		currentLvl = 0;
	#end
		load();
	}
	
	private function load ()
	{	
		removeAll();
		
		addGraphic(new Image("gfx/back.png"));
		var t = new Text("PAUSED", { size: 60, color: 0, font: "font/LinLibertine_R.ttf"});
		paused_ent = addGraphic(t, 0, HXP.halfWidth - t.width/2 - 1000, HXP.halfHeight - t.height/2);
		
		portals = new Map<String, Portal>();
		doors = new Map<String, Door>();
		
		var map : TmxMap = new TmxMap(openfl.Assets.getText("maps/"+levels[currentLvl]+".tmx"));
		
		var map_e = new TmxEntity(map);
		map_e.loadGraphic("gfx/tileset.png", ["layer"]);
		map_e.loadMask("collision", "solid");
		add(map_e);
		
		for(object in map.getObjectGroup("objects").objects)
		{
			switch (object.type)
			{
			case "portal":
				var p = add(new Portal(object));
				portals.set(object.name, p);
				
			case "mechanism":
				var d = add(new Door(object));
				doors.set(object.name, d);
				
			case "kill":
				add(new Kill(object));
				
			case "button":
				add(new Button(object));		
				
			case "platform":
				add(new Platform(object));
				
			case "start":
				player = add(new Player(object.x, object.y));
				
			case "text":
				var t = new Text(object.name, { size: 20, color: 0, font: "font/LinLibertine_R.ttf"});
				addGraphic(t, 1, object.custom.resolve("center") == "true" ? HXP.halfWidth - t.width/2 : object.x, object.y);
				
			default:
				trace("unknown type: " + object.type);
			}
		}
		
		counter = new Text("10:00", {size: 24, font: "font/LinLibertine_R.ttf"});
		addGraphic(counter, 0, HXP.halfWidth - counter.width/2, 0);
	}
	
	override public function update()
	{
		var t = player.timer;
		var i = StringTools.lpad(""+Std.int(t), "0", 2);
		var j = StringTools.lpad(""+Std.int((t - Std.int(t)) * 100), "0", 2);
		counter.text = i + ":" + j;
		
		if (Input.pressed(Key.ESCAPE)) togglePause();
		
		if (Input.pressed(Key.ENTER)) load();
		
		if (!paused && player.alive)
			super.update();
	}
	
	override public function focusGained() { togglePause(); }
	override public function focusLost() { togglePause(); }
	
	private function togglePause ()
	{
		paused = !paused;
		paused_ent.x += paused ? 1000 : -1000;
	}
	
	public function teleport (id:String)
	{		
		var portal = portals.get(id);
		player.x = portal.x;
		player.y = portal.y;
	}
	
	public function open (b:Button)
	{
		b.click();
		
		var door = doors.get(b.dest);
		door.open();
	}
	
	public function exit ()
	{		
		currentLvl++;
		
		if (currentLvl < levels.length)
			load();
		else
			HXP.scene = new End();
	}
	
	public function died ()
	{
		var t = new Text("DEAD", { size: 60, color: 0, font: "font/LinLibertine_R.ttf"});
		var t2 = new Text("Press ENTER to restart", { size: 42, color: 0, font: "font/LinLibertine_R.ttf"});
		
		var t_x = HXP.halfWidth - t.width/2;
		var t2_x = HXP.halfWidth - t2.width/2;
		
		var h = Std.int(t.height + t2.height + 100);
		var posY = HXP.halfHeight - h/2;
		var w = Std.int(Math.max(t.width, t2.width));
		var posX = Math.min(t_x, t2_x);
		
		addGraphic(Image.createRect(w, h, 0xA06421), 0, posX, posY);
		addGraphic(Image.createRect(w-4, h-4, 0xE09A4C), 0, posX+2, posY+2);
		addGraphic(t, 0, t_x, posY + 30);		
		addGraphic(t2, 0, t2_x, posY + 130);
	}
}
