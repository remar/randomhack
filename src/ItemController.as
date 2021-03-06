package
{
  public class ItemController
  {
    private var items:Array;

    public function ItemController():void
    {
      items = [];
    }

    public function addItem(item:Item):void
    {
      items.push(item);
    }

    public function removeItem(item:Item):void
    {
      items.splice(items.indexOf(item), 1);
    }

    public function getItems():Array
    {
      return items;
    }

    public function drawItems(drawable:Drawable):void
    {
      forEachItem(function (item:Item):void {item.draw(drawable);});
    }

    public function getItemAtPosition(position:Point):Item
    {
      var item:Item = null;

      var fun:Function = function (e:Item):void { if(e.position.equals(position)) item = e;};

      forEachItem(fun);

      return item;
    }

    public function transformItemsAtAndAround(position:Point, transformer:Function):void
    {
      for(var y:int = -1;y < 2;y++)
	for(var x:int = -1;x < 2;x++)
	  {
	    var pos:Point = new Point(position.x + x, position.y + y);
	    var item:Item = getItemAtPosition(pos);
	    if(item != null)
	      {
		removeItem(item);
		addItem(transformer(item));
	      }
	  }
    }

    private function forEachItem(fun:Function):void
    {
      items.forEach(function (item:Item, i:int, a:Array):void {fun(item);});
    }    
  }
}
