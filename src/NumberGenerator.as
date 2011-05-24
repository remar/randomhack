package
{
  public interface NumberGenerator
  {
    /* Returns a number between 0.0 and 1.0 */
    function getNumber():Number;

    /* Returns a number between start and end (inclusive) */
    function getIntInRange(start:int, end:int):int;
  }
}
