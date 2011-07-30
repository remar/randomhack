package
{
  public class Weapon extends Item
  {
    protected var _power:int;
    protected var _name:String;

    public function Weapon(gf:GraphicsFactory, spriteType:int):void
    {
      super(gf, spriteType);
    }

    public function get name():String
    {
      return _name;
    }

    public function get power():int
    {
      return _power;
    }
  }
}
