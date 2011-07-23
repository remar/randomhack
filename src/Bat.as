package
{
  public class Bat extends Enemy
  {
    public function Bat(gf:GraphicsFactory, numberGenerator:NumberGenerator):void
    {
      super(gf, SpriteType.BAT, numberGenerator);

      lookDistance = 4;
      speed = 5;
      maxhp = 2;
    }
  }
}
