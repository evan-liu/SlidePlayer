package
{
    import asunit4.ui.TextRunnerUI;

    [SWF(width="1024", height="768", backgroundColor="0xFFFFFF", frameRate="30")]
    /**
     * @author eidiot
     */
    public class SlidePlayerTestRunner extends TextRunnerUI
    {
        public function SlidePlayerTestRunner()
        {
            super();
            run(AllTests);
        }
    }
}
