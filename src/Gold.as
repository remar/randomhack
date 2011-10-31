package
{
  public class Gold extends Item
  {
    private var amount:int;

    public function Gold(gf:GraphicsFactory, position:Point):void
    {
      super(gf, SpriteType.GOLD, "some gold");
      this.position = position;
    }

    public function generateAmount(ng:NumberGenerator, level:int):void
    {
	amount = ng.getIntInRange(1, level/2 + 1);
	_name = amount + " gold";
    }
  }
}
