package
{
  public class Bat extends Enemy
  {
    public function Bat(gf:GraphicsFactory, numberGenerator:NumberGenerator):void
    {
      super(gf, SpriteType.BAT, numberGenerator);

      _name = "Bat";
      lookDistance = 4;
      speed = 5;
      maxhp = 2;
      power=2;
      accuracy=3;      
    }
  }
}
