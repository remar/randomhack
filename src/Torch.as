package
{
  public class Torch extends Item
  {
    public function Torch(gf:GraphicsFactory, position:Point):void
    {
      super(gf, SpriteType.TORCH, "Torch");
      this.position = position;
    }
  }
}
