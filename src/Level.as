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

    private static const ZERO_POINT:Point = new Point(0, 0);

    private var field:Field;
    private var drawable:Drawable;
    private var fieldDrawable:OffsetDrawable;
    private var numberGenerator:NumberGenerator;

    private var graphicsFactory:GraphicsFactory;
    private var inputReader:InputReader;

    private var player:Player;
    private var actionPerformed:Boolean;

    private var goal:Goal;

    private var displayableStatus:DisplayableStatus;
    private var consoleInfoView:ConsoleInfoView;

    private var creatureController:CreatureController;
    private var itemController:ItemController;

    private var _currentLevel:int;

    override public function create():void
    {
      graphicsFactory = new FlixelPixelGraphicsFactory(new FlixelPixelScreen(screen));

      drawable = graphicsFactory.getDrawable();
      fieldDrawable = new OffsetDrawable(drawable, FIELD_OFFSET);
	    
      numberGenerator = new RandomNumberGenerator();
      field = new Field(FIELD_WIDTH, FIELD_HEIGHT);

      displayableStatus = new DisplayableStatus();
      consoleInfoView = new ConsoleInfoView(graphicsFactory);
      displayableStatus.registerListener(consoleInfoView);

      player = new Player(graphicsFactory, numberGenerator, displayableStatus);

      inputReader = new FlixelInputReader();

      startGame();
      super.create();
    }

    override public function update():void
    {
      super.update();

      handleInput();

      player.update();

      if(actionPerformed)
	{
	  creatureController.removeDeadEnemies(itemController, graphicsFactory,
					       displayableStatus);
	  creatureController.attack(player);

	  if(player.isDead())
	    {
	      printDeathMessage();
	    }

	  creatureController.moveEnemies(field, player.position, itemController);
	  actionPerformed = false;
	}

      if(goal.position.equals(player.position))
	{
	  // WOOO!!!
	  currentLevel = currentLevel + 1;
	  generateLevel();
	}
    }

    override public function render():void
    {
      super.render();
      field.draw(fieldDrawable);
      goal.draw(fieldDrawable);
      itemController.drawItems(fieldDrawable);
      creatureController.drawEnemies(fieldDrawable);
      player.draw(fieldDrawable);
      consoleInfoView.draw(drawable);
    }

    private function startGame():void
    {
      currentLevel = 1;

      player.generateCharacter(numberGenerator);

      var sword:Sword = new Sword(graphicsFactory, new Point(1, 1));
      sword.generateNameAndPower(1, numberGenerator);
      player.weapon = sword;

      generateLevel();
      printStartingMessage();
    }

    private function handleInput():void
    {
      if(inputReader.mousePressed())
	{
	  var mousePos:Point = inputReader.mousePosition();
	  if(mousePos.withinBounds(FIELD_OFFSET, FIELD_OFFSET.add(FIELD_SIZE)))
	    {
	      var clickedTile:Point = getClickedTile(mousePos);
	      var delta:Point = field.getDirection(player.position, clickedTile);
	      var enemy:Enemy = creatureController.getEnemyAtPosition(player.position.add(delta));

	      var fear:FearType = creatureController.getFearLevelAtPosition(player.position);

	      if(numberGenerator.getIntInRange(1, 10) <= fear.Index)
		{
		  printMessage(["SHIT POMFRITT !"]);
		}
	      else if(enemy != null)
		{
		  displayableStatus.print("");
		  player.attack(enemy);
		}
	      else
		{
		  player.move(field, delta, creatureController.getEnemies());
		  useInstantItem();
		}
	      actionPerformed = true;
	    }
	}

      if(inputReader.keyPressed(KeyType.RIGHT))
	{
	  var item:Item = itemController.getItemAtPosition(player.position);
	  if(item)
	    {
	      pickUpItem(item);
	    }
	  else
	    {
	      dropItem();
	    }
	  actionPerformed = true;
	}
      else if(inputReader.keyPressed(KeyType.LEFT))
	{
	  useItem();
	  actionPerformed = true;
	}
      if(inputReader.keyPressed(KeyType.UP))
	{
	  player.selectPreviousSlot();
	}
      else if(inputReader.keyPressed(KeyType.DOWN))
	{
	  player.selectNextSlot();
	}
    }
    
    private function generateLevel():void
    {
      graphicsFactory.setLevelType(LevelType.CAVE);

      field.clearField(TileType.BLOCK);

      var fieldBuilder:FieldBuilder = new RandomFieldBuilder(numberGenerator);

      var positions:StartPositions = fieldBuilder.generate(field);
      field.renderBackgroundTiles(graphicsFactory, numberGenerator);

      player.position = positions.start;
      goal = new Goal(graphicsFactory, positions.goal);	

      var randomPositions:Array = field.getEmptyPositionsInRandomOrder(numberGenerator,
								       positions);

      itemController = new ItemController();
      creatureController = new CreatureController();

      var numEnemies:int = numberGenerator.getIntInRange(3, 8);
      var enemyClasses:Array = [Bat, Flea, Snake, Goblin, Mingbat, Undead];
      for(var i:int = 0;i < numEnemies;i++)
	{
	  var randomEnemy:int = numberGenerator.getIntInRange(0, enemyClasses.length - 1);
	  var enemy:Enemy = new enemyClasses[randomEnemy](graphicsFactory, numberGenerator, displayableStatus);
	  enemy.position = randomPositions.pop();
	  creatureController.addEnemy(enemy);
	}

      var numItems:int = numberGenerator.getIntInRange(2, 5);
      var itemClasses:Array = [Stick, Torch, Rubble, Bottle];
      for(i = 0;i < numItems;i++)
	{
	  var rnd:int = numberGenerator.getIntInRange(0, itemClasses.length - 1);
	  itemController.addItem(new itemClasses[rnd](graphicsFactory, randomPositions.pop()));
	}

      for(i = 0;i < 5;i++)
	{
	  var gold:Gold = new Gold(graphicsFactory, randomPositions.pop());
	  gold.generateAmount(numberGenerator, currentLevel);
	  itemController.addItem(gold);
	}

      actionPerformed = false;
    }

    private function getClickedTile(mousePosition:Point):Point
    {
      mousePosition = mousePosition.subtract(FIELD_OFFSET);
      return new Point(int(mousePosition.x/TILE_WIDTH),
		       int(mousePosition.y/TILE_HEIGHT));
    }

    private function printStartingMessage():void
    {
      printMessage(["",
		    "",
		    "WELCOME TO RANDOMHACK 0.1",
		    "PUSH <button> FOR CONTROLS",
		    "",
		    "Your beloved is being offered",
		    "as a sacrifice deep below this",
		    "dungeon. Only you can brave its",
		    "depths, " + player.prefix + " " + player.name + "!"]);
    }

    private function printDeathMessage():void
    {
      printMessage(["You suffer the mortal blow",
		    "",
		    "!!!YOU ARE DEAD!!!",
		    "SCORE: " + 0,
		    "PUSH START FOR NEW GAME"]);
    }

    private function printMessage(message:Array):void
    {
      for each(var str:String in message)
	{
	  displayableStatus.print(str);
	}
    }

    private function pickUpItem(item:Item):void
    {
      if(player.pickUp(item))
	{
	  displayableStatus.print("Picked up " + item.name);
	  itemController.removeItem(item);
	}
    }

    private function dropItem():void
    {
      var item:Item = player.drop(itemController);
      if(item)
	{
	  itemController.addItem(item);
	}
    }

    private function useItem():void
    {
      player.useItem(field, itemController, creatureController);
    }

    private function useInstantItem():void
    {
      var item:Item = itemController.getItemAtPosition(player.position);
      if(item && item.instantUse())
	{
	  item.useItem(player, field, itemController, creatureController, displayableStatus);
	  itemController.removeItem(item);
	}
    }

    private function set currentLevel(_currentLevel:int):void
    {
      this._currentLevel = _currentLevel;
      displayableStatus.level = _currentLevel;
    }

    private function get currentLevel():int
    {
      return _currentLevel;
    }
  }
}
