package
{
  public interface InputReader
  {
    function mousePressed():Boolean;
    function mousePosition():Point;

    function keyPressed(keyType:KeyType):Boolean;
    function keyHeld(keyType:KeyType):Boolean;
  }
}
