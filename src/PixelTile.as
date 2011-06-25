package
{
  public class PixelTile implements Tile
  {
    private var width:int;
    private var height:int;
    private var data:Array;

    public function PixelTile(width:int, height:int):void
    {
      this.width = width;
      this.height = height;
      data = [];
    }

    public function getWidth():int
    {
      return width;
    }

    public function getHeight():int
    {
      return height;
    }

    public function setData(data:Array):void
    {
      this.data = data.slice(0);
    }

    public function getData():Array
    {
      return data;
    }
  }
}
