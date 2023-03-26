# MovieStarPlanet-Flash-Color-Picker-Extension #
SWC file to create Color Pickers easily for MovieStarPlanet clothes & items

## What you need ##
<ul>
<li> <b>Recommended:</b> Adobe Animate/Flash Professional</li>
or
<li> Adobe Flash Builder (Only if you're advanced in ActionScript 3.0)</li>
</ul>

## Syntax ##
<code>ColorPickerInstance(stage:Stage, colorSwatch:MovieClip, clothItem:MovieClip, scale:Number, defaultColors:*)</code><br>
!! <code>defaultColors</code> has to be of type <i>string</i> or <i>object</i> (more info in "Advanced usage")
## How to use ##
<ol>
<li>Download <i>MSPColorPickerInstance.swc</i> and <i>asset_ColorPickerSwatch.fla</i></li>
<li>Open Adobe Animate and create a new "Standard" file from "Character Animation"</li>
<li>Add the SWC file to Adobe Animate by clicking "More settings" -> "ActionScript Settings" -> Library path -> Browse to SWC file -> OK
  
  ![Step 1](https://user-images.githubusercontent.com/117317661/227786937-5211ed30-8208-43ae-8c3e-b5ff3ccd2262.jpg)
  ![Step 2](https://user-images.githubusercontent.com/117317661/227787115-343d55c5-2f50-4222-b177-f9e082b8383b.jpg)
  ![Step 3](https://user-images.githubusercontent.com/117317661/227787213-13ee4964-4654-4387-9671-b2dc94e609a5.jpg)
  </li>
  <li>Open <i>asset_ColorPickerSwatch.fla</i></li>
  <ul>
    <li>Copy the MovieClip (the red circle) and paste it into the file you created before</li>
  </ul>
  <li>Also past a MovieStarPlanet cloth item into the same file (if the cloth item consist of more than one MovieClip, hit F8 to convert it into one MovieClip)</li>
  <li>Give the MovieClip of the cloth item and of the red circle an "Instance Name", for example "_item" and "_circle"
  
  ![Giving an "Instance Name"](https://user-images.githubusercontent.com/117317661/227787592-bfb5721b-363c-4cae-a9a4-ac689ae09e84.jpg)
    </li>
  <li>Press F9 to open the "Actions"-panel for ActionScript 3</li>
  <li>Enter the following code:<br><code>var cpi:ColorPickerInstance = new ColorPickerInstance(stage, _circle, _item, 0.7, "0x1B1717,0xE6F4FC,0xFDA1BA");</code></li>
  <li>Press CTRL+ENTER to run the Flash file</li>
  <li>If you followed the instruction, you're good to go now!</li>
</ol>

## Advanced usage ##
### <code>defaultColors</code> parameter ###
param4 <code>defaultColors*</code> can be of type <i>string</i> or <i>object</i>.<br>It is recommended to use the <code>colorscheme</code>-object provided by the MovieStarPlanet cloth file. It is also possible to use a <i>string</i> like "0x000000,0xFFFFFF0xFF0000", but in some special cases (f there are deviations from the normal stringency of naming MovieClip instances as color used by MSP) the color won't change (in 95% of all cases using a <i>string</i> will work).

### Using another ColorPickerSwatch ###
If you don't like the design of the color picker swatch (the red circle from <i>asset_ColorPickerSwatch.fla</i>), you can create your own one. However, you have to follow some rules to make your own one compatible with the color picker:
<ul>
  <li>All shapes must be type of <i>MovieClip</i></li>
  
  ![Graph](https://user-images.githubusercontent.com/117317661/227789377-737cc5a6-5746-40ae-b30c-4f035554a0fe.png)
</ul>
