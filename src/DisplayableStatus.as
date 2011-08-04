package
{
  public class DisplayableStatus
  {
    private var listeners:Array;

    private var playerPrefix:String;
    private var playerName:String;
    private var HP:int;
    private var maxHP:int;
    private var playerPower:int;
    private var Gold:int;
    private var currentLevel:int;
    private var hiScore:int;
    private var weaponName:String;
    private var _inventory:Array;

    public function DisplayableStatus():void
    {
      listeners = [];

      playerPrefix = "prefix";
      playerName = "name";
      HP = 10;
      maxHP = 10;
      playerPower = 5;
      Gold = 0;
      currentLevel = 1;
      hiScore = 0;
      weaponName = "Bare hands";
      _inventory = ["","","","","","","",""];
    }

    public function registerListener(infoView:InfoView):void
    {
      infoView.connect(this);
      listeners.push(infoView);
    }

    public function print(string:String):void
    {
      for each(var infoView:InfoView in listeners)
		{
		  infoView.print(string);
		}
    }

    public function set playerprefix(playerPrefix:String):void
    {
      this.playerPrefix = playerPrefix;
      notifyListeners();
    }

    public function get playerprefix():String
    {
      return playerPrefix;
    }

    public function set playername(playerName:String):void
    {
      this.playerName = playerName;
      notifyListeners();
    }

    public function get playername():String
    {
      return playerName;
    }

    public function set hp(HP:int):void
    {
      this.HP = HP;
      notifyListeners();
    }

    public function get hp():int
    {
      return HP;
    }

    public function set maxhp(maxHP:int):void
    {
      this.maxHP = maxHP;
      notifyListeners();
    }

    public function get maxhp():int
    {
      return maxHP;
    }

    public function set playerpower(playerPower:int):void
    {
      this.playerPower = playerPower;
      notifyListeners();
    }

    public function get playerpower():int
    {
      return playerPower;
    }

    public function set gold(Gold:int):void
    {
      this.Gold = Gold;
      notifyListeners();
    }

    public function get gold():int
    {
      return Gold;
    }

    public function set level(currentLevel:int):void
    {
      this.currentLevel = currentLevel;
      notifyListeners();
    }

    public function get level():int
    {
      return currentLevel;
    }

    public function set hiscore(hiScore:int):void
    {
      this.hiScore = hiScore;
      notifyListeners();
    }

    public function get hiscore():int
    {
      return hiScore;
    }

    public function set weapon(weaponName:String):void
    {
      this.weaponName = weaponName;
      notifyListeners();
    }

    public function get weapon():String
    {
      return weaponName;
    }

    public function set inventory(_inventory:Array):void
    {
      this._inventory = _inventory;
      notifyListeners();
    }

    public function get inventory():Array
    {
      return _inventory;
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
