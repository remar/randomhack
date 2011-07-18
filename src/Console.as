package
{
    public class Console
    {
	private var graphicsFactory:GraphicsFactory;

	private var lines:Array;

	private var charmap:Object = {" ": SpriteType.EMPTY,
				      "A": SpriteType.A,
				      "B": SpriteType.B};

	public function Console(graphicsFactory:GraphicsFactory):void
	{
	    this.graphicsFactory = graphicsFactory;
	    lines = [];
	}

	public function draw(drawable:Drawable):void
	{
	    // draw all characters
	    for each(var line:Array in lines)
	      {
		  for each(var char:SpriteInstance in line)
		    {
			char.draw(drawable);			
		    }
	      }
	}

	public function print(row:int, string:String):void
	{
	    if(row < 0 || row > 23)
		return;

	    lines[row] = [];

	    var char:SpriteInstance;
	    var i:int = 0;
	    for each(var character:String in string.split(""))
	      {
		  var type:int = charmap[character] === undefined ? SpriteType.PLAYER : charmap[character];
		  char = new SpriteInstance(graphicsFactory.getSprite(type));
		  char.setPosition(new Point(i*8, row*8));
		  i++;
		  lines[row].push(char);
	      }

	}
    }
}
