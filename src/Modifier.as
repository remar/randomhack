package
{
  public class Modifier
  {
    private var multiplier:int;
    private var divisor:int;

    public function Modifier(multiplier:int, divisor:int):void
    {
      this.multiplier = multiplier;
      this.divisor = divisor;
    }

    public function apply(value:int):int
    {
      return value * multiplier / divisor;
    }
  }
}
