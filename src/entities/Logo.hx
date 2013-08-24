package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Tween;
import com.haxepunk.graphics.Image;
import com.haxepunk.tweens.misc.NumTween;
import com.haxepunk.utils.Ease;

class Logo extends Entity
{
	private var image : Image;
	private var fade : NumTween;
	private var onComplete : Void->Void;
	
	public function new (img:String, ?complete:Void->Void)
	{
		super();
		onComplete = complete;
		
		image = new Image(img);
		image.alpha = 0;
		
		x = HXP.halfWidth - image.width/2;
		y = HXP.halfHeight - image.height/2;
		
		graphic = image;
		
		fade = new NumTween(step1, TweenType.OneShot);
		fade.tween(0, 1, 1, Ease.quadInOut);
		addTween(fade);
	}
	
	private function step1 (e:Dynamic=null)
	{
		fade = new NumTween(step2, TweenType.OneShot);
		fade.tween(1, 1, 1, Ease.quadInOut);
		addTween(fade);
	}

	private function step2 (e:Dynamic=null)
	{
		fade = new NumTween(step3, TweenType.OneShot);
		fade.tween(1, 0, 1, Ease.quadInOut);
		addTween(fade);
	}

	private function step3 (e:Dynamic=null)
	{
		if (onComplete != null)
			onComplete();
	}
	
	override function update ()
	{
		super.update();
		
		image.alpha = fade.value;
	}
}
