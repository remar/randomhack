package
{
  public class Blood extends Item
  {
    public function Blood(gf:GraphicsFactory)
    {
      super(gf, SpriteType.BLOOD, "blood");
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
