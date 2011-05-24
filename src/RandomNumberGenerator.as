package
{
  public class RandomNumberGenerator implements NumberGenerator
  {
    public function getNumber():Number
      {
	return Math.random();
      }

    public function getIntInRange(start:int, end:int):int
    {
      return Math.floor(Math.random() * (end - start + 1)) + start;
    }
  }
}
