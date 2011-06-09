package
{
  public class Goal
  {
    private var pos:Point;
    private var spriteInstance:SpriteInstance;

    public function Goal(position:Point):void
    {
      this.pos = position;

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
      spriteInstance = new SpriteInstance(sprite);
      spriteInstance.setPosition(pos.multiple(8));
    }

    public function get position():Point
    {
      return pos;
    }

    public function draw(drawable:Drawable):void
    {
      spriteInstance.draw(drawable);
    }
  }
}
