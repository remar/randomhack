package
{
  public class FakeInfoView implements InfoView
  {
    private var messages:Array;

    public function FakeInfoView():void
    {
      messages = [];
    }

    public function connect(displayableStatus:DisplayableStatus):void {}
    public function notify():void {}
    public function draw(drawable:Drawable):void {}

    public function print(string:String):void
    {
      messages.push(string);
    }

    public function hasPrintedMessage(string:String):Boolean
    {
      for(var i:int = 0;i < messages.length;i++)
	{
	  if(messages[i].match(string) != null)
	    {
	      return true;
	    }
	}

      return false;
    }
  }
}
