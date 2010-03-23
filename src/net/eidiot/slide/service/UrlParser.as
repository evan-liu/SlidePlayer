package net.eidiot.slide.service
{
    /**
     * @author eidiot
     */
    public class UrlParser
    {

        public function parse(path:String, file:String, start:String, end:String):Vector.<String>
        {
            var result:Vector.<String> = new Vector.<String>();
            if (!path || !file || !start || !end || file.indexOf("*") == 0)
            {
                return result;
            }
            if (path.charAt(path.length - 1) != "/")
            {
                path += "/";
            }
            //-- Pattern
            var tempList:Array = file.split("*");
            var preFile:String = tempList[0];
            var postFile:String = tempList[1];
            var fixZero:Boolean = start.charAt(0) == "0";
            //-- Loop
            var startIndex:int = int(start);
            var endIndex:int = int(end);
            if (endIndex < startIndex)
            {
                return result;
            }
            for (var i:int = startIndex;i <= endIndex;i++)
            {
                var index:String = fixZero ? fixIndex(i, start.length) : String(i);
                result.push(path + preFile + index + postFile);
            }
            return result;
        }
        private function fixIndex(index:int, length:int):String
        {
            var result:String = String(index);
            while (result.length < length)
            {
                result = "0" + result;
            }
            return result;
        }
    }
}