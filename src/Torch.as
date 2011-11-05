package
{
  public class Torch extends Item
  {
    private var charges:int;
    private var lightedSticks:int;

    public function Torch(gf:GraphicsFactory):void
    {
      super(gf, SpriteType.TORCH, "a torch");
      charges = 5;
    }

    override public function useItem(player:Player, field:Field, itemController:ItemController,
				     creatureController:CreatureController,
				     displayableStatus:DisplayableStatus):void
    {
      displayableStatus.print("You swing the torch around");
      charges--;
      if(outOfCharges())
	{
	  displayableStatus.print("The torch goes out");
	}

      lightedSticks = 0;
      player.transformItems(transformStick);
      itemController.transformItemsAtAndAround(player.position, transformStick);
      if(lightedSticks > 0)
	{
	  displayableStatus.print("You light the stick" + (lightedSticks > 1 ? "s" : ""));
	}
      creatureController.harmFireWeakCreatures(player, displayableStatus);
    }

    override public function outOfCharges():Boolean
    {
      return charges == 0;
    }

    override public function transformItem():Item
    {
      var stick:Stick = new Stick(graphicsFactory);
      stick.position = position;
      return stick;
    }

    private function transformStick(item:Item):Item
    {
      if(item is Stick)
	{
	  lightedSticks++;
	  var torch:Torch = new Torch(graphicsFactory);
	  torch.position = item.position;
	  return torch;
	}

      return item;
    }
  }
}
