package
{
    public class ConsoleInfoView implements InfoView
    {
	private var console:Console;
	private var displayableStatus:DisplayableStatus;
	
	public function ConsoleInfoView(graphicsFactory:GraphicsFactory):void
	{
	    console = new Console(graphicsFactory);
	}

	public function connect(displayableStatus:DisplayableStatus):void
	{
	    this.displayableStatus = displayableStatus;
	}

	public function notify():void
	{
	    // get status from displayableStatus and update view
	    console.print(0, "Randomhack!!");
	    console.print(1, "HP: " + displayableStatus.hp);
	}

	public function draw(drawable:Drawable):void
	{
	    console.draw(drawable);
	}
    }
}
