package net.eidiot.slide.view
{
    import net.eidiot.slide.model.SlidePlayerModel;
    import net.eidiot.slide.service.SlideLoader;
    import net.eidiot.slide.signals.SignalBus;

    import org.robotlegs.mvcs.Mediator;
    /**
     * @author eidiot
     */
    public class SlideMediator extends Mediator
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var view:SlideView;
        [Inject]
        public var model:SlidePlayerModel;
        [Inject]
        public var loader:SlideLoader;
        [Inject]
        public var signalBus:SignalBus;
        //======================================================================
        //  Overridden methods
        //======================================================================
        override public function onRegister():void
        {
            if (model.urlList.length == 0)
            {
                return;
            }
            signalBus.pageChanged.add(onPageChanged);
            loader.completed.add(onLoadSlideCompleted);
            loader.start(model.urlList);
            model.showIndex = 0;
        }
        //======================================================================
        //  Callbacks
        //======================================================================
        private function onPageChanged(index:int):void
        {
            loader.loadAt(index);
        }
        private function onLoadSlideCompleted(index:int):void
        {
            if (index == model.showIndex)
            {
                view.show(loader.getAt(index));
            }
        }
    }
}