package ui;
import flixel.addons.ui.FlxUIText;
import flixel.FlxG;

/**
 * ...
 * @author Ohmnivore
 */
class Status extends FlxUIText
{
	private var spacing:Float;
	
	public function new(Y:Float, Spacing:Float) 
	{
		spacing = Spacing;
		
		super();
		
		Assets.setTextStyle(this);
		y = Y;
	}
	
	public function setStatus(Sprite:String, Anim:String = "")
	{
		text = Sprite + " - " + Anim;
	}
	
	override public function update():Void 
	{
		super.update();
		
		x = FlxG.width - width - spacing;
	}
}