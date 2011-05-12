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
	    field.carveHole(5, 5, 2);
	    field.setTile(4, 5, Tile.BLOCK);
	}

	override public function render():void
	{
	    field.draw(drawable);

	    super.render();
	}
    }
}
