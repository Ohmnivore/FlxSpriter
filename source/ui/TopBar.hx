package ui;

import flixel.addons.ui.FlxUI9SliceSprite;
import openfl.geom.Rectangle;
import flixel.FlxG;

/**
 * ...
 * @author Ohmnivore
 */
class TopBar extends FlxUI9SliceSprite
{
	public function new() 
	{
		super(0, 0, Assets.CHROME, new Rectangle(0, 0, FlxG.width, 32));
	}
}