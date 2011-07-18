package
{
  public class Player extends GameObject
  {
    public function Player(gf:GraphicsFactory, position:Point):void
    {
      super(gf, SpriteType.PLAYER);
      this.position = position;
    }
  }
}
