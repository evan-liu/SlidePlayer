package net.eidiot.slide.service
{
    import org.osflash.signals.Signal;

    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.errors.IllegalOperationError;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.net.URLRequest;
    import flash.utils.Dictionary;
    /**
     * @author eidiot
     */
    public class SlideLoader
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var urlList:Vector.<String>;
        private var loaderByIndex:Dictionary = new Dictionary();
        private var currentLoader:Loader;
        //======================================================================
        //  Properties
        //======================================================================
        public const progressed:Signal = new Signal(ProgressEvent);
        public const completed:Signal = new Signal(int);
        public const errored:Signal = new Signal();
        //------------------------------
        //  loadingIndex
        //------------------------------
        private var _loadingIndex:int = -1;
        public function get loadingIndex():int
        {
            return _loadingIndex;
        }
        //======================================================================
        //  Public methods
        //======================================================================
        public function start(urlList:Vector.<String>, startAtIndex:int = 0):void
        {
            this.urlList = urlList;
            loadAt(startAtIndex);
        }
        public function loadAt(index:int):void
        {
            if (index < 0 || index >= urlList.length)
            {
                throw new IllegalOperationError("Invalid index " + index);
            }
            if (hasAt(index))
            {
                completed.dispatch(index);
                return;
            }
            if (currentLoader)
            {
                if (_loadingIndex == index)
                {
                    return;
                }
                removeLoadEventHandlers(currentLoader.contentLoaderInfo);
                try
                {
                    currentLoader.close();
                } catch (error:Error) {}
            }
            _loadingIndex = index;
            currentLoader = new Loader();
            addLoadEventHandlers(currentLoader.contentLoaderInfo);
            currentLoader.load(new URLRequest(urlList[_loadingIndex]));
        }
        public function hasAt(index:int):Boolean
        {
            return loaderByIndex[index] != null;
        }
        public function getAt(index:int):Loader
        {
            return loaderByIndex[index];
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function loadNext():void
        {
            if (loadingIndex < urlList.length - 1)
            {
                loadAt(loadingIndex + 1);
            }
        }
        private function addLoadEventHandlers(loaderInfo:LoaderInfo):void
        {
            loaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            loaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }
        private function removeLoadEventHandlers(loaderInfo:LoaderInfo):void
        {
            loaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            loaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function progressHandler(event:ProgressEvent):void
        {
            progressed.dispatch(event);
        }
        private function completeHandler(event:Event):void
        {
            removeLoadEventHandlers(currentLoader.contentLoaderInfo);
            loaderByIndex[_loadingIndex] = currentLoader;
            completed.dispatch(_loadingIndex);
            loadNext();
        }
        private function ioErrorHandler(event:IOErrorEvent):void
        {
            removeLoadEventHandlers(currentLoader.contentLoaderInfo);
            errored.dispatch();
        }
    }
}