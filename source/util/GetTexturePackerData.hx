package util;

import sprite.Sprite;
import sprite.SpriteAnim;
import sprite.SpriteInfo;
import haxe.io.Path;
import systools.Clipboard;

/**
 * ...
 * @author Ohmnivore
 */
class GetTexturePackerData
{
	private static var sprite:Sprite;
	private static var info:SpriteInfo;
	private static var anim:SpriteAnim;
	
	private static var width:Float;
	private static var height:Float;
	private static var tileWidth:Int;
	private static var tileHeight:Int;
	private static var widthInTiles:Int;
	
	public static function getData(S:Sprite, Info:SpriteInfo, Anim:SpriteAnim):String
	{
		sprite = S;
		info = Info;
		anim = Anim;
		
		setBasics();
		
		var data:String = '{"frames":[';
		
		var i:Int = 0;
		while (i < Anim.frames.length)
		{
			data += getFrame(Anim.frames[i], i);
			if (i != Anim.frames.length - 1)
				data += ',\n';
			
			i++;
		}
		
		//data += '],\n"meta":{"app":"Adobe Flash CS6","version":"12.0.0.481","image":"' + Path.withoutExtension(Path.withoutDirectory(info.imgpath)) + ".png" + '","format":"RGBA8888","size":{"w":' + width + ',"h":' + height + '},"scale":"' + info.scale + '"}}';
		data += '],\n"meta":{"app":"Adobe Flash CS6","version":"12.0.0.481","image":"' + Path.withoutExtension(Path.withoutDirectory(info.imgpath)) + ".png" + '","format":"RGBA8888","size":{"w":' + width + ',"h":' + height + '},"scale":"' + 1 + '"}}';
		
		Clipboard.setText(data);
		
		return data;
	}
	
	private static function setBasics():Void
	{
		//width = sprite.pixels.width / sprite.scale.x;
		//height = sprite.pixels.height / sprite.scale.y;
		width = info.fullWidth;
		height = info.fullHeight;
		tileWidth = cast sprite.width / sprite.scale.x;
		tileHeight = cast sprite.height / sprite.scale.x;
		widthInTiles = cast width / tileWidth;
	}
	
	private static function getFrame(FrameIndex:Int, Index:Int):String
	{
		var x:Int = FrameIndex % widthInTiles;
		var y:Int = Math.floor(FrameIndex  / widthInTiles);
		
		var sheetX:Int = x * tileWidth;
		var sheetY:Int = y * tileHeight;
		
		var data:String = "{";
		
		var preNum:String = "000";
		if (Index > 9)
			preNum = "00";
		data += '"filename":"' + anim.name + preNum + Index + '",';
		
		data += '"frame":{"x":' + sheetX + ',"y":' + sheetY + ',"w":' + tileWidth + ',"h":' + tileHeight + '},';
		data += '"rotated":false,"trimmed":true,';
		//data += '"spriteSourceSize":{"x":' + sheetX + ',"y":' + sheetY + ',"w":' + tileWidth + ',"h":' + tileHeight + '},';
		data += '"spriteSourceSize":{"x":' + 0 + ',"y":' + 0 + ',"w":' + tileWidth + ',"h":' + tileHeight + '},';
		data += '"sourceSize":{"w":' + tileWidth + ',"h":' + tileHeight + '}}';
		
		return data;
	}
}