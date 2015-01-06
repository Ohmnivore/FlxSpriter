package sprite;

import flixel.FlxSprite;
import io.Get;
import openfl.display.BitmapData;
import haxe.io.Path;

/**
 * ...
 * @author Ohmnivore
 */
class Sprite extends FlxSprite
{
	public var lastModified:Date;
	public var onDoneLoading:Void->Void;
	
	public var info:SpriteInfo;
	public var path:String;
	public var selectedAnim:SpriteAnim;
	
	public function new(Info:SpriteInfo, P:String) 
	{
		super();
		
		info = Info;
		path = P;
		
		loadImg();
	}
	
	public function reload(Force:Bool = false):Void
	{
		var last:Date = Get.getLastModified(info.imgpath, Path.directory(path));
		
		if (last.toString() != lastModified.toString() || Force)
		{
			loadImg();
		}
	}
	
	private function loadImg():Void
	{
		lastModified = Get.getLastModified(info.imgpath, Path.directory(path));
		
		Get.convert(info.imgpath, Path.directory(path));
		Get.getImage(loadFrames, Get.replaceExtension(info.imgpath, "png"), Path.directory(path));
	}
	private function loadFrames(B:BitmapData):Void
	{
		loadGraphic(B, true, info.width, info.height, true);
		
		scale.set(info.scale, info.scale);
		updateHitbox();
		animation.destroyAnimations();
		
		for (a in info.anims)
		{
			animation.add(a.name, a.frames, a.rate, true);
			animation.play(a.name, true);
		}
		
		if (onDoneLoading != null)
			onDoneLoading();
	}
}