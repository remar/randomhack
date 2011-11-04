package
{
  public class SweetBerries extends Consumable
  {
    public function SweetBerries(gf:GraphicsFactory):void
    {
      super(gf, SpriteType.SWEET_BERRIES, "sweet berries");
    }

    public function generateAmount(ng:NumberGenerator, level:int):void
    {
      _power = ng.getIntInRange(0, level/2) + 2 + level/3;
      _name = power + " sweet berries";
    }
  }
}
