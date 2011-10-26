package
{
  public class Goal extends GameObject
  {
    public function Goal(gf:GraphicsFactory, position:Point):void
    {
      super(gf);
      setSprite(SpriteType.GOAL);
      super.position = position;
    }
  }
}
