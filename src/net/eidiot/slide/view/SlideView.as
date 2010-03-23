package net.eidiot.slide.view
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    /**
     * @author eidiot
     */
    public class SlideView extends Sprite
    {
        //======================================================================
        //  Public methods
        //======================================================================
        public function show(value:DisplayObject):void
        {
            while (numChildren > 0)
            {
                removeChildAt(0);
            }
            addChild(value);
            const MAX_WIDTH:Number = stage.stageWidth;
            const MAX_HEIGHT:Number = stage.stageHeight - 20;
            if (value.width > MAX_WIDTH)
            {
                value.width = MAX_WIDTH;
                value.scaleY = value.scaleX;
            }
            if (value.height > MAX_HEIGHT)
            {
                value.height = MAX_HEIGHT;
                value.scaleX = value.scaleY;
            }
            value.x = (MAX_WIDTH - value.width) / 2;
            value.y = (MAX_HEIGHT - value.height) / 2;
        }
    }
}