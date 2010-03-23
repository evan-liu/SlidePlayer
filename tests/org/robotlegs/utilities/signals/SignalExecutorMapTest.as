package org.robotlegs.utilities.signals
{
    import asunit.asserts.assertEqualsArrays;

    import org.osflash.signals.Signal;
    import org.robotlegs.adapters.SwiftSuspendersInjector;
    import org.robotlegs.core.IInjector;

    import flash.display.Sprite;
    /**
     * @author eidiot
     */
    public class SignalExecutorMapTest
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var injector:IInjector;
        private var instance:SignalExecutorMap;
        public var executeArgus:Array;
        //======================================================================
        //  Public methods
        //======================================================================
        [Before]
        public function setUp():void
        {
            injector = new SwiftSuspendersInjector();
            instance = new SignalExecutorMap(injector);
            executeArgus = null;
        }
        [Test]
        public function test():void
        {
            var signal:Signal = new Signal(int, int, String, Sprite);
            instance.mapSignal(signal, MockCommand);
            var argus:Array = [30, 50, "as3signals", new Sprite(), this];
            signal.dispatch.apply(null, argus);
            assertEqualsArrays(argus, executeArgus);
        }
    }
}

import org.robotlegs.utilities.signals.SignalExecutorMapTest;

import flash.display.Sprite;
internal class MockCommand
{
    public function execute(int1:int, int2:int, string:String, sprite:Sprite,
                            testCase:SignalExecutorMapTest):void
    {
        testCase.executeArgus = arguments;
    }
}