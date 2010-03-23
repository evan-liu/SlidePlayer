package net.eidiot.slide.view.controls
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    /**
     * @author eidiot
     */
    public class TextButton extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function TextButton(text:String)
        {
            super();
            var field:TextField = new TextField();
            field.defaultTextFormat = new TextFormat("Verdana", 12, 0xFFFFFF);
            field.text = text;
            field.width = field.textWidth + 4;
            field.height = field.textHeight + 4;
            addChild(field);
            buttonMode = true;
            mouseChildren = false;
        }
    }
}