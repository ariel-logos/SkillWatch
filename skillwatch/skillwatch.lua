addon.name      = 'skillwatch';
addon.author    = 'Arielfy';
addon.version   = '0.2';
addon.desc      = 'Addon to display abilities being readied by mobs';
addon.link      = '';


require('common');
local imgui = require('imgui');
local fonts = require('fonts');
local settings  = require('settings');
local ffi = require('ffi');
local prims = require('primitives');

local default_filterSettings = T{abilityFilters,};
local default_settings = T{
    font = T{
        visible = true,
        font_family = 'Consolas',
		bold = true,
        font_height = 12,
		draw_flags = 0x10,
        color = 0xFFFFFFFF,
        position_x = 100,
        position_y = 100,
		padding    = 0,
		color_outline = 0xFF000000,
        background = T{
            visible = true,
            color = 0x88000000,
			border_visible  = true,
			border_color    = 0xFFFFFFFF,
			border_flags    = 0x10,
			border_sizes    = '0,0,0,0',
			scale_x         = 1.0,
			scale_y         = 1.0,
			width           = 0.0,
			height          = 0.0,
			texture_offset_x= 0.0,
			texture_offset_y= 0.0,
        },
    },
    barWidth = 400,
	blinkingSpeed = T{1},
	blinkR = T{0},
	blinkG = T{0},
	blinkB = T{0},
	transparency = T{0.5},
	size = T{1},
	showOnlyEnabled = T{false},
	showOnlyBlink = T{false},
	justifyRight = T{false},
	customFilter = T{},
	customFilterEnabled = T{false},
	skipNotCustom = T{false},
	hideSkillBar = T{false}
};

overlay = {

font;

targetName = '',
targetEntity = nil,
readiesText = '',
debugText = '',
usesText = '',
abilityText = 'Adjust Mode',
isAbilityUsed = true,

timerRunning = false,
startTime = 0,
timer = 0,
maxTime = 3.0,

colorTime = 0,

settings,
filterSettings,
settingsModeEnabled = true,
debugModeEnabled = false,
blinkDir = 1,
lastClock = 0,
isSettingsOpen = T{false},
abilitySelected = T{-1},
enabledAbilities = T{},
search = T{},
skillBar,
test

}

skillBarInit = {
        visible = false,
        color = 0xFFFFFFFF,
        can_focus = false,
        locked = true,
        width = 200,
        height = 50,
        position_x = 0,
        position_y = 0,
    }

local function save_settings()
    settings.save('general_settings');
end

local function save_filter_settings()
	settings.save('filter_settings');
end


settings.register('general_settings', 'general_settings_update', function(s)
    if s ~= nil then overlay.settings = s end
    settings.save('general_settings');
end)

settings.register('filter_settings', 'filter_settings_update', function(s)
    if s ~= nil then overlay.filterSettings = s end
    settings.save('general_settings');
end)

ashita.events.register('d3d_present', 'present_cb', function()
	if (overlay.targetEntity ~= nil) then
		overlay.targetName = overlay.targetEntity.Name;
	end
	
	if (overlay.font.position_x ~= overlay.settings.font.position_x or
		overlay.font.position_y ~= overlay.settings.font.position_y )
	then
		overlay.settings.font.position_x = overlay.font.position_x;
		overlay.settings.font.position_y = overlay.font.position_y;
		save_settings();
	end
	
	overlay.font.right_justified = overlay.settings.justifyRight[1];
	overlay.font:SetText('');
	UpdateTimer();

	local playerTarget = AshitaCore:GetMemoryManager():GetTarget();
	local targetIndex;
	if (playerTarget ~= nil) then
		local targetIndex = playerTarget:GetTargetIndex(0);
		overlay.targetEntity = GetEntity(targetIndex);
	end
    
	--SETTINGS WINDOW  
	if (overlay.isSettingsOpen[1]) then
		imgui.SetNextWindowSize({ 350, 480, });
		imgui.SetNextWindowSizeConstraints({ 350, 480, }, { FLT_MAX, FLT_MAX, });
		imgui.Begin('SkillWatch', overlay.isSettingsOpen, ImGuiWindowFlags_NoResize);
		if (imgui.BeginTabBar('##skillwatch_tabbar', ImGuiTabBarFlags_NoCloseWithMiddleMouseButton)) then
			--FILTERS TAB
			if (imgui.BeginTabItem('Filters', nil)) then
				imgui.InputText('Search', overlay.search, 255)
				imgui.BeginGroup();
				imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, 'Skills');
				
				imgui.BeginChild('leftpane', { 250,250, }, true);
				local aIdx = 1;
				local enabledList = T{};
				overlay.abilities:each(function(v,k)
					--imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, v[1])
					if (v[2]) then
						table.insert(enabledList, v);
						--enabledList:append(v[1]);
					end
					local searchEnabled = false;
					local searchFound, _ = string.find(string.lower(v[1]), string.lower(overlay.search[1]));
					if (overlay.search ~= nil and overlay.search[1]~='') then searchEnabled = true; end
					if (not overlay.settings.showOnlyEnabled[1] or v[2]) then
						if(not searchEnabled or searchFound) then
							if(imgui.Selectable(v[1], overlay.abilitySelected[1] == aIdx)) then
								overlay.abilitySelected[1] = aIdx;
							end
						end
					end
					aIdx = aIdx+1;
				end);
				overlay.enabledAbilities = enabledList;
				imgui.EndChild();
				imgui.EndGroup();
				
				imgui.SameLine();
				
				imgui.BeginGroup();
				imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, 'Enable');
				imgui.BeginChild('righttpane', { 75,250, }, true);
				if(overlay.abilitySelected[1]> -1) then
					if (imgui.Checkbox('',{overlay.abilities[overlay.abilitySelected[1]][2]})) then 
					overlay.abilities[overlay.abilitySelected[1]][2] = not overlay.abilities[overlay.abilitySelected[1]][2];
					overlay.filterSettings.abilityFilters = overlay.abilities;
					save_filter_settings();
					end
				end
				imgui.EndChild();
				imgui.EndGroup();
				--imgui.BeginGroup();
				if (imgui.Checkbox('Show Enabled only',{overlay.settings.showOnlyEnabled[1]})) then 
					overlay.settings.showOnlyEnabled[1] = not overlay.settings.showOnlyEnabled[1];
					save_settings();
				end
				--imgui.SameLine();
				imgui.PushStyleVar(ImGuiStyleVar_ItemSpacing, {0, 10});
				if (imgui.Button('Disable All')) then
					overlay.abilities:each(function(v,k)
						v[2] = false;
					end);
					overlay.enabledAbilities = T{};
				end
				
				imgui.PopStyleVar(1);
				imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, 'Custom Filter');
				
				if(imgui.InputText('\13', overlay.settings.customFilter, 128))then
					save_settings();
				end
				imgui.SameLine();
				if (imgui.Checkbox('Enabled',{overlay.settings.customFilterEnabled[1]})) then 
					overlay.settings.customFilterEnabled[1] = not overlay.settings.customFilterEnabled[1];
					save_settings();
				end
				
				imgui.EndTabItem();
			end
			--SETTINGS TAB
			if (imgui.BeginTabItem('Settings', nil)) then
				imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, 'Size');
				imgui.PushStyleVar(ImGuiStyleVar_ItemSpacing, {0, 10});
				local S = {tonumber(overlay.settings.size[1])};
				if (imgui.SliderFloat(' ', S, 0.1, 3, '%0.1f')) then
					overlay.settings.size = S;
					save_settings();
					overlay.settings.font.font_height = math.floor(11*(overlay.settings.size[1]))+1;
					overlay.font.font_height = math.floor(11*(overlay.settings.size[1]))+1;
					overlay.font.padding = overlay.font.font_height/2;
				end
				imgui.PopStyleVar(1);
				imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, 'BG Transparency');
				imgui.PushStyleVar(ImGuiStyleVar_ItemSpacing, {0, 10});
				local T = {tonumber(overlay.settings.transparency[1])};
				if (imgui.SliderFloat('  ', T, 0, 1, '%0.1f')) then
					overlay.settings.transparency = T;
					save_settings();
				end
				imgui.PopStyleVar(1);
				imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, 'Blinking RGB');
				local R = {tonumber(overlay.settings.blinkR[1])};
				if (imgui.SliderFloat('R', R, 0, 255, '%1.0f')) then
					overlay.settings.blinkR = R;
					save_settings();
				end
				
				local G = {tonumber(overlay.settings.blinkG[1])};
				if (imgui.SliderFloat('G', G, 0, 255, '%1.0f')) then
					overlay.settings.blinkG = G;
					save_settings();
				end
				imgui.PushStyleVar(ImGuiStyleVar_ItemSpacing, {0, 10});
				local B = {tonumber(overlay.settings.blinkB[1])};
				if (imgui.SliderFloat('B', B, 0, 255, '%1.0f')) then
					overlay.settings.blinkB = B;
					save_settings();
				end
				imgui.PopStyleVar(1);
				imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, 'Blinking Speed');
				
				
				imgui.PushStyleVar(ImGuiStyleVar_ItemSpacing, {0, 10});
				local bSpeed = {tonumber(overlay.settings.blinkingSpeed[1])};
				if (imgui.SliderFloat('   ', bSpeed, 0, 10, '%0.1f')) then
					overlay.settings.blinkingSpeed = bSpeed;
					save_settings();
				end
				imgui.PopStyleVar(1);
				imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, 'Other Options');
				if (imgui.Checkbox('Only trigger on filtered skills',{overlay.settings.showOnlyBlink[1]})) then 
					overlay.settings.showOnlyBlink[1] = not overlay.settings.showOnlyBlink[1];
					save_settings();
				end
				
				if (imgui.Checkbox('Right justified',{overlay.settings.justifyRight[1]})) then 
					overlay.settings.justifyRight[1] = not overlay.settings.justifyRight[1];
					save_settings();
				end
				if (imgui.Checkbox('Ignore non-custom filters',{overlay.settings.skipNotCustom[1]})) then 
					overlay.settings.skipNotCustom[1] = not overlay.settings.skipNotCustom[1];
					save_settings();
				end
				if (imgui.Checkbox('Hide timer bar',{overlay.settings.hideSkillBar[1]})) then 
					overlay.settings.hideSkillBar[1] = not overlay.settings.hideSkillBar[1];
					save_settings();
				end
				
				imgui.EndTabItem();
			end
		end
		--DEBUG TAB
		if (overlay.debugModeEnabled and imgui.BeginTabItem('Debug', nil)) then
			if (overlay.targetEntity ~= nil) then
				imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, overlay.targetName);
			end
			imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, overlay.readiesText);
			imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, overlay.usesText);
			imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, overlay.debugText);
			imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, overlay.abilityText);
			imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, tostring(overlay.isAbilityUsed));
			imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, tostring(overlay.timer));
			--imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, overlay.settings.customFilter[1]);
			--imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, tostring(overlay.font.background.position_x));
			overlay.font.bold = true;
			overlay.font.font_family = 'Franklin Gothic';
			imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, tostring(overlay.font.font_family));
			
			imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, tostring(overlay.test));
			
			if(overlay.targetEntity ~= nil) then imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, tostring(bit.band(overlay.targetEntity.SpawnFlags, 0x10))); end
			overlay.enabledAbilities:each(function(v,k)
				--imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, overlay.abilities[tonumber(v[1])][1]);
				imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 },v[1]);
			end);
			imgui.EndTabItem();
		end
		
        imgui.EndTabBar();
    end
	
	
	
    imgui.End();
	
	--OVERLAY RENDERING
	imgui.SetNextWindowSize({ overlay.settings.barWidth, -1, }, ImGuiCond_Always);
	local windowFlags = bit.bor(ImGuiWindowFlags_NoDecoration, ImGuiWindowFlags_AlwaysAutoResize, ImGuiWindowFlags_NoFocusOnAppearing, ImGuiWindowFlags_NoNav, ImGuiWindowFlags_NoBackground, ImGuiWindowFlags_NoBringToFrontOnFocus);
	
	if (imgui.Begin('SkillWatchOL', true, windowFlags)) then
		overlay.font.background.border_visible = true;
		overlay.font.background.border_color = 0xFFFFFFFF;
		local blinking = false;
		if (overlay.isSettingsOpen[1]) then blinking = true; end
		if (overlay.enabledAbilities ~= nil and not overlay.settings.skipNotCustom[1]) then 
			overlay.enabledAbilities:each(function(v,k)
				--imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, overlay.abilities[tonumber(v[1])][1]);
					if(overlay.abilityText~='') then
						local vFind,_ = string.find(v[1], overlay.abilityText);
						if(vFind) then
							blinking = true;
						end
					end
			end);
		end
		if (overlay.settings.customFilterEnabled[1] and overlay.settings.customFilter[1] ~= '') then
			if(overlay.abilityText~='') then
				local cFind,_ = string.find(overlay.settings.customFilter[1], overlay.abilityText);
				if(cFind) then
					blinking = true;
				end
			end
		end
		local time2color;
		if(blinking) then
			local time2colorR = (os.clock()*overlay.settings.blinkingSpeed[1]%1)*math.floor(tonumber(overlay.settings.blinkR[1]));
			local time2colorG = (os.clock()*overlay.settings.blinkingSpeed[1]%1)*math.floor(tonumber(overlay.settings.blinkG[1]));
			local time2colorB = (os.clock()*overlay.settings.blinkingSpeed[1]%1)*math.floor(tonumber(overlay.settings.blinkB[1]));
			if (os.clock()*overlay.settings.blinkingSpeed[1]%1 < 0.1 and overlay.lastClock > 0.9 ) then 
				overlay.blinkDir = overlay.blinkDir*-1;
			end
			overlay.lastClock = os.clock()*overlay.settings.blinkingSpeed[1]%1;
			if (overlay.blinkDir == 1) then
				time2color = bit.lshift(bit.tobit(time2colorR),16) + bit.lshift(bit.tobit(time2colorG),8) + bit.tobit(time2colorB)+	0x88000000;
			else
				time2color = bit.lshift(bit.tobit(math.floor(tonumber(overlay.settings.blinkR[1]))-time2colorR),16) +
								bit.lshift(bit.tobit(math.floor(tonumber(overlay.settings.blinkG[1]))-time2colorG),8) +
								bit.tobit(math.floor(math.floor(tonumber(overlay.settings.blinkB[1]))-time2colorB))+
								bit.lshift(bit.tobit(overlay.settings.transparency[1]*255),24);
			end
		else
			time2color = bit.lshift(bit.tobit(overlay.settings.transparency[1]*255),24);
		end
		
		--imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, tostring(bit.tohex(time2color)));
		overlay.font.background.color = time2color;
		
		
		
		if (overlay.isAbilityUsed) then
			overlay.font:SetVisible(false);
			overlay.skillBar.visible = false;
			if (overlay.isSettingsOpen[1]) then overlay.font:SetVisible(true); end
			overlay.font:SetText(' '..'Adjust Mode'..' ');
			UpdateSkillBar(false);
			--overlay.font:SetText(' '..overlay.abilityText..' ');
		else
			if (not overlay.settings.showOnlyBlink[1] or blinking) then
				overlay.font:SetText(' '..overlay.abilityText..' ');
				overlay.font:SetVisible(true);
				UpdateSkillBar(true);
			end
		end
		
		
		
		imgui.End();
		--local barColor = imgui.GetColorU32({1,1,1,1});
		--imgui.GetWindowDrawList():AddRectFilled(imgui.GetCursorScreenPos(), imgui.ImVec2(200,200), barColor, false, ImDrawCornerFlags_None);
	end
	
end);

function UpdateSkillBar(isVisible)
	if (isVisible and not overlay.settings.hideSkillBar[1])then
		overlay.skillBar.visible = true;
	else
		overlay.skillBar.visible = false;
	end
	local timepassed = overlay.timer;
	local size = SIZE.new();
	overlay.font:GetTextSize(size);
	overlay.test = size.cx;
	local width_max = size.cx+overlay.font.padding*2;
	overlay.skillBar.width = (timepassed/overlay.maxTime)*width_max;
	overlay.skillBar.height = size.cy/10;
		if(not overlay.settings.justifyRight[1]) then
			overlay.skillBar.position_x = overlay.font.position_x-overlay.font.padding;
		else
			
			overlay.skillBar.width = -overlay.skillBar.width;
			overlay.skillBar.position_x = overlay.font.position_x+overlay.font.padding-(((overlay.maxTime-timepassed)/overlay.maxTime)*width_max);
		end
		overlay.skillBar.position_y = overlay.font.position_y+overlay.font.padding+size.cy;
end

ashita.events.register('text_in', 'text_in_cb', function (e)
	if(overlay.targetEntity ~= nil) then
		local isReading, endIdxR = string.find(e.message,'readies');
		--local isReadingSimplelog, endIdxR = string.find(e.message,overlay.targetName);
		--if( isReadingSimplelog) then overlay.debugText = e.message; end
		local isUsing, _ = string.find(e.message,'uses');
		local isTarget, _ = string.find(e.message,overlay.targetName);
		if (isTarget and bit.band(overlay.targetEntity.SpawnFlags, 0x10) ~= 0) then
			if (isReading and isReading > isTarget ) then
				overlay.readiesText = e.message;
				overlay.abilityText = string.sub(e.message,endIdxR+2,string.len(e.message)-3);
				ResetTimer();
				StartTimer();
			else
				if (isUsing and isUsing > isTarget ) then
					overlay.usesText = e.message;
					local checkAbility, _ = string.find(e.message,overlay.abilityText);
					if (checkAbility) then
						ResetTimer();
					end
				end
			end
		end
	end
end);

function UpdateTimer()
	if (overlay.timerRunning) then
		overlay.timer = (os.clock()-overlay.startTime);
		if (overlay.timer > overlay.maxTime) then
			ResetTimer();
		end
	end
end

function StartTimer()
	overlay.timerRunning = true;
	overlay.isAbilityUsed = false;
	overlay.startTime = os.clock();
end

function ResetTimer()
	--overlay.abilityText = '';
	overlay.startTime = 0;
	overlay.timerRunning = false;
	overlay.isAbilityUsed = true;
	overlay.timer = 0;
end

ashita.events.register('load', 'load_cb', function ()
	overlay.settings = settings.load(default_settings, 'general_settings');
	overlay.filterSettings = settings.load(default_filterSettings, 'filter_settings');
    overlay.font = fonts.new(overlay.settings.font);
	overlay.font.padding = overlay.font.font_height/4;
	getAbilities();
	overlay.skillBar = prims.new(skillBarInit);
end);

ashita.events.register('unload', 'unload_cb', function ()
    if (overlay.font ~= nil) then
        overlay.font:destroy();
        overlay.font = nil;
    end
	if (overlay.skillBar ~= nil) then
		overlay.skillBar:destroy();
		overlay.skillBar = nil;
	end
end);

ashita.events.register('command', 'command_cb', function (e)

    local args = e.command:args();
    if (#args == 0 or not args[1]:any('/skillwatch')) then
        return;
    end

    e.blocked = true;

    if (#args >= 1) then
        overlay.isSettingsOpen[1] = not overlay.isSettingsOpen[1];
        return;
    end
end);

function getAbilities()
	overlay.abilities = T{};
	
	if(overlay.filterSettings.abilityFilters == nil) then
		local f = io.open(addon.path .. '/data/abilities.txt', 'rb');
		if (f == nil) then
			error('Failed to load abilities list.');
		end
		for line in f:lines() do
			table.insert (overlay.abilities, T{line,false});
		end
		f:close();
		overlay.filterSettings.abilityFilters = overlay.abilities;
		save_filter_settings();
	else
		overlay.abilities = overlay.filterSettings.abilityFilters;
		local aIdx = 1;
		local enabledList = T{};
		overlay.abilities:each(function(v,k)
			--imgui.TextColored({ 1.0, 1.0, 1.0, 1.0 }, v[1]);

			if (v[2]) then
				table.insert(enabledList, v);
			end
			aIdx = aIdx+1;
		end);
		overlay.enabledAbilities = enabledList;
	end


end