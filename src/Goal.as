package
{
  public class Goal extends GameObject
  {
    public function Goal(position:Point):void
    {
      var sprite:Sprite = new Sprite(8, 8);
      sprite.setData([0,0,0,0,1,1,1,1,
		      0,0,0,0,1,1,1,1,
		      0,0,1,1,1,0,0,1,
		      0,0,1,1,1,0,0,1,
		      1,1,1,0,0,0,0,1,
		      1,1,1,0,0,0,0,1,
		      1,0,0,0,0,0,0,1,
		      1,1,1,1,1,1,1,1]);
      sprite.setColor(0xcccccc);

      super(sprite);
      super.position = position;
    }
  }
}
