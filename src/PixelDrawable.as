package
{
    public interface PixelDrawable extends Drawable
    {
	function setPixel(x:int, y:int, color:int):void;
	function getPixel(x:int, y:int):int;
    }
}
