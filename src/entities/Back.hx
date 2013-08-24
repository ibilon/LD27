package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Back extends Entity
{
	private var text : Text;	
	
	public function new ()
	{
		super(430, 430);
		
		graphic = text = new Text("Back to menu", {color: 0, font: "font/angelina.ttf", size: 32});
		setHitboxTo(graphic);
		type = "back";
	}
	
	override public function update ()
	{
		super.update();
		
		var e = HXP.scene.collidePoint("back", Input.mouseX+HXP.camera.x, Input.mouseY+HXP.camera.y);
		if (e == null)
			text.color = 0;
		else
			text.color = 0x0000FF;
		
		if (Input.pressed(Key.ENTER) || (Input.mouseReleased && e != null)) HXP.scene = new scenes.MainMenu();
	}
}
