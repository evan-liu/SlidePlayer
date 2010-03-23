package net.eidiot.slide
{
    import net.eidiot.slide.controller.NextPageCommand;
    import net.eidiot.slide.controller.PreviousPageCommand;
    import net.eidiot.slide.controller.TurnToPageCommand;
    import net.eidiot.slide.model.SlidePlayerModel;
    import net.eidiot.slide.service.SlideLoader;
    import net.eidiot.slide.service.UrlParser;
    import net.eidiot.slide.signals.SignalBus;
    import net.eidiot.slide.view.SlideMediator;
    import net.eidiot.slide.view.SlideView;
    import net.eidiot.slide.view.UIMediator;
    import net.eidiot.slide.view.UIView;

    import org.robotlegs.mvcs.Context;
    import org.robotlegs.utilities.signals.SignalExecutorMap;

    import flash.display.DisplayObjectContainer;
    /**
     * @author eidiot
     */
    public class SlidePlayerContext extends Context
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function SlidePlayerContext(contextView:DisplayObjectContainer)
        {
            super(contextView);
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  signalExecutorMap
        //------------------------------
        private var _signalExecutorMap:SignalExecutorMap;
        public function get signalExecutorMap():SignalExecutorMap
        {
            return _signalExecutorMap || (_signalExecutorMap = new SignalExecutorMap(injector));
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        override public function startup():void
        {
            //-- Signals
            var signalBus:SignalBus = new SignalBus();
            injector.mapValue(SignalBus, signalBus);
            //-- Controller
            signalExecutorMap.mapSignal(signalBus.previousPageRequested, PreviousPageCommand);
            signalExecutorMap.mapSignal(signalBus.nextPageRequested, NextPageCommand);
            signalExecutorMap.mapSignal(signalBus.turnToPageRequested, TurnToPageCommand);
            //-- Service
            injector.mapSingleton(SlideLoader);
            //-- Model
            var parms:Object = contextView.stage.loaderInfo.parameters;
            var urlList:Vector.<String> = new UrlParser().parse(parms.path, parms.file,
                                                                parms.start, parms.end);
            injector.mapValue(SlidePlayerModel, new SlidePlayerModel(urlList));
            //-- View
            mediatorMap.mapView(SlideView, SlideMediator);
            mediatorMap.mapView(UIView, UIMediator);
            //-- Render
            contextView.addChild(new SlideView());
            contextView.addChild(new UIView());
        }
    }
}