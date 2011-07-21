package
{
    public class DisplayableStatus
    {
	private var listeners:Array;

	private var HP:int;

	public function DisplayableStatus():void
	{
	    listeners = [];
	}

	public function registerListener(infoView:InfoView):void
	{
	    infoView.connect(this);
	    listeners.push(infoView);
	}

	// TODO various methods for updating the displayed status,
	// eg. setHP, setMaxHP etc.

	public function set hp(HP:int):void
	{
	    this.HP = HP;
	    notifyListeners();
	}

	public function get hp():int
	{
	    return HP;
	}

	private function notifyListeners():void
	{
	    for each(var infoView:InfoView in listeners)
	      {
		  infoView.notify();
	      }
	}
    }
}
