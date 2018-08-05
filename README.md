### Main info:
* App was tested on iPhone 8 plus simulator/physical device
* Buit on XCode 9.4 (latest version)
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
  * Single tap adds/shows spots* outside object 
  * Single tap remove spots if were shown
* Resise and Rotate
  * Any action that requires multitouch should be over the desired object
  * Tap on two corners spots and drag to resize object
  * Tap on single corner spot to resize object by scaling it in both width and height
  * Object width and height change simultaniusly
  * Top side spot allows to rotate object, tap on Rectangle then tap on rotating spot("top spot")
  
  
#### spot - is highlighted area to interact with object through tap on it
how it's look 
https://youtu.be/NkQczwdSLTY
