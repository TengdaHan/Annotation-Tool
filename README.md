# Annotation-Tool

## Introduction
* Annotation tool for object-centric activity recognition
* It is written in MATLAB

## Functions
  1. Crop image from current screen.
    * Store cropped image in a folder, and store other information in a dataset using MATLAB struct
  2. Load image to make annotation.
  3. Load video to make annotation.
    * Temporal annotation for activities, starting frame index, ending frame index, etc.
  4. Annotate object name, affordance, URL, etc.
  5. Annotate position of object and human pose by drawing bonding boxes.
  6. Store image/video path when needed.

## Acknowledgement
* It is the R&D project of Mike @ ANU

## Notes
  1. first line of annotation.config is for screenshot mode, it determines the path to save the screenshot image.
  2. Second line of annotation.config is a folder name for video mode. 

## Instruction
  1. Image mode.
    * Click 'Load' - 'Load Image'.
    * Choose image and make annotations. 
    * Annotations includes: 
      object box, posture box - they are draggable rectangle.
      position of wrist, elbow, shoulder, head - they are draggable point.
    * For object box, right click on the box - properties, you can input object name and other information.
    * Click 'Save&Next' if you want to save the annotation.
  2. Folder mode.
    * Click 'Load' - 'Load folder'.
    * Choose the folder which only contains images.
    * Annotate image as same as Image mode.
    * Clike 'Save&Next', you can save current annotation and load next image in the folder. Or, click 'Skip&Next' if you don't want to save current annotation.
  3. View annotation.
    * Click 'View' - 'View Annotation'.
    * Choose the image file which has been annotated.
    * The annotation will be displayed.
  4. Video mode.
    * Click 'Load' - 'Load Video'.
    * Choose the video and its first frame will be displayed.
    * You can adjust the slider bar to watch the video. Click on left/right arrow will go backward/forward 1 frame. Click on slider bar will go 30 frames. Hold right arrow will play the video slowly.
    * When activity starts, click 'Start' on the most right panel. Toggle button 'Start' will become 'Stop'.
    * Adjust the slider bar, when activity ends, click 'Stop' (the same button as 'Start'). Pop-up window will appear.
    * Type activity name in the pop-up window, and click 'OK'
    * Information window will appear, click 'OK'
    * If you want to save this activity annotation, click 'Save' on the most right panel. If you want to discard this activity annotation, just move on to do the next activity without click 'Save'.  
    
## Compatibility
  1. When run the tool in Matlab in ubuntu (tested on ubuntu16/14), Error about the function 'VideoReader()' will be reported. It is because in Linux Matlab, the VideoReader function requites the plugin 'gstreamer0.10'. However ubuntu 16 installed gstreamer as default. 
    * Solution: Installed gstreamer0.10-tools and gstreamer0.10-plugins-good, and then restart Matlab. 
    * Useful links: [Mathworks Answers](http://au.mathworks.com/matlabcentral/answers/144391-trouble-with-videoreader-on-mac-or-with-different-matlab-versions), [Mathworks Bug Reports](http://www.mathworks.com/support/bugreports/1246784).
