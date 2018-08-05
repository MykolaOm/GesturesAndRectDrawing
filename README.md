### Main info:
* App was tested on iPhone 8 plus simulator/physical device
* Buit on XCode 9.3 (latest version)
* No specific actions required to build and run

### How it's work
*  "Hello" (Lunch screen)
*  "Clear White" screen apears you can draw rects: 
   * Minimal rect size to draw 100x100
   * Tap once -> "tap shadow" appears , secont tap will create Rectangle and remove "tap shadow"
   * Tap&Drag will creare visual responding rectangle from touch to drag end
   * Shake phone to change all rectangles color at once
* Object editing :
  * Single tap on object to select and move it on top. 
  * Long tap changes object color
  * Tap and Drag on object to move it
  * Double tap removes object
  * Single tap adds/shows spots* on object 
  * Single tap remove spots if were shown
* Resise and Rotate
  * Any action that requires multitouch should be over the desired object
  * Tap on corner spots and drag to resize object
  * Change object width or Height separately
  * To resise all object use opposite corners (like top left and bottom right)
  * Top side spot allows to rotate object, second tap must be inside object
  
  
#### spot - is highlighted area to interact with object through tap on it

how it's look 
https://youtu.be/KBE_-EW6POg
