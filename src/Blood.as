package
{
  public class Blood extends Item
  {
    public function Blood(gf:GraphicsFactory, position:Point)
    {
      super(gf, SpriteType.BLOOD, "blood");
      this.position = position;
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
