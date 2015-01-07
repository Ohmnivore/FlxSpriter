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
	public var selectedAnim:String;
	public var curAnim:SpriteAnim;
	
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
		info.fullWidth = B.width;
		info.fullHeight = B.height;
		
		scale.set(info.scale, info.scale);
		updateHitbox();
		animation.destroyAnimations();
		//updateFrameData();
		
		for (a in info.anims)
		{
			if (animation.curAnim != null)
				animation.curAnim.stop();
			
			animation.add(a.name, a.frames.copy(), a.rate, true);
			animation.play(a.name, true);
		}
		
		if (onDoneLoading != null)
			onDoneLoading();
	}
}