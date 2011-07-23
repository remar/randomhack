package
{
  public class DeterministicNumberGenerator implements NumberGenerator
  {
    private var numbers:Array;
    private var numberCounter:int;
    private var ints:Array;
    private var intCounter:int;

    public function DeterministicNumberGenerator():void
    {
      numbers = [];
      numberCounter = 0;

      ints = [];
      intCounter = 0;
    }

    public function getNumber():Number
    {
      var n:Number = numbers[numberCounter];

      numberCounter += 1;
      if(numberCounter == numbers.length)
	{
	  numberCounter = 0;
	}

      return n;
    }

    public function getIntInRange(start:int, end:int):int
    {
      var i:int = ints[intCounter];

      intCounter += 1;
      if(intCounter == ints.length)
	{
	  intCounter = 0;
	}

      return i;
    }

    public function addNumber(number:Number):void
    {
      numbers.push(number);
    }

    public function addNumbers(numbers:Array):void
    {
      for (var key:String in numbers)
	{
	  addNumber(numbers[key]);
	}
    }

    public function addInt(theInt:int):void
    {
      ints.push(theInt);
    }

    public function addInts(ints:Array):void
    {
      for (var key:String in ints)
	{
	  addInt(ints[key]);
	}
    }
  }
}
