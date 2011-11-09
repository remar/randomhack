package
{
  public class Bottle extends Item
  {
    private var carriedItem:Item;
    private var water:int;
    private var modified:Boolean;
    private var waterCharges:int;

    public function Bottle(gf:GraphicsFactory):void
    {
      super(gf, SpriteType.BOTTLE, "an empty bottle");
      carriedItem = null;
      modified = false;
    }

    override public function useItem(player:Player, field:Field,
				     itemController:ItemController,
				     creatureController:CreatureController,
				     displayableStatus:DisplayableStatus,
				     itemFactory:ItemFactory):void
    {
      if(carriedItem != null)
	{
	  if(carriedItem is WaterPool)
	    {
	      splashWater(displayableStatus);
	    }
	  else
	    {
	      pourOutCarriedItem(player, itemController, displayableStatus);
	    }
	  return;
	}

      var item:Item = itemController.getItemAtPosition(player.position);

      if(item != null)
	{
	  if(item.needBottleToCarry())
	    {
	      putItemInBottle(item, itemController, displayableStatus);
	    }
	  else
	    {
	      displayableStatus.print("You can't put this in a bottle");
	    }
	}
      else
	{
	  // Try to scoop up water
	  var tileTypes:Array = field.getTileTypesAroundPosition(player.position);
	  var waterFound:Boolean = false;
	  for(var i:int = 0;i < tileTypes.length;i++)
	    {
	      if(tileTypes[i] === TileType.WATER)
		{
		  waterFound = true;
		  break;
		}
	    }

	  if(waterFound)
	    {
	      displayableStatus.print("SCOOP UP WATER");
	      carriedItem = itemFactory.getItem(ItemType.WATER_POOL);
	      _name = "bottled water";
	      displayableStatus.print("You scoop up 5 parts of water");
	      modified = true;
	      waterCharges = 5;
	    }
	  else
	    {
	      displayableStatus.print("Nothing to scoop up here");
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

    private function pourOutCarriedItem(player:Player,
					itemController:ItemController,
					displayableStatus:DisplayableStatus):void
    {
      displayableStatus.print("You pour the " + carriedItem.name + " out");
      carriedItem.position = player.position;
      itemController.addItem(carriedItem);
      emptyBottle();
    }

    private function putItemInBottle(item:Item,
				     itemController:ItemController,
				     displayableStatus:DisplayableStatus):void
    {
      itemController.removeItem(item);
      carriedItem = item;
      _name = "bottled " + item.name;
      displayableStatus.print("You scoop up the " + item.name);
      modified = true;
    }

    private function splashWater(displayableStatus:DisplayableStatus):void
    {
      displayableStatus.print("You splash the water around you");
      waterCharges--;
      if(waterCharges == 0)
	{
	  // out of charges, empty bottle
	  displayableStatus.print("The water runs out");
	  emptyBottle();
	}
    }

    private function emptyBottle():void
    {
      _name = "an empty bottle";
      carriedItem = null;
      modified = true;
    }
  }
}
