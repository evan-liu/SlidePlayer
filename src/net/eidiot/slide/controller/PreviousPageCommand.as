package net.eidiot.slide.controller
{
    import net.eidiot.slide.model.SlidePlayerModel;
    /**
     * @author eidiot
     */
    public class PreviousPageCommand
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var model:SlidePlayerModel;
        //======================================================================
        //  Public methods
        //======================================================================
        public function execute():void
        {
            if (model.showIndex > 0)
            {
                model.showIndex--;
            }
        }
    }
}