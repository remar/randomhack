package
{
  public class Weapon
  {
    protected var _power:int;
    protected var _name:String;

    public function Weapon(_name:String, _power:int):void
    {
      this._name = _name;
      this._power = _power;
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
