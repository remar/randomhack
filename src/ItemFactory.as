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
	  /*
    STICK
    TORCH
    RUBBLE
    BOTTLE
    GOLD
    SWEET_BERRIES
    BITTER_BERRIES
	  */

	}

      return item;
    }
  }
}
