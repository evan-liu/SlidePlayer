package net.eidiot.slide.controller
{
	import net.eidiot.slide.model.SlidePlayerModel;
    
    /**
     * @author eidiot
     */
    public class NextPageCommand
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
            if (model.showIndex < model.urlList.length - 1)
            {
                model.showIndex++;
            }
        }
    }
}