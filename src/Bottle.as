package
{
  public class Bottle extends Item
  {
    private var carriedItem:Item;
    private var modified:Boolean;

    public function Bottle(gf:GraphicsFactory, position:Point):void
    {
      super(gf, SpriteType.BOTTLE, "an empty bottle");
      this.position = position;
      carriedItem = null;
      modified = false;
    }

    override public function useItem(player:Player, field:Field,
				     itemController:ItemController,
				     creatureController:CreatureController,
				     displayableStatus:DisplayableStatus):void
    {
      if(carriedItem != null)
	{
	  carriedItem.position = player.position;
	  itemController.addItem(carriedItem);
	  _name = "an empty bottle";
	  displayableStatus.print("You pour the " + carriedItem.name + " out");
	  carriedItem = null;
	  modified = true;
	  return;
	}

      var item:Item = itemController.getItemAtPosition(player.position);

      if(item != null)
	{
	  if(item.needBottleToCarry())
	    {
	      itemController.removeItem(item);
	      carriedItem = item;
	      _name = "bottled " + item.name;
	      displayableStatus.print("You scoop up the " + item.name);
	      modified = true;
	    }
	  else
	    {
	      displayableStatus.print("You can't put this in a bottle");
	    }
	}
    }

    override public function isModified():Boolean
    {
      if(modified)
	{
	  modified = false;
	  return true;
	}

      return false;
    }
  }
}
