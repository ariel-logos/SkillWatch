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
#### Filters tab
This tab allow you to select which skill you want to have the "blinking" alert effect so that you can properly react only to those important for you.
<ol>
  <li><b>Search:</b> textbox that you can use to quickly look up mobs' skills in the Skills list.</li>
  <li><b>Skills:</b> list of mobs' skills, select the one you want to filter to add the blinking effect.</li>
  <li><b>Enable:</b> after selecting a skill you can use this toggle checkbox to enable or disable the blinking effect for that skill.</li>
  <li><b>Show Enabled only:</b> toggle checkbox to quickly show in the Skills list only the skill for which the blinking effect is enabled.</li>
  <li><b>Disable All:</b> button to quickly remove the check mark from the Enabled checkbox from ALL the skills effectively resetting the list.</li>
  <li><b>Custom Filter:</b> textbox to quickly add custom text to match against the skills used by mobs (e.g. Writing "Toss" and enabling the checkbox will add the blinking effect on all the skills containing the word Toss). This text is case sensitive!!!</li>
</ol>

<span align="center">
  <img src="https://i.gyazo.com/3c6ac95e0b390138775c4ee70d748da1.png" alt="FiltersTab1"/>
  <img src="https://i.gyazo.com/e913cc1beee26aa66840d6507c59b350.png" alt="FiltersTab2"/>
  <img src="https://i.gyazo.com/7e600df857d0c2df3e010002ffd6aa2c.png" alt="FiltersTab3"/>
</span>


