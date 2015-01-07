package ui;

import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIList;
import flixel.FlxG;
import sprite.Sprite;

/**
 * ...
 * @author Ohmnivore
 */
class SpriteList extends FlxUIList
{
	public var onSelect:Sprite-> Void;
	public var btnY:Float = 0;
	
	public function new(X:Float, Y:Float, OnSelect:Sprite->Void)
	{
		onSelect = OnSelect;
		
		super(X, Y, null, FlxG.width / 6, FlxG.height * 0.75, 5.0);
	}
	
	public function addSprite(S:Sprite):Void
	{
		var btn:FlxUIButton = new FlxUIButton(0, btnY, S.info.name, function() { onSelect(S); } );
		btnY += 22;
		Assets.setBtnGraphic(btn);
		
		add(btn);
	}
}