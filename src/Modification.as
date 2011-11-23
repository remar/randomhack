package
{
  public class Modification
  {
    private var _prefix:String;
    private var _lookDistance:Modifier;
    private var _speed:Modifier;
    private var _maxhp:Modifier;
    private var _power:Modifier;
    private var _accuracy:Modifier;

    public function Modification():void
    {
      prefix = "PREFIX";
      setupNullModifiers();
    }

    public function set prefix(_prefix:String):void
    {
      this._prefix = _prefix;
    }

    public function set lookDistance(mod:Modifier):void
    {
      _lookDistance = mod;
    }

    public function set speed(mod:Modifier):void
    {
      _speed = mod;
    }

    public function set maxhp(mod:Modifier):void
    {
      _maxhp = mod;
    }

    public function set power(mod:Modifier):void
    {
      _power = mod;
    }

    public function set accuracy(mod:Modifier):void
    {
      _accuracy = mod;
    }

    public function get prefix():String
    {
      return _prefix;
    }

    public function applyLookDistanceModifier(lookDistance:int):int
    {
      return _lookDistance.apply(lookDistance);
    }

    public function applySpeedModifier(speed:int):int
    {
      return _speed.apply(speed);
    }

    public function applyMaxhpModifier(maxhp:int):int
    {
      return _maxhp.apply(maxhp);
    }

    public function applyPowerModifier(power:int):int
    {
      return _power.apply(power);
    }

    public function applyAccuracyModifier(accuracy:int):int
    {
      return _accuracy.apply(accuracy);
    }

    private function setupNullModifiers():void
    {
      var nullModifier:Modifier = new Modifier(1, 1);

      lookDistance = nullModifier;
      speed = nullModifier;
      maxhp = nullModifier;
      power = nullModifier;
      accuracy = nullModifier;
    }

  }
}
