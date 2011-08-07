package
{
  public interface InputReader
  {
    function mousePressed():Boolean;
    function mousePosition():Point;

    function keyPressed(keyType:int):Boolean;
    function keyHeld(keyType:int):Boolean;
  }
}
