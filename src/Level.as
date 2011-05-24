package
{
  import org.flixel.FlxState;

  public class Level extends FlxState
  {
    // Offset when drawing on the screen
    public static const X_OFFSET:int = 0;
    public static const Y_OFFSET:int = 192;

    private var field:Field;
    private var drawable:Drawable;
    private var fieldDrawable:OffsetDrawable;
    private var generator:NumberGenerator;

    override public function create():void
    {
      drawable = new DrawableImpl(screen);
      fieldDrawable = new OffsetDrawable(drawable, X_OFFSET, Y_OFFSET);
	    
      generator = new RandomNumberGenerator();

      field = new Field(32, 24);
      field.generate(generator);
    }

    override public function render():void
    {
      super.render();
      field.draw(fieldDrawable);
    }
  }
}
