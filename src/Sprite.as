package
{
  public class Sprite
  {
    private var width:int;
    private var height:int;
    private var data:Array;
    private var color:int;

    public function Sprite(width:int, height:int):void
    {
      this.width = width;
      this.height = height;
      data = [];
      color = 0x000000;
    }

    public function setData(data:Array):void
    {
      this.data = data.slice(0);
    }

    public function setColor(color:int):void
    {
      this.color = color;
    }

    public function draw(d:Drawable, xPos:int, yPos:int):void
    {
      for(var y:int = 0;y < height;y++)
	{
	  for(var x:int = 0;x < width;x++)
	    {
	      if(data[x + y * width] == 1)
		{
		  d.setPixel(xPos + x, yPos + y, color);
		}
	    }
	}
    }
  }
}

