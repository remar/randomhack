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

    private var player:Player;
    private var actionPerformed:Boolean;

    private var objects:Array;

    private var goal:Goal;

    private var displayableStatus:DisplayableStatus;
    private var consoleInfoView:ConsoleInfoView;

    private var creatureController:CreatureController;

    override public function create():void
    {
      inputReader = new FlixelInputReader();

      graphicsFactory = new FlixelPixelGraphicsFactory(new FlixelPixelScreen(screen));

      drawable = graphicsFactory.getDrawable();
      fieldDrawable = new OffsetDrawable(drawable, FIELD_OFFSET);
	    
      numberGenerator = new RandomNumberGenerator();
      field = new Field(FIELD_WIDTH, FIELD_HEIGHT);

      displayableStatus = new DisplayableStatus();
      consoleInfoView = new ConsoleInfoView(graphicsFactory);
      displayableStatus.registerListener(consoleInfoView);

      player = new Player(graphicsFactory, displayableStatus);
      player.generateCharacter(numberGenerator);

      generateLevel();

      super.create();
    }

    override public function update():void
    {
      handleInput();

      player.update();

      if(actionPerformed)
	{
	  creatureController.removeDeadEnemies(objects, graphicsFactory);
	  creatureController.attack(player, displayableStatus);
	  creatureController.moveEnemies(field, player.position);
	  actionPerformed = false;
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
      goal.draw(fieldDrawable);
      drawObjects();
      creatureController.drawEnemies(fieldDrawable);
      player.draw(fieldDrawable);
      consoleInfoView.draw(drawable);
    }

    private function handleInput():void
    {
      if(inputReader.mousePressed())
	{
	  var mousePos:Point = inputReader.mousePosition();
	  if(mousePos.withinBounds(FIELD_OFFSET, FIELD_OFFSET.add(FIELD_SIZE)))
	    {
	      var delta:Point = field.getDirection(player.position, getClickedTile(mousePos));

	      var enemy:Enemy = creatureController.getEnemyAtPosition(player.position.add(delta));

	      if(enemy != null)
		{
		  player.attack(enemy);
		}
	      else
		{
		  player.moveRelative(field, delta, creatureController.getEnemies());
		}
	      actionPerformed = true;
	    }
	}
    }
    
    private function generateLevel():void
    {
      field.clearField(TileType.BLOCK);

      var fieldBuilder:FieldBuilder = new RandomFieldBuilder(numberGenerator);

      var positions:StartPositions = fieldBuilder.generate(field);
      field.renderBackgroundTiles(graphicsFactory);

      player.position = positions.start;
      goal = new Goal(graphicsFactory, positions.goal);	

      var randomPositions:Array = field.getEmptyPositionsInRandomOrder(numberGenerator);

      objects = [];
      creatureController = new CreatureController();

      var numEnemies:int = numberGenerator.getIntInRange(3, 8);
      for(var i:int = 0;i < numEnemies;i++)
	{
	  var enemy:Enemy = new Bat(graphicsFactory, numberGenerator);
	  enemy.position = randomPositions.pop();
	  creatureController.addEnemy(enemy);
	}
      actionPerformed = false;

      displayableStatus.print("Create level");
    }

    private function getClickedTile(mousePosition:Point):Point
    {
      mousePosition = mousePosition.subtract(FIELD_OFFSET);
      return new Point(int(mousePosition.x/TILE_WIDTH),
		       int(mousePosition.y/TILE_HEIGHT));
    }

    private function drawObjects():void
    {
      objects.forEach(function (object:GameObject, i:int, a:Array):void
		      {
			object.draw(fieldDrawable);
		      });
    }
  }
}
