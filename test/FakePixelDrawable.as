package
{
  public class FakePixelDrawable implements PixelDrawable
  {
    private var canvas:Array;
    private static const defaultColor:int = 0x000000;

    public function FakePixelDrawable(width:int, height:int):void
    {
      canvas = new Array(width);
      for(var i:int = 0;i < width;i++)
	{
	  canvas[i] = new Array(height);
	  for(var j:int = 0;j < height;j++)
	    {
	      canvas[i][j] = defaultColor;
	    }
	}
    }

    public function setPixel(x:int, y:int, color:int):void
    {
      canvas[x][y] = color;
    }

    public function getPixel(x:int, y:int):int
    {
      return canvas[x][y];
    }
  }
}
