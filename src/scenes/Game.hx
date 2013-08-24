package scenes;

import com.haxepunk.Scene;
import com.haxepunk.tmx.TmxEntity;

class Game extends Scene
{
	override public function begin ()
	{
		// create the map, set the assets in your nmml file to bytes
		var e = new TmxEntity("maps/test.tmx");

		// load layers named bottom, main, top with the appropriate tileset
		e.loadGraphic("gfx/tileset.png", ["layer1"]);

		// loads a grid layer named collision and sets the entity type to walls
		e.loadMask("collision", "solid");

		add(e);
		
		add(new entities.Player());
	}
}
