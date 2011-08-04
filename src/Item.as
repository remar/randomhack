package
{
  public class Item extends GameObject
  {
    protected var _name:String;

    public function Item(gf:GraphicsFactory, spriteType:int, name:String):void
    {
      super(gf, spriteType);
      _name = name;
    }

    public function get name():String
    {
      return _name;
    }
  }
}
