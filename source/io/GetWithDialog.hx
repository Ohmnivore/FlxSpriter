package io;

import systools.Dialogs;

/**
 * ...
 * @author Ohmnivore
 */
class GetWithDialog
{
	static public function selectXmls():Array<String>
	{
		var opts:FILEFILTERS = { count: 20, descriptions: ["XML sprite description"], extensions: ["*.xml"] };
		
		return Dialogs.openFile("Open sprite description", "", opts);
	}
}