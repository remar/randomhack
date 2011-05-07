package
{
    import org.flixel.FlxSprite;

    public class DrawableImpl implements Drawable
    {
	private var flxSprite:FlxSprite;

	public function DrawableImpl(flxSprite:FlxSprite):void
	{
	    this.flxSprite = flxSprite;
	}

	public function setPixel(x:int, y:int, color:int):void
	{
	    flxSprite.pixels.setPixel(x, y, color);
	}

	public function getPixel(x:int, y:int):int
	{
	    return 0;
	}
    }
}
