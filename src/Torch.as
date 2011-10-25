package
{
  public class Torch extends Item
  {
    private var charges:int;
    private var lightedSticks:int;

    public function Torch(gf:GraphicsFactory, position:Point):void
    {
      super(gf, SpriteType.TORCH, "a torch");
      this.position = position;
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
      return new Stick(graphicsFactory, position);
    }

    private function transformStick(item:Item):Item
    {
      if(item is Stick)
	{
	  lightedSticks++;
	  return new Torch(graphicsFactory, item.position);
	}

      return item;
    }
  }
}
