package sprite;

import haxe.io.Path;
import io.Get;
import sys.FileSystem;

/**
 * ...
 * @author Ohmnivore
 */
class Util
{
	public static function createSpr(P:String, ?RelativeP:String):Sprite
	{
		var p:String = Get.getAbsPath(P, RelativeP);
		
		var si:SpriteInfo = new SpriteInfo(Path.withoutExtension(Path.withoutDirectory(p)), p);
		si.loadFromXml(Xml.parse(Get.getText(p)));
		
		var spr:Sprite = new Sprite(si, p);
		return spr;
	}
}