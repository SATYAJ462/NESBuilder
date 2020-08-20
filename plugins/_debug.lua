-- NESBuilder plugin
-- debug.lua
--
-- Plugins starting with "_" are disabled.

local plugin = {
    author = "SpiderDave",
}

function plugin.onInit()
--    NESBuilder:makeTab("debug", "Debug")
--    NESBuilder:setTab("debug")
    
    local x,y,control,pad,left,right
    
    pad=6
    left = pad*1.5
    top = pad*1.5
    x,y = left,top
    
--    control = NESBuilder:makeButton{x=x,y=y,w=config.buttonWidth, name="testButton",text="Test 1"}
--    y = y + control.height + pad
    
    local items = {
        {name="restart", text="Restart"},
        {name="forceClose", text="Force Close"},
        {name="openMainFolder", text="Open Main Folder"},
        {name="openPluginFolder", text="Open Plugin Folder"},
    }
    control = NESBuilder:makeMenu{name="debugMenu", text="Debug", items=items, prefix=true}
end

function debugMenu_restart_cmd()
    NESBuilder:restart()
end

function debugMenu_forceClose_cmd()
    NESBuilder:forceClose()
end

function debugMenu_openMainFolder_cmd()
    local workingFolder = data.folders.projects..data.project.folder
    NESBuilder:shellOpen(workingFolder, "")
end

function debugMenu_openPluginFolder_cmd()
    local workingFolder = data.folders.projects..data.project.folder
    NESBuilder:shellOpen(workingFolder, data.folders.plugins)
end

return plugin