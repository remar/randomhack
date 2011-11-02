package
{
  public class SweetBerries extends Consumable
  {
    public function SweetBerries(gf:GraphicsFactory, position:Point):void
    {
      super(gf, SpriteType.SWEET_BERRIES, "sweet berries");
      this.position = position;
    }

    public function generateAmount(ng:NumberGenerator, level:int):void
    {
      _power = ng.getIntInRange(0, level/2) + 2 + level/3;
      _name = power + " sweet berries";
    }

    override public function useItem(player:Player, field:Field,
				     itemController:ItemController,
				     creatureController:CreatureController,
				     displayableStatus:DisplayableStatus):void
    {
      player.eat(this);
      _eaten = true;
    }
  }
}
