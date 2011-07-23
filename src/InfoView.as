package
{
  public interface InfoView
  {
    function connect(displayableStatus:DisplayableStatus):void;
    function notify():void; // the DisplayableStatus has new status
    function print(string:String):void;
    function draw(drawable:Drawable):void;
  }
}
