package net.eidiot.slide.controller
{
    import net.eidiot.slide.model.SlidePlayerModel;
    /**
     * @author eidiot
     */
    public class TurnToPageCommand
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var model:SlidePlayerModel;
        //======================================================================
        //  Public methods
        //======================================================================
        public function execute(index:int):void
        {
            if (index >= 0 && index < model.urlList.length - 1)
            {
                model.showIndex = index;
            }
        }
    }
}