package
{
    import org.flixel.*;

    public class Level extends FlxState
    {
	override public function create():void
	{
	}

	override public function render():void
	{
	    // Render pixels here
	    screen.pixels.setPixel(10, 10, 0xff0000);
	    super.render();
	}
    }
}
