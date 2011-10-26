package
{
  public class Flea extends Enemy
  {
    public function Flea(gf:GraphicsFactory, ng:NumberGenerator, ds:DisplayableStatus):void
    {
      super(gf, SpriteType.FLEA, ng, ds);

      _name = "Flea";
      lookDistance = 4;
      speed = 8;
      maxhp = 2;
      power = 1;
      accuracy = 2;      
    }
  }
}
