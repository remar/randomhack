package
{
  public class Goal extends GameObject
  {
    public function Goal(position:Point):void
    {
      var sprite:Sprite = new PixelSprite(8, 8);
      sprite.setData([0,0,0,0,1,1,1,1,
		      0,0,0,0,1,1,1,1,
		      0,0,1,1,1,0,0,1,
		      0,0,1,1,1,0,0,1,
		      1,1,1,0,0,0,0,1,
		      1,1,1,0,0,0,0,1,
		      1,0,0,0,0,0,0,1,
		      1,1,1,1,1,1,1,1,
		      0xcccccc]);
      super(sprite);
      super.position = position;
    }
  }
}
