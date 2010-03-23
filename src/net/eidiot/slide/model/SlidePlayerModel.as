package net.eidiot.slide.model
{
    import net.eidiot.slide.signals.SignalBus;
    /**
     * @author eidiot
     */
    public class SlidePlayerModel
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>Model</code>.
         */
        public function SlidePlayerModel(urlList:Vector.<String>)
        {
            _urlList = urlList;
        }
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var signalBus:SignalBus;
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  locked
        //------------------------------
        private var _locked:Boolean = false;
        public function get locked():Boolean
        {
            return _locked;
        }
        public function set locked(value:Boolean):void
        {
            _locked = value;
        }
        //------------------------------
        //  urlList
        //------------------------------
        private var _urlList:Vector.<String> = new Vector.<String>();
        public function get urlList():Vector.<String>
        {
            return _urlList.concat();
        }
        //------------------------------
        //  showIndex
        //------------------------------
        private var _showIndex:int = -1;
        public function get showIndex():int
        {
            return _showIndex;
        }
        public function set showIndex(value:int):void
        {
            if (!_locked && value != _showIndex)
            {
                _showIndex = value;
                signalBus.pageChanged.dispatch(value);
            }
        }
    }
}