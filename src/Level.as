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
    private var numberGenerator:NumberGenerator;

    private var player:Player;
    private var goal:Goal;

    override public function create():void
    {
      drawable = new DrawableImpl(screen);
      fieldDrawable = new OffsetDrawable(drawable, X_OFFSET, Y_OFFSET);
	    
      numberGenerator = new RandomNumberGenerator();
      field = new Field(32, 24);

      generateLevel();

      super.create();
    }

    override public function update():void
    {
      player.update();

      if(goal.position.equals(new Point(player.x, player.y)))
	{
	  // WOOO!!!
	  generateLevel();
	}

      super.update();
    }

    override public function render():void
    {
      super.render();
      field.draw(fieldDrawable);
      player.draw(fieldDrawable);
      goal.draw(fieldDrawable);
    }

    private function generateLevel():void
    {
      field.clearField(Tile.BLOCK);
      var positions:Array = field.generate(numberGenerator);
      player = new Player(field, positions[0]);
      goal = new Goal(positions[1]);
    }
  }
}
