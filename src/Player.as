package
{
  public class Player extends GameObject
  {
    private var field:Field;
    private var sprite:Sprite;

    public function Player(gf:GraphicsFactory, field:Field, position:Point):void
    {
      this.field = field;
      super(gf, SpriteType.PLAYER);
      this.position = position;
    }
  }
}
