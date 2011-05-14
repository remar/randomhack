package
{
    import org.flixel.FlxState;

    public class Level extends FlxState
    {
	private var field:Field;
	private var drawable:Drawable;

	override public function create():void
	{
	    drawable = new DrawableImpl(screen);

	    field = new Field();
	    field.generate();
	}

	override public function render():void
	{
	    super.render();
	    field.draw(drawable);
	}
    }
}
