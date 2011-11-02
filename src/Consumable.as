package
{
  public class Consumable extends Item
  {
    protected var _power:int;

    public function Consumable(gf:GraphicsFactory, type:SpriteType, name:String):void
    {
      super(gf, type, name);
    }

    public function get power():int
    {
      return _power;
    }
  }
}
