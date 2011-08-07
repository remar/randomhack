package
{
  public class Inventory
  {
    private static const INVENTORY_SIZE:int = 8;
    private var _inventory:Array;
    private var _selectedSlot:int;
    private var displayableStatus:DisplayableStatus;

    public function Inventory(displayableStatus:DisplayableStatus):void
    {
      _inventory = new Array(INVENTORY_SIZE);
      _selectedSlot = 0;
      this.displayableStatus = displayableStatus;
      updateInventoryDisplay();
      updateSelectedSlot();
    }

    public function full():Boolean
    {
      return getFreeSpot() == -1;
    }

    public function addItem(item:Item):void
    {
      var freeSpot:int = getFreeSpot();

      if(freeSpot === -1)
	{
	  return;
	}

      _inventory[freeSpot] = item;

      updateInventoryDisplay();
    }

    public function selectNextSlot():void
    {
      _selectedSlot++;

      if(_selectedSlot == INVENTORY_SIZE)
	_selectedSlot = 0;

      updateSelectedSlot();
    }

    public function selectPreviousSlot():void
    {
      _selectedSlot--;

      if(_selectedSlot == -1)
	_selectedSlot = INVENTORY_SIZE - 1;

      updateSelectedSlot();
    }

    public function getSelectedItem():Item
    {
      return _inventory[_selectedSlot];
    }

    public function removeSelectedItem():Item
    {
      var item:Item = _inventory[_selectedSlot];
      _inventory[_selectedSlot] = undefined;
      updateInventoryDisplay();
      return item;
    }

    public function transformSelectedItem():void
    {
      _inventory[_selectedSlot] = _inventory[_selectedSlot].transformItem();
      updateInventoryDisplay();
    }

    public function transformItems(transformer:Function):void
    {
      for(var i:int = 0;i < INVENTORY_SIZE;i++)
	{
	  if(_inventory[i])
	    {
	      _inventory[i] = transformer(_inventory[i]);
	    }
	}
      updateInventoryDisplay();
    }

    private function updateInventoryDisplay():void
    {
      displayableStatus.inventory = _inventory.map(itemToString);
    }

    private function itemToString(item:Item, i:int, a:Array):String
      {
	return item ? item.name : "---";
      } 

    private function updateSelectedSlot():void
    {
      displayableStatus.selectedSlot = _selectedSlot;
    }

    private function getFreeSpot():int
    {
      var freeSpot:int = -1;

      for(var i:int = 0;i < INVENTORY_SIZE;i++)
	{
	  if(_inventory[i] === undefined)
	    {
	      freeSpot = i;
	      break;
	    }
	}

      return freeSpot;
    }
  }
}
