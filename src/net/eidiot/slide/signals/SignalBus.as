package net.eidiot.slide.signals
{
    import org.osflash.signals.Signal;
    /**
     * @author eidiot
     */
    public class SignalBus
    {
        public const started:Signal = new Signal(Object);
        public const previousPageRequested:Signal = new Signal();
        public const nextPageRequested:Signal = new Signal();
        public const turnToPageRequested:Signal = new Signal(int);
        public const pageChanged:Signal = new Signal(int);
    }
}