package
{
  public class Blood extends Item
  {
    public function Blood(gf:GraphicsFactory, position:Point)
    {
      super(gf, SpriteType.BLOOD);
      this.position = position;
    }
  }
}
