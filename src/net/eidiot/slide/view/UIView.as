package net.eidiot.slide.view
{
    import net.eidiot.slide.view.controls.TextButton;

    import xrope.AlignLayout;
    import xrope.LayoutAlign;

    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    /**
     * @author eidiot
     */
    public class UIView extends Sprite
    {
        //======================================================================
        //  Variables
        //======================================================================
        public const previousButton:Sprite = new TextButton("Previous");
        public const nextButton:Sprite = new TextButton("Next");
        public const backButton:Sprite = new TextButton("Back");
        public const pageIndexInput:TextField = createInput(30, "0");
        public const totalPageField:TextField = createLabel("/0");
        public const loading:DisplayObject = createLabel("Loading...");
        //======================================================================
        //  Public methods
        //======================================================================
        public function render(totalPages:int):void
        {
            totalPageField.text = " / " + totalPages;
            totalPageField.width = totalPageField.textWidth + 4;
            pageIndexInput.width = totalPageField.width;
            pageIndexInput.maxChars = String(totalPages).length;
            var layoutGroup:AlignLayout = new AlignLayout(this, stage.stageWidth, stage.stageHeight);
            layoutGroup.addTo(previousButton, LayoutAlign.BOTTOM);
            layoutGroup.addTo(pageIndexInput, LayoutAlign.BOTTOM);
            layoutGroup.addTo(totalPageField, LayoutAlign.BOTTOM);
            layoutGroup.addTo(nextButton, LayoutAlign.BOTTOM);
            layoutGroup.addTo(backButton, LayoutAlign.BOTTOM_RIGHT);
            layoutGroup.addTo(loading, LayoutAlign.BOTTOM_LEFT);
            layoutGroup.layout();
            //
            loading.visible = false;
        }
        public function updatePage(current:int):void
        {
            pageIndexInput.text = String(current);
        }
        public function showLoading():void
        {
            loading.visible = true;
            mouseChildren = false;
        }
        public function hideLoading():void
        {
            loading.visible = false;
            mouseChildren = true;
        }
        private function createLabel(text:String):TextField
        {
            var label:TextField = new TextField();
            label.defaultTextFormat = new TextFormat("Verdana", 12, 0xFFFFFF);
            label.text = text;
            label.width = label.textWidth + 4;
            label.height = label.textHeight + 4;
            return label;
        }
        private function createInput(width:Number, text:String = ""):TextField
        {
            var input:TextField = new TextField();
            input.defaultTextFormat = new TextFormat("Verdana", 12, 0xFFFFFF, null, null, null, null, null, TextFormatAlign.CENTER);
            input.type = TextFieldType.INPUT;
            input.border = true;
            input.borderColor = 0xEEEFF0;
            input.text = text;
            input.width = width;
            input.height = input.textHeight + 4;
            return input;
        }
    }
}