package
{
  public class BitterBerries extends Consumable
  {
    public function BitterBerries(gf:GraphicsFactory, position:Point):void
    {
      super(gf, SpriteType.BITTER_BERRIES, "bitter berries");
      this.position = position;
    }

    public function generateAmount(ng:NumberGenerator, level:int):void
    {
      _power = ng.getIntInRange(1, 4);
      _name = power + " bitter berr" + (power == 1 ? "y" : "ies");
    }
  }
}
