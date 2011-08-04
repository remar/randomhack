package
{
  public class Stick extends Item
  {
    public function Stick(gf:GraphicsFactory, position:Point):void
    {
      super(gf, SpriteType.STICK, "Stick");
      this.position = position;
    }
  }
}
