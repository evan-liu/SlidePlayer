package net.eidiot.slide.view
{
    import net.eidiot.slide.model.SlidePlayerModel;
    import net.eidiot.slide.service.SlideLoader;
    import net.eidiot.slide.signals.SignalBus;

    import org.robotlegs.mvcs.Mediator;

    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.ui.Keyboard;
    /**
     * @author eidiot
     */
    public class UIMediator extends Mediator
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var view:UIView;
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
            view.render(model.urlList.length);
            eventMap.mapListener(view.previousButton, MouseEvent.CLICK, previousButton_clickHandler);
            eventMap.mapListener(view.nextButton, MouseEvent.CLICK, nextButton_clickHandler);
            eventMap.mapListener(view.backButton, MouseEvent.CLICK, backButton_clickHadnler);
            eventMap.mapListener(view.pageIndexInput, MouseEvent.CLICK, pageIndexInput_clickHadnler);
            eventMap.mapListener(view.pageIndexInput, KeyboardEvent.KEY_DOWN, pageIndexInput_keyDownHandler);
            eventMap.mapListener(view.stage, KeyboardEvent.KEY_DOWN, stage_keyDownHandler);
            eventMap.mapListener(view.stage, MouseEvent.CLICK, stage_clickHandler);
            loader.completed.add(onLoadSlideCompleted);
            signalBus.pageChanged.add(onPageChanged);
            updatePage();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function updatePage():void
        {
            view.updatePage(model.showIndex + 1);
            checkButtons();
            if (!loader.hasAt(model.showIndex))
            {
                view.showLoading();
                model.locked = true;
            }
        }
        private function checkButtons():void
        {
            view.previousButton.visible = model.showIndex > 0;
            view.nextButton.visible = model.showIndex < model.urlList.length - 1;
            view.backButton.visible = model.showIndex == model.urlList.length - 1;
        }
        //======================================================================
        //  Callbacks
        //======================================================================
        private function onLoadSlideCompleted(index:int):void
        {
            if (index == model.showIndex)
            {
                view.hideLoading();
                model.locked = false;
            }
        }
        private function onPageChanged(index:int):void
        {
            updatePage();
        }
        private function verfyPageIndex(input:String):Boolean
        {
            if (isNaN(Number(input)))
            {
                return false;
            }
            var index:int = int(input) - 1;
            return index >= 0 && index < model.urlList.length - 1;
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function previousButton_clickHandler(event:MouseEvent):void
        {
            event.stopImmediatePropagation();
            signalBus.previousPageRequested.dispatch();
        }
        private function nextButton_clickHandler(event:MouseEvent):void
        {
            event.stopImmediatePropagation();
            signalBus.nextPageRequested.dispatch();
        }
        private function backButton_clickHadnler(event:MouseEvent):void
        {
            event.stopImmediatePropagation();
            signalBus.turnToPageRequested.dispatch(0);
        }
        private function pageIndexInput_clickHadnler(event:MouseEvent):void
        {
            event.stopImmediatePropagation();
        }
        private function pageIndexInput_keyDownHandler(event:KeyboardEvent):void
        {
            event.stopImmediatePropagation();
            if (event.keyCode == Keyboard.ENTER || event.keyCode == Keyboard.NUMPAD_ENTER)
            {
                if (verfyPageIndex(view.pageIndexInput.text))
                {
                    signalBus.turnToPageRequested.dispatch(int(view.pageIndexInput.text) - 1);
                }
                else
                {
                    view.pageIndexInput.text = String(model.showIndex + 1);
                }
            }
        }
        private function stage_keyDownHandler(event:KeyboardEvent):void
        {
            if (model.locked)
            {
                return;
            }
            switch (event.keyCode)
            {
                case Keyboard.ENTER:
                case Keyboard.NUMPAD_ENTER:
                case Keyboard.DOWN:
                case Keyboard.RIGHT:
                case Keyboard.SPACE:
                    signalBus.nextPageRequested.dispatch();
                    break;
                case Keyboard.UP:
                case Keyboard.LEFT:
                    signalBus.previousPageRequested.dispatch();
                    break;
                case Keyboard.HOME:
                    signalBus.turnToPageRequested.dispatch(0);
                    break;
                case Keyboard.END:
                    signalBus.turnToPageRequested.dispatch(model.urlList.length - 1);
                    break;
            }
        }
        private function stage_clickHandler(event:MouseEvent):void
        {
            if (!model.locked)
            {
                signalBus.nextPageRequested.dispatch();
            }
        }
    }
}