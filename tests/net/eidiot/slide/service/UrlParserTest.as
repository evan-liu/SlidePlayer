package net.eidiot.slide.service
{
    import asunit.asserts.assertEquals;
    /**
     * @author eidiot
     */
    public class UrlParserTest
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var instance:UrlParser;
        //======================================================================
        //  Public methods
        //======================================================================
        [Before]
        public function setUp():void
        {
            instance = new UrlParser();
        }
        [After]
        public function tearDown():void
        {
            instance = null;
        }
        [Test]
        public function test_parse_normal():void
        {
            var path:String = "http://eidiot.net/test/";
            var file:String = "test*.jpg";
            var start:String = "1";
            var end:String = "51";
            var result:Vector.<String> = instance.parse(path, file, start, end);
            assertEquals(51, result.length);
            assertEquals(path + "test1.jpg", result[0]);
            assertEquals(path + "test51.jpg", result[50]);
        }
        [Test]
        public function test_parse_fill_zero():void
        {
            var path:String = "http://eidiot.net/test/";
            var file:String = "test*.jpg";
            var start:String = "001";
            var end:String = "051";
            var result:Vector.<String> = instance.parse(path, file, start, end);
            assertEquals(51, result.length);
            assertEquals(path + "test001.jpg", result[0]);
            assertEquals(path + "test051.jpg", result[50]);
        }
    }
}