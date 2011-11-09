package
{
  public class WaterPool extends Item
  {
    public function WaterPool(gf:GraphicsFactory):void
    {
      super(gf, SpriteType.WATER_POOL, "a water pool");
    }

    override public function needBottleToCarry():Boolean
    {
      return true;
    }

    override public function canBeCarriedByEnemy():Boolean
    {
      return false;
    }
  }
}
