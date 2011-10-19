package
{
  public class Rubble extends Item
  {
    public function Rubble(gf:GraphicsFactory, position:Point):void
    {
      super(gf, SpriteType.RUBBLE, "rubble");
      this.position = position;
    }
  }
}
