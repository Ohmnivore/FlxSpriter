package sprite;

import haxe.xml.Fast;
import io.Get;

/**
 * ...
 * @author Ohmnivore
 */
class SpriteInfo
{
	public var lastModified:Date;
	public var path:String;
	
	public var name:String;
	public var imgpath:String;
	public var width:Int;
	public var height:Int;
	public var scale:Float;
	public var bgColor:Int;
	
	public var fullWidth:Int;
	public var fullHeight:Int;
	
	public var anims:Array<SpriteAnim> = [];
	
	public function new(Name:String, P:String)
	{
		name = Name;
		path = P;
		lastModified = Get.getLastModified(path);
	}
	
	public function reload():Bool
	{
		var last:Date = Get.getLastModified(path);
		
		if (last.toString() != lastModified.toString())
		{
			anims = [];
			
			loadFromXml(Xml.parse(Get.getText(path)));
			lastModified = last;
			
			return true;
		}
		
		return false;
	}
	
	public function loadFromXml(X:Xml):Void
	{
		for (e in X.firstElement().elements())
		{
			var f:Fast = new Fast(e);
			
			var name:String = f.name;
			
			if (name == "opt")
				parseOptTag(f);
			if (name == "img")
				parseImgTag(f);
			if (name == "anim")
				parseAnim(f);
		}
	}
	private function parseOptTag(F:Fast):Void
	{
		scale = Std.parseFloat(F.att.scale);
		bgColor = Std.parseInt(F.att.bgColor);
	}
	private function parseImgTag(F:Fast):Void
	{
		imgpath = F.att.src;
		width = Std.parseInt(F.att.width);
		height = Std.parseInt(F.att.height);
	}
	private function parseAnim(F:Fast):Void
	{
		//trace("anim");
		anims.push(new SpriteAnim(F.att.name, Std.parseInt(F.att.rate), SpriteAnim.parseFrames(F.att.frames)));
	}
}