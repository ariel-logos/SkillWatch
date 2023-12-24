# SkillWatch

### What is it?
Skillwatch is an add-on for FFXI's third-party loader and hook Ashita (https://www.ashitaxi.com/).
Very simply, the purpose of this add-on is to have a clearer way to identify the moment when enemy mobs "ready" a skill.
This could be useful in a variety of situations, for example, when people are playing with relevant ping issues or the time window to react to such event is in general too short.

### What is not?
This add-on is <b>NOT</b> a bot. It simply provides enhanced feedback on enemy mobs readying their skills with the same timing the typical "X readies Y." message would appear in the chat box.

### How does it work?
In short, it's a combination of parsing the chat box looking for a message, matching it with Entity informations provided by Ashita hook and drawing some visual feedback overlay.

<p align="center">
<a href="https://github.com/ariel-logos/SkillWatch/assets/78350872/87152b44-fa5b-4aa3-8e86-092cfe09fa2c"><img src="https://github.com/ariel-logos/SkillWatch/assets/78350872/87152b44-fa5b-4aa3-8e86-092cfe09fa2c.gif" alt="SkillWatch Overlay"/></a>  
</p>

### Installation
Go over the Releases page, download the latest version and unpack it in the add-on folder in your Ashita installation folder. You should now have among the other add-on folders the "skillwatch" one!

### Functionalities

#### Commands
```/addon load skillwatch``` Loads the add-on in Ashita.

```/addon unload skillwatch``` Unloads the add-on from Ashita.

```/skillwatch``` Shows/hides the config UI.

<br></br>
#### Filters tab
This tab allows you to select which skill you want to have the "blinking" alert effect to better highlight those relevant for you.\
You can obviously select multiple skills on which to apply the blinking effect.\
Everything set here is saved in the preferences.
<ol>
  <li><b>Search:</b> textbox that you can use to quickly look up mobs' skills in the Skills list (Fig.2).</li>
  <li><b>Skills:</b> list of mobs' skills, select the one you want to filter to add the blinking effect.</li>
  <li><b>Enable:</b> after selecting a skill you can use this toggle checkbox to enable or disable the blinking effect for that skill.</li>
  <li><b>Show Enabled only:</b> toggle checkbox to quickly show in the Skills list only the skill for which the blinking effect is enabled.</li>
  <li><b>Disable All:</b> button to quickly remove the check mark from the Enabled checkbox from ALL the skills effectively resetting the list.</li>
  <li><b>Custom Filter:</b> textbox to quickly add custom text to match against the name of the skills used by mobs (Fig.3) (e.g. Writing "Toss" and enabling the checkbox will add the blinking effect on all the skills containing the word Toss). This text is case sensitive!!!</li>
</ol>

![1](https://github.com/ariel-logos/SkillWatch/assets/78350872/3d8a14e9-b8dd-4227-99ba-6369b511ba29)|![2](https://github.com/ariel-logos/SkillWatch/assets/78350872/19ce8c78-9851-4424-8e82-8aea4f1c43cd)|![3](https://github.com/ariel-logos/SkillWatch/assets/78350872/31aee711-072d-400a-a867-e8180ccfdd5a)
:-------------------------|-------------------------|-------------------------
Fig. 1          |  Fig. 2           | Fig. 3 

<br>
#### Settings tab
In this tab you can adjust several add-on settings, in particular:
<ol>
  <li><b>Size:</b> sets the size of the overlay.</li>
  <li><b>BG Transparency:</b> sets the alpha channel of the background box.</li>
  <li><b>Blinking RGB:</b> using the 3 sliders R,G,B below, sets the color of the blinking effect.</li>
  <li><b>Blinking Speed:</b> sets the rate at which the text background to notify incoming skills set in the Filters tab.</li>
  <li><b>Only trigger on filtered skills:</b> the overlay will only appear when one of the selected skills in the Filters tab is being used by the enemy mob.</li>
  <li><b>Right justified:</b> the text and background box will resize expanding towards the left (default: right).</li>
  <li><b>Ignore non-custom filter:</b> the overlay will only appear when the text in the Custom Filter textbox set Filters tab is recognized. Ignores other selected filter from the Skills list.</li>
  <li><b>Hide timer bar:</b> hides the bar appearing at the bottom of the text showing the time since the skill detection.</li>
</ol>
