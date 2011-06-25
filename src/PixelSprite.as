package
{
  public class PixelSprite implements Sprite
  {
    private var width:int;
    private var height:int;
    private var data:Array;
    private var color:int;

    public function PixelSprite(width:int, height:int):void
    {
      this.width = width;
      this.height = height;
      data = [];
      color = 0x000000;
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

    public function setColor(color:int):void
    {
      this.color = color;
    }
  }
}
