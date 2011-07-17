package org.robotlegs.utilities.signals
{
    import org.osflash.signals.ISignal;
    import org.robotlegs.base.ContextError;
    import org.robotlegs.core.IInjector;

    import flash.utils.Dictionary;
    import flash.utils.describeType;
    /**
     * @author eidiot
     */
    public class SignalExecutorMap
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>SignalExecutorMap</code>.
         */
        public function SignalExecutorMap(injector:IInjector)
        {
            this.injector = injector;
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var injector:IInjector;
        private var signalMap:Dictionary = new Dictionary();
        private var signalClassMap:Dictionary = new Dictionary();
        private var verifiedCommandClasses:Dictionary = new Dictionary();
        //======================================================================
        //  Public methods
        //======================================================================
        public function mapSignal(signal:ISignal, commandClass:Class, oneShot:Boolean = false):void
        {
            verifyCommandClass(commandClass);
            if (hasSignalCommand(signal, commandClass))
                return;
            var signalCommandMap:Dictionary = signalMap[signal] = signalMap[signal] || new Dictionary(false);
            var callback:Function = function(a:* = null, b:* = null, c:* = null, d:* = null, e:* = null, f:* = null, g:* = null):void
            {
                routeSignalToCommand(signal, arguments, commandClass, oneShot);
            };

            signalCommandMap[commandClass] = callback;
            signal.add(callback);
        }
        public function mapSignalClass(signalClass:Class, commandClass:Class, oneShot:Boolean = false):ISignal
        {
            var signal:ISignal = getSignalClassInstance(signalClass);
            mapSignal(signal, commandClass, oneShot);
            return signal;
        }
        public function hasSignalCommand(signal:ISignal, commandClass:Class):Boolean
        {
            var callbacksByCommandClass:Dictionary = signalMap[signal];
            if (callbacksByCommandClass == null) return false;
            var callback:Function = callbacksByCommandClass[commandClass];
            return callback != null;
        }
        public function unmapSignal(signal:ISignal, commandClass:Class):void
        {
            var callbacksByCommandClass:Dictionary = signalMap[signal];
            if (callbacksByCommandClass == null) return;
            var callback:Function = callbacksByCommandClass[commandClass];
            if (callback == null) return;
            signal.remove(callback);
            delete callbacksByCommandClass[commandClass];
        }
        public function unmapSignalClass(signalClass:Class, commandClass:Class):void
        {
            unmapSignal(getSignalClassInstance(signalClass), commandClass);
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function getSignalClassInstance(signalClass:Class):ISignal
        {
            return ISignal(signalClassMap[signalClass]) || createSignalClassInstance(signalClass);
        }
        private function createSignalClassInstance(signalClass:Class):ISignal
        {
            var injectorForSignalInstance:IInjector = injector;
            var signal:ISignal;
            if(injector.hasMapping(IInjector))
                injectorForSignalInstance = injector.getInstance(IInjector);
            signal = injectorForSignalInstance.instantiate(signalClass);
            injectorForSignalInstance.mapValue(signalClass, signal);
            signalClassMap[signalClass] = signal;
            return signal;
        }
        private function routeSignalToCommand(signal:ISignal, valueObjects:Array, commandClass:Class, oneshot:Boolean):void
        {
            var command:Object = injector.instantiate(commandClass);
            command.execute.apply(null, valueObjects);
            if (oneshot)
            {
                unmapSignal(signal, commandClass);
            }
        }
        private function verifyCommandClass(commandClass:Class):void
        {
            if (verifiedCommandClasses[commandClass]) return;
            if (describeType(commandClass).factory.method.(@name == "execute").length() != 1)
            {
                throw new ContextError(ContextError.E_COMMANDMAP_NOIMPL + ' - ' + commandClass);
            }
            verifiedCommandClasses[commandClass] = true;
        }
    }
}