import robotlegs.bender.framework.impl.Context;
import flash.display.Sprite;

/**
 * ...
 * @author 
 */

class Main extends Sprite
{
	public function new() 
	{
		new Context()
			.extend(MVCSBundle)
			.configure(MyAppConfig, this);
	}
	
	static function main() 
	{
		new Main();
	}
}