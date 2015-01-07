package ui;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIList;
import flixel.FlxG;
import sprite.Sprite;
import sprite.SpriteAnim;

/**
 * ...
 * @author Ohmnivore
 */
class AnimList extends FlxUIList
{
	public var onSelect:Sprite->SpriteAnim->Void;
	
	public function new(X:Float, Y:Float, OnSelect:Sprite->SpriteAnim->Void)
	{
		onSelect = OnSelect;
		
		super(X, Y, null, FlxG.width / 6, FlxG.height * 0.75, 5.0);
	}
	
	public function setSprite(S:Sprite):Void
	{
		clear();
		
		var btnY:Int = 0;
		for (a in S.info.anims)
		{
			var btn:FlxUIButton = new FlxUIButton(0, btnY, a.name, function() { onSelect(S, a); } );
			btnY += 22;
			Assets.setBtnGraphic(btn);
			
			add(btn);
		}
	}
}