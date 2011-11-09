package
{
  public class ItemFactory
  {
    private var graphicsFactory:GraphicsFactory;
    private var numberGenerator:NumberGenerator;
    private var _currentLevel:int;

    public function ItemFactory(gf:GraphicsFactory, ng:NumberGenerator):void
    {
      graphicsFactory = gf;
      numberGenerator = ng;
    }

    public function set currentLevel(_currentLevel:int):void
    {
      this._currentLevel = _currentLevel;
    }

    public function getItem(itemType:ItemType):Item
    {
      var item:Item = null;

      switch(itemType)
	{
	case ItemType.BLOOD:
	  item = new Blood(graphicsFactory);
	  break;

	case ItemType.SWORD:
	  var s:Sword = new Sword(graphicsFactory);
	  s.generateNameAndPower(_currentLevel, numberGenerator);
	  item = s;
	  break;

	case ItemType.GOLD:
	  var g:Gold = new Gold(graphicsFactory);
	  g.generateAmount(numberGenerator, _currentLevel);
	  item = g;
	  break;

	case ItemType.SWEET_BERRIES:
	  var b:SweetBerries = new SweetBerries(graphicsFactory);
	  b.generateAmount(numberGenerator, _currentLevel);
	  item = b;
	  break;

	case ItemType.BITTER_BERRIES:
	  var b2:BitterBerries = new BitterBerries(graphicsFactory);
	  b2.generateAmount(numberGenerator, _currentLevel);
	  item = b2;
	  break;

	case ItemType.STICK:
	  item = new Stick(graphicsFactory);
	  break;

	case ItemType.TORCH:
	  item = new Torch(graphicsFactory);
	  break;

	case ItemType.RUBBLE:
	  item = new Rubble(graphicsFactory);
	  break;

	case ItemType.BOTTLE:
	  item = new Bottle(graphicsFactory);
	  break;

	case ItemType.WATER_POOL:
	  item = new WaterPool(graphicsFactory);
	  break;
	}

      return item;
    }

    public function getRareItem():Item
    {
      var rareItems:Array = [ItemType.BITTER_BERRIES, ItemType.STICK,
			     ItemType.TORCH, ItemType.RUBBLE];
      return getItem(rareItems[numberGenerator.getIntInRange(0, rareItems.length - 1)]);
    }

    public function getVeryRareItem():Item
    {
      var rareItems:Array = [ItemType.BOTTLE];
      return getItem(rareItems[numberGenerator.getIntInRange(0, rareItems.length - 1)]);
    }
  }
}
