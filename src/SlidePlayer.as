package
{
    import net.eidiot.slide.SlidePlayerContext;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    [SWF(width="550", height="400", backgroundColor="0x000000", frameRate="30")]
    /**
     * @author eidiot
     */
    public class SlidePlayer extends Sprite
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var context:SlidePlayerContext;
        //======================================================================
        //  Constructor
        //======================================================================
        public function SlidePlayer()
        {
            super();
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            context = new SlidePlayerContext(this);
        }
    }
}