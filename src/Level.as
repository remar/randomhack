package
{
  import org.flixel.FlxState;

  public class Level extends FlxState
  {
    // Offset when drawing on the screen
    private static const FIELD_OFFSET:Point = new Point(0, 192);

    private static const FIELD_WIDTH:int = 32;
    private static const FIELD_HEIGHT:int = 24;
    private static const TILE_WIDTH:int = 8;
    private static const TILE_HEIGHT:int = 8;

    private static const FIELD_SIZE:Point = new Point(FIELD_WIDTH * TILE_WIDTH,
						      FIELD_HEIGHT * TILE_HEIGHT);

    private var field:Field;
    private var drawable:Drawable;
    private var fieldDrawable:OffsetDrawable;
    private var numberGenerator:NumberGenerator;

    private var graphicsFactory:GraphicsFactory;
    private var inputReader:InputReader;
    private var fieldInputHandler:FieldInputHandler;

    private var player:Player;
    private var goal:Goal;
    private var enemy:Enemy;

    override public function create():void
    {
      inputReader = new FlixelInputReader();
      fieldInputHandler = new FieldInputHandler(TILE_WIDTH, TILE_HEIGHT);

      graphicsFactory = new FlixelPixelGraphicsFactory(new FlixelPixelScreen(screen));

      drawable = graphicsFactory.getDrawable();
      fieldDrawable = new OffsetDrawable(drawable, FIELD_OFFSET);
	    
      numberGenerator = new RandomNumberGenerator();
      field = new Field(FIELD_WIDTH, FIELD_HEIGHT);

      generateLevel();

      super.create();
    }

    override public function update():void

    {
      handleInput();

      player.update();

      if(player.hasPerformedAction())
	  {
	      enemy.move(field, player.position, []);
	  }

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
      enemy.draw(fieldDrawable);
    }

    private function handleInput():void
    {
      if(inputReader.mousePressed())
	{
	  var mousePos:Point = inputReader.mousePosition();
	  if(mousePos.withinBounds(FIELD_OFFSET, FIELD_OFFSET.add(FIELD_SIZE)))
	    {
	      mousePos = mousePos.subtract(FIELD_OFFSET);
	      var delta:Point = fieldInputHandler.mousePressRelativeToPlayer(mousePos, player.position);
	      player.moveRelative(delta.getX(), delta.getY());
	    }
	}
    }
    
    private function generateLevel():void
    {
      field.clearField(TileType.BLOCK);

      var fieldBuilder:FieldBuilder = new RandomFieldBuilder(numberGenerator);

      var positions:StartPositions = fieldBuilder.generate(field);
      field.renderBackgroundTiles(graphicsFactory);

      player = new Player(graphicsFactory, field, positions.start);
      goal = new Goal(graphicsFactory, positions.goal);	
      enemy = new Bat(graphicsFactory, numberGenerator);
      enemy.position = new Point(3, 4);
    }
  }
}
