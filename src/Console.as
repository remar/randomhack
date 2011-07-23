package
{
  public class Console
  {
    private var graphicsFactory:GraphicsFactory;

    private var lines:Array;

    private var charmap:Object = {" ": SpriteType.EMPTY,
				  "!": SpriteType.EXCLAMATION,
				  "\"": SpriteType.QUOTE,
				  "#": SpriteType.HASH,
				  "$": SpriteType.DOLLAR,
				  "%": SpriteType.PERCENT,
				  "&": SpriteType.AMPERSAND,
				  "'": SpriteType.TICK,
				  "(": SpriteType.LEFT_PAREN,
				  ")": SpriteType.RIGHT_PAREN,
				  "*": SpriteType.TIMES,
				  "+": SpriteType.PLUS,
				  ",": SpriteType.COMMA,
				  "-": SpriteType.MINUS,
				  ".": SpriteType.DOT,
				  "/": SpriteType.SLASH,
				  "0": SpriteType.N_0,
				  "1": SpriteType.N_1,
				  "2": SpriteType.N_2,
				  "3": SpriteType.N_3,
				  "4": SpriteType.N_4,
				  "5": SpriteType.N_5,
				  "6": SpriteType.N_6,
				  "7": SpriteType.N_7,
				  "8": SpriteType.N_8,
				  "9": SpriteType.N_9,
				  ":": SpriteType.COLON,
				  ";": SpriteType.SEMI_COLON,
				  "<": SpriteType.LESS_THAN,
				  "=": SpriteType.EQUALS,
				  ">": SpriteType.LARGER_THAN,
				  "?": SpriteType.QUESTION,
				  "@": SpriteType.AT,
				  "A": SpriteType.A,
				  "B": SpriteType.B,
				  "C": SpriteType.C,
				  "D": SpriteType.D,
				  "E": SpriteType.E,
				  "F": SpriteType.F,
				  "G": SpriteType.G,
				  "H": SpriteType.H,
				  "I": SpriteType.I,
				  "J": SpriteType.J,
				  "K": SpriteType.K,
				  "L": SpriteType.L,
				  "M": SpriteType.M,
				  "N": SpriteType.N,
				  "O": SpriteType.O,
				  "P": SpriteType.P,
				  "Q": SpriteType.Q,
				  "R": SpriteType.R,
				  "S": SpriteType.S,
				  "T": SpriteType.T,
				  "U": SpriteType.U,
				  "V": SpriteType.V,
				  "W": SpriteType.W,
				  "X": SpriteType.X,
				  "Y": SpriteType.Y,
				  "Z": SpriteType.Z,
				  "[": SpriteType.LEFT_BRACKET,
				  "\\": SpriteType.BACK_SLASH,
				  "]": SpriteType.RIGHT_BRACKET,
				  "^": SpriteType.RAISED,
				  "_": SpriteType.UNDERSCORE,
				  "`": SpriteType.BACK_TICK,
				  "a": SpriteType.a,
				  "b": SpriteType.b,
				  "c": SpriteType.c,
				  "d": SpriteType.d,
				  "e": SpriteType.e,
				  "f": SpriteType.f,
				  "g": SpriteType.g,
				  "h": SpriteType.h,
				  "i": SpriteType.i,
				  "j": SpriteType.j,
				  "k": SpriteType.k,
				  "l": SpriteType.l,
				  "m": SpriteType.m,
				  "n": SpriteType.n,
				  "o": SpriteType.o,
				  "p": SpriteType.p,
				  "q": SpriteType.q,
				  "r": SpriteType.r,
				  "s": SpriteType.s,
				  "t": SpriteType.t,
				  "u": SpriteType.u,
				  "v": SpriteType.v,
				  "w": SpriteType.w,
				  "x": SpriteType.x,
				  "y": SpriteType.y,
				  "z": SpriteType.z,
				  "{": SpriteType.LEFT_CURLY,
				  "|": SpriteType.PIPE,
				  "}": SpriteType.RIGHT_CURLY,
				  "~": SpriteType.TILDE};

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
