package
{
  public class WaterShade extends Enemy
  {
    public function WaterShade(gf:GraphicsFactory, ng:NumberGenerator, ds:DisplayableStatus):void
    {
      super(gf, SpriteType.WATER_SHADE, ng, ds);

      _name = "WaterShade";
      maxhp = 12;
      power = 4;
      accuracy = 5;
      lookDistance = 4;
      speed = 8;
      // tempid.drop=WATERPOOL;
    }

    override public function attackedWithFire(player:Player, ds:DisplayableStatus):void
    {
      generalAttackedWithFire(player, ds);
    }
  }
}
