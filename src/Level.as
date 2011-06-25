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

    private var graphicsFactory:GraphicsFactory;

    private var player:Player;
    private var goal:Goal;

    override public function create():void
    {
      graphicsFactory = new FlixelPixelGraphicsFactory(new FlixelPixelScreen(screen));

      drawable = graphicsFactory.getDrawable();
      fieldDrawable = new OffsetDrawable(drawable, X_OFFSET, Y_OFFSET);
	    
      numberGenerator = new RandomNumberGenerator();
      field = new Field(32, 24);

      generateLevel();

      super.create();
    }

    override public function update():void
    {
      player.update();

      if(goal.position.equals(player.position))
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
      field.clearField(TileType.BLOCK);

      var fieldBuilder:FieldBuilder = new RandomFieldBuilder(numberGenerator);

      var positions:StartPositions = fieldBuilder.generate(field);
      field.renderBackgroundTiles(graphicsFactory);

      player = new Player(field, positions.start);
      goal = new Goal(positions.goal);
    }
  }
}
