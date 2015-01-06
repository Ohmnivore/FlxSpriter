package;

import crashdumper.CrashDumper;
import crashdumper.SessionData;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.StrIdLabel;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxTimer;
import io.Get;
import io.GetWithDialog;
import openfl.geom.Rectangle;
import sprite.Sprite;
import sprite.SpriteAnim;
import sprite.SpriteInfo;
import haxe.io.Path;
import sprite.Util;
import ui.*;
import util.TopMost;

/**
 * A FlxState which can be used for the game's menu.
 */
class MainState extends FlxState
{
	var topBar:TopBar;
	var file:FileMenu;
	var spriteList:SpriteList;
	var animList:AnimList;
	var status:Status;
	var stats:Stats;
	
	var anim:FlxGroup;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = 0xffffffff;
		//FlxG.mouse.load(null, 0.5);
		FlxG.autoPause = false;
		
		TopMost.setTop();
		
		//var cr:CrashDumper = new CrashDumper(SessionData.generateID("", ""));
		
		var bg:FlxUI9SliceSprite = new FlxUI9SliceSprite(0, 34, Assets.CHROME,
			new Rectangle(0, 0, FlxG.width / 3 + 10, FlxG.height - Stats.actualHeight - 34 - 2));
		add(bg);
		
		anim = new FlxGroup();
		add(anim);
		
		topBar = new TopBar();
		add(topBar);
		
		file = new FileMenu(5, 5, onFile);
		add(file);
		
		spriteList = new SpriteList(5, 39, onSpriteSelected);
		add(spriteList);
		
		animList = new AnimList(spriteList.width + 5, 39, onAnimSelected);
		add(animList);
		
		status = new Status(5, 5);
		add(status);
		
		stats = new Stats(bg.y + bg.height + 2, 0);
		add(stats);
		
		new FlxTimer(0.5, reloadAssets, 0);
	}
	
	private function reloadAssets(T:FlxTimer):Void
	{
		if (stats.sprite != null)
		{
			if (stats.sprite.info.reload())
			{
				stats.sprite.reload(true);
				stats.sprite.onDoneLoading = onReloadSprite;
				
				for (a in stats.sprite.info.anims)
				{
					if (a.name == stats.sprite.selectedAnim.name)
					{
						stats.sprite.selectedAnim = a;
					}
				}
			}
			else
				stats.sprite.reload();
		}
	}
	private function onReloadSprite():Void
	{
		stats.onNew();
	}
	
	private function onFile(ID:String):Void
	{
		if (ID == "Import Sprite")
		{
			for (path in GetWithDialog.selectXmls())
			{
				var s:Sprite = Util.createSpr(path);
				spriteList.addSprite(s);
			}
		}
	}
	private function onSpriteSelected(S:Sprite):Void
	{
		stats.sprite = null;
		animList.setSprite(S);
		
		status.setStatus(S.info.name, "");
	}
	private function onAnimSelected(S:Sprite, A:SpriteAnim):Void
	{
		anim.clear();
		
		stats.sprite = S;
		stats.onNew();
		anim.add(S);
		S.selectedAnim = A;
		S.animation.play(A.name);
		//S.y = FlxG.height / 2 + topBar.height - S.height;
		//S.x = animList.x + animList.width + (FlxG.width - (animList.x + animList.width)) / 2 - S.width / 2;
		S.x = FlxG.width - S.width - 5;
		S.y = topBar.height + 5;
		
		status.setStatus(S.info.name, A.name);
		
		FlxG.camera.bgColor = S.info.bgColor;
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}
}