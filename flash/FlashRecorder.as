package {
  import flash.display.*;
  import flash.media.*;
  import flash.external.ExternalInterface;
  import flash.events.*;

  public class FlashRecorder extends Sprite {
    private var theStage:Stage;

    private function showingPanel():Boolean
    {
      var showing:Boolean = false;
      var dummy:BitmapData;
      dummy = new BitmapData(1,1);
      
      try
      {
        // Try to capture the stage: triggers a Security error when the settings dialog box is open 
        // Unfortunately, this is how we have to poll the settings dialogue to know when it closes
        dummy.draw(theStage);
      }
      catch (error:Error)
      {
        showing = true;
      }
      
      dummy.dispose();
      dummy = null;
      
      return showing;
    }

    public function FlashRecorder() {
      this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
      

      var logger:Logger;
      logger = new Logger();
      ExternalInterface.addCallback("debugLog", logger.debugLog);
      ExternalInterface.addCallback("showingPanel", showingPanel);

      var recorder = new Recorder(logger);
      recorder.addExternalInterfaceCallbacks();
    }

    private function onAddedToStage(e:Event):void {
        this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        theStage = this.stage;
    }

  }
}