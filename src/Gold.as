package
{
  public class Gold extends Item
  {
    private var amount:int;

    public function Gold(gf:GraphicsFactory):void
    {
      super(gf, SpriteType.GOLD, "some gold");
    }

    public function generateAmount(ng:NumberGenerator, level:int):void
    {
      amount = ng.getIntInRange(1, level/2 + 1);
      _name = amount + " gold";
    }

    override public function useItem(player:Player, field:Field,
				     itemController:ItemController,
				     creatureController:CreatureController,
				     displayableStatus:DisplayableStatus):void
    {
      player.addGold(amount);
      displayableStatus.print("Found " + amount + " gold");
  }

    override public function instantUse():Boolean
    {
      return true;
    }
  }
}
