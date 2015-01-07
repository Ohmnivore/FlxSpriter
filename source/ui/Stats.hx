package ui;

import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIColorSwatch;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUISlider;
import flixel.addons.ui.FlxUIText;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColorUtil;
import openfl.geom.Rectangle;
import sprite.Sprite;

/**
 * ...
 * @author Ohmnivore
 */
class Stats extends FlxUIGroup
{
	public var bgColor:FlxUIInputText;
	public var speed:FlxUINumericStepper;
	public var play:FlxUICheckBox;
	public var fps:FlxUIText;
	public var curFrame:FlxUIText;
	public var nextFrame:FlxUIButton;
	public var lastFrame:FlxUIButton;
	
	public var sprite:Sprite;
	
	static public var actualWidth:Float = 170;
	static public var actualHeight:Float = 110;
	
	public function new(Y:Float, X:Float) 
	{
		super(X, Y);
		
		var bg:FlxUI9SliceSprite = new FlxUI9SliceSprite(0, 0, Assets.CHROME,
			new Rectangle(0, 0, actualWidth, actualHeight));
		add(bg);
		
		bgColor = new FlxUIInputText(5, 5);
		add(bgColor);
		
		speed = new FlxUINumericStepper(5, 20, 0.2, 1, 0.2, 3, 1, FlxUINumericStepper.STACK_HORIZONTAL,
			new FlxText(0, 0, 0, "Speed"), Assets.getStepperPlus(), Assets.getStepperMinus());
		add(speed);
		
		play = new FlxUICheckBox(5, 20 + speed.height, null, null, "Play", onPlayChange);
		add(play);
		
		fps = new FlxUIText(5, 60, 0, "FPS: ");
		Assets.setTextStyle(fps);
		add(fps);
		
		curFrame = new FlxUIText(5, 70, 0, "Frame: ");
		Assets.setTextStyle(curFrame);
		add(curFrame);
		
		lastFrame = new FlxUIButton(5, 85, "Last frame", doLastFrame);
		Assets.setBtnGraphic(lastFrame);
		add(lastFrame);
		nextFrame = new FlxUIButton(5 + lastFrame.width, 85, "Next frame", doNextFrame);
		Assets.setBtnGraphic(nextFrame);
		add(nextFrame);
	}
	
	private function doLastFrame():Void
	{
		if (sprite != null)
		{
			if (sprite.animation.curAnim.curFrame == 0)
				sprite.animation.curAnim.curFrame = sprite.animation.curAnim.numFrames - 1;
			else
				sprite.animation.curAnim.curFrame--;
		}
	}
	private function doNextFrame():Void
	{
		if (sprite != null)
		{
			sprite.animation.curAnim.curFrame++;
			if (sprite.animation.curAnim.curFrame >= sprite.animation.curAnim.numFrames)
				sprite.animation.curAnim.curFrame = 0;
		}
	}
	
	private function onPlayChange():Void
	{
		if (sprite != null)
		{
			if (play.checked)
				sprite.animation.play(sprite.animation.curAnim.name);
			else
				sprite.animation.pause();
		}
	}
	
	public function onNew():Void
	{
		play.checked = true;
		speed.value = 1;
		bgColor.text = FlxColorUtil.ARGBtoHexString(sprite.info.bgColor);
		FlxG.camera.bgColor = sprite.info.bgColor;
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (sprite != null)
		{
			sprite.animation.curAnim.frameRate = Std.int(sprite.curAnim.rate * speed.value);
			
			//if (Std.parseInt(bgColor.text) != null)
			//{
				//FlxG.camera.bgColor = Std.parseInt(bgColor.text);
			//}
			
			fps.text = "FPS: " + sprite.animation.curAnim.frameRate;
			curFrame.text = "Frame: " + sprite.animation.curAnim.curFrame;
		}
	}
}