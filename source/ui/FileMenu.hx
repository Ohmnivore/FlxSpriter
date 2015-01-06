package ui;

import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.StrIdLabel;

/**
 * ...
 * @author Ohmnivore
 */
class FileMenu extends FlxUIDropDownMenu
{
	public var userCallback:String->Void;
	
	public function new(X:Float, Y:Float, Callback:String->Void) 
	{
		userCallback = Callback;
		
		super(X, Y,
			[mkStrIdL("Import Sprite")],
			doCallback, Assets.createHeader());
		forceHeaderText();
	}
	
	private function mkStrIdL(S:String):StrIdLabel
	{
		return new StrIdLabel(S, S);
	}
	
	private function forceHeaderText():Void
	{
		header.text.text = "File";
	}
	
	private function doCallback(ID:String):Void
	{
		forceHeaderText();
		
		if (userCallback != null)
			userCallback(ID);
	}
}