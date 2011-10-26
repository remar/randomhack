package
{
  public class Mingbat extends Enemy
  {
    private var item:Item;

    public function Mingbat(gf:GraphicsFactory, ng:NumberGenerator, ds:DisplayableStatus):void
    {
      super(gf, SpriteType.MINGBAT, ng, ds);

      _name = "Mingbat";
      maxhp = 4;
      power = 2;
      accuracy = 5;      
      lookDistance = 5;
      speed = 8;

      item = null;
    }

    override public function move(field:Field, playerPos:Point,
				  creatures:Array,
				  itemController:ItemController):void
    {
      // Move around, perhaps picking up/dropping stuff along the way.
      generalMove(field, playerPos, creatures, itemController);

      if(item == null)
	{
	  var i:Item = itemController.getItemAtPosition(position);
	  if(i != null && i.canBeCarriedByEnemy())
	    {
	      itemController.removeItem(i);
	      item = i;
	    }
	}
    }

    override public function die(itemController:ItemController,
				 displayableStatus:DisplayableStatus,
				 graphicsFactory:GraphicsFactory):void
    {
      if(item != null)
	{
	  item.position = position;
	  itemController.addItem(item);
	}

      generalDie(itemController, displayableStatus, graphicsFactory);
    }
  }
}
