package
{
  public class Goal extends GameObject
  {
    public function Goal(gf:GraphicsFactory, position:Point):void
    {
      super(gf, SpriteType.GOAL);
      super.position = position;
    }
  }
}
