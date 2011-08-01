package
{
  public class Flea extends Enemy
  {
    public function Flea(gf:GraphicsFactory, numberGenerator:NumberGenerator):void
    {
      super(gf, SpriteType.FLEA, numberGenerator);

      _name = "Flea";
      lookDistance = 4;
      speed = 8;
      maxhp = 2;
      power = 1;
      accuracy = 2;      
    }
  }
}
