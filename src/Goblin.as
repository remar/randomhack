package
{
  public class Goblin extends Enemy
  {
    public function Goblin(gf:GraphicsFactory, numberGenerator:NumberGenerator):void
    {
      super(gf, SpriteType.GOBLIN, numberGenerator);

      _name = "Goblin";
      lookDistance = 4;
      speed = 7;
      maxhp = 5;
      power=3;
      accuracy=3;      
    }    
  }
}
