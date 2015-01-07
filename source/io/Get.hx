package io;

import flixel.FlxSprite;
import openfl.display.DisplayObject;
import openfl.display.BitmapData;
import openfl.display.Loader;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import sprite.Sprite;
import sys.FileSystem;
import sys.io.File;
import sys.FileStat;
import haxe.io.Path;
import openfl.net.URLRequest;
import openfl.events.Event;
import openfl.display.LoaderInfo;

/**
 * ...
 * @author Ohmnivore
 */
class Get
{
	public static function getSize(P:String, ?RelativeP:String):Int
	{
		var p:String = getAbsPath(P, RelativeP);
		
		return FileSystem.stat(p).size;
	}
	public static function getLastModified(P:String, ?RelativeP:String):Date
	{
		var p:String = getAbsPath(P, RelativeP);
		
		return FileSystem.stat(p).mtime;
	}
	
	public static function getImage(OnComplete:BitmapData->Void, P:String, ?RelativeP:String):Void
	{
		var p:String = getAbsPath(P, RelativeP);
		
		var l:Loader = new Loader();
		l.contentLoaderInfo.addEventListener(Event.COMPLETE,
		function (event:Event)
		{
			var d:DisplayObject = loadBytesHandler(event);
			
			var b:BitmapData = new BitmapData(cast d.width, cast d.width, true, 0x00000000);
			b.draw(d);
			
			OnComplete(b);
		});
		
		l.load(new URLRequest(p));
	}
	private static function loadBytesHandler(event:Event):DisplayObject
	{
		var loaderInfo:LoaderInfo = cast(event.target, LoaderInfo);
		
		return cast loaderInfo.content;
	}
	
	public static function doesExist(P:String, ?RelativeP:String):Bool
	{
		var p:String = getAbsPath(P, RelativeP);
		
		return FileSystem.exists(p);
	}
	
	public static function getExtension(P:String):String
	{
		return Path.extension(P);
	}
	
	public static function replaceExtension(P:String, NewExt:String):String
	{
		return Path.withoutExtension(P) + "." + NewExt;
	}
	
	public static function convert(P:String, ?RelativeP:String):Void
	{
		var p:String = getAbsPath(P, RelativeP);
		
		var format:String = Path.extension(p);
		
		if (format != "png")
		{
			var newp:String = Path.withoutExtension(p) + ".png";
			
			if (format == "psd")
				p += "[0]";
			
			var cmd:String = "convert.exe " + p + " " + newp;
			Sys.command(cmd, []);
		}
	}
	
	public static function getText(P:String, ?RelativeP:String):String
	{
		var p:String = getAbsPath(P, RelativeP);
		
		return File.getContent(p);
	}
	
	public static function getAbsPath(P:String, ?RelativeP:String):String
	{
		var p:String = P;
		
		if (RelativeP != null)
		{
			p = Path.addTrailingSlash(RelativeP) + P;
		}
		
		return p;
	}
}