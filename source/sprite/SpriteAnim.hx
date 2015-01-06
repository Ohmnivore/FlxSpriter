package sprite;

/**
 * ...
 * @author Ohmnivore
 */
class SpriteAnim
{
	public var name:String;
	public var rate:Int;
	public var frames:Array<Int>;
	
	public static function parseFrames(Frames:String):Array<Int>
	{
		var raw:Array<String> = Frames.split(",");
		var ret:Array<Int> = [];
		
		for (rawNum in raw)
		{
			ret.push(Std.parseInt(StringTools.trim(rawNum)));
		}
		
		return ret;
	}
	
	public function new(Name:String, Rate:Int, Frames:Array<Int>) 
	{
		name = Name;
		rate = Rate;
		frames = Frames;
	}
}