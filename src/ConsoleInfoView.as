package
{
  public class ConsoleInfoView implements InfoView
  {
    private var console:Console;
    private var ds:DisplayableStatus;
    private var lines:Array;
    private var currentLine:int;
    private static const MAX_LINES:int = 8;
	
    public function ConsoleInfoView(graphicsFactory:GraphicsFactory):void
    {
      console = new Console(graphicsFactory);
      lines = new Array(MAX_LINES);
      currentLine = 0;
    }

    public function connect(displayableStatus:DisplayableStatus):void
    {
      this.ds = displayableStatus;
    }

    public function notify():void
    {
      // get status from displayableStatus and update view
      var line:int = 0;
      console.print(line++, ds.playerprefix + " " + ds.playername);
      console.print(line++, "HP: " + ds.hp + " / " + ds.maxhp + "   ");
      console.print(line++, "Power: " + ds.playerpower + " Gold: " + ds.gold);
      console.print(line++, "Level: " + ds.level + " Hiscore: " + ds.hiscore);
      line++;
      console.print(line++, " WEAPON: " + ds.weapon);

      for(var i:int = 0;i < 9;i++)
	{
	  console.print(line++, "   ITEM" + (i+1) + ": ---");
	}
      console.print(line++, "--------------------------------");
    }

    public function print(string:String):void
    {
      if(currentLine >= MAX_LINES)
	{
	  console.scroll(17, 23, 1);
	  console.print(23, string);
	}
      else
	{
	  console.print(16 + currentLine++, string);
	}
    }

    public function draw(drawable:Drawable):void
    {
      console.draw(drawable);
    }
  }
}
