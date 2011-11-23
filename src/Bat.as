package
{
  public class Bat extends Enemy
  {
    public function Bat(gf:GraphicsFactory, ng:NumberGenerator, ds:DisplayableStatus):void
    {
      super(gf, SpriteType.BAT, ng, ds);

      _name = "Bat";
      _prefix = "a";
      lookDistance = 4;
      speed = 5;
      maxhp = 2;
      power=2;
      accuracy=3;      
    }
  }
}
