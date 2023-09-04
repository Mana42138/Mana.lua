local Main = {}

function Main:dev(files, color, common, cvar, entity, esp, events, globals, json, materials, math, ui, network, panorama, rage, render, utils, vector, csgo_weapons, Main_functions_table)

--[[

    Welcome To Mana's Multi Script

]]--



files.create_folder('nl\\mana')

files.create_folder('nl\\mana\\easing')

files.write('nl\\mana\\easing\\main.lua', network.get("https://pastebin.com/raw/m97ut0TN"))



local easing = require 'mana/easing/main'

local easing = require 'mana/easing/main'

local ffi = require("ffi")

local helpers = {}

local csgo_weapons = csgo_weapons

ffi.cdef[[

    int GetAsyncKeyState(int vKey);

    bool DeleteUrlCacheEntryA(const char* lpszUrlName);

    void* __stdcall URLDownloadToFileA(void* LPUNKNOWN, const char* LPCSTR, const char* LPCSTR2, int a, int LPBINDSTATUSCALLBACK);



    typedef struct

    {

        float x;

        float y;

        float z;

    } Vector_t;

 

    int VirtualProtect(void* lpAddress, unsigned long dwSize, unsigned long flNewProtect, unsigned long* lpflOldProtect);

    void* VirtualAlloc(void* lpAddress, unsigned long dwSize, unsigned long  flAllocationType, unsigned long flProtect);

    int VirtualFree(void* lpAddress, unsigned long dwSize, unsigned long dwFreeType);

    typedef uintptr_t (__thiscall* GetClientEntity_4242425_t)(void*, int);



    typedef struct

    {

        char    pad0[0x60]; // 0x00

        void* pEntity; // 0x60

        void* pActiveWeapon; // 0x64

        void* pLastActiveWeapon; // 0x68

        float        flLastUpdateTime; // 0x6C

        int            iLastUpdateFrame; // 0x70

        float        flLastUpdateIncrement; // 0x74

        float        flEyeYaw; // 0x78

        float        flEyePitch; // 0x7C

        float        flGoalFeetYaw; // 0x80

        float        flLastFeetYaw; // 0x84

        float        flMoveYaw; // 0x88

        float        flLastMoveYaw; // 0x8C // changes when moving/jumping/hitting ground

        float        flLeanAmount; // 0x90

        char         pad1[0x4]; // 0x94

        float        flFeetCycle; // 0x98 0 to 1

        float        flMoveWeight; // 0x9C 0 to 1

        float        flMoveWeightSmoothed; // 0xA0

        float        flDuckAmount; // 0xA4

        float        flHitGroundCycle; // 0xA8

        float        flRecrouchWeight; // 0xAC

        Vector_t        vecOrigin; // 0xB0

        Vector_t        vecLastOrigin;// 0xBC

        Vector_t        vecVelocity; // 0xC8

        Vector_t        vecVelocityNormalized; // 0xD4

        Vector_t        vecVelocityNormalizedNonZero; // 0xE0

        float        flVelocityLenght2D; // 0xEC

        float        flJumpFallVelocity; // 0xF0

        float        flSpeedNormalized; // 0xF4 // clamped velocity from 0 to 1

        float        flRunningSpeed; // 0xF8

        float        flDuckingSpeed; // 0xFC

        float        flDurationMoving; // 0x100

        float        flDurationStill; // 0x104

        bool        bOnGround; // 0x108

        bool        bHitGroundAnimation; // 0x109

        char    pad2[0x2]; // 0x10A

        float        flNextLowerBodyYawUpdateTime; // 0x10C

        float        flDurationInAir; // 0x110

        float        flLeftGroundHeight; // 0x114

        float        flHitGroundWeight; // 0x118 // from 0 to 1, is 1 when standing

        float        flWalkToRunTransition; // 0x11C // from 0 to 1, doesnt change when walking or crouching, only running

        char    pad3[0x4]; // 0x120

        float        flAffectedFraction; // 0x124 // affected while jumping and running, or when just jumping, 0 to 1

        char    pad4[0x208]; // 0x128

        float        flMinBodyYaw; // 0x330

        float        flMaxBodyYaw; // 0x334

        float        flMinPitch; //0x338

        float        flMaxPitch; // 0x33C

        int            iAnimsetVersion; // 0x340

    } CCSGOPlayerAnimationState_534535_t;

]]



helpers.lerp = function(a, b, percentage) return a + (b - a) * percentage end



helpers.screen_size = render.screen_size()

function RGBToColorString(str, R, G, B, A)
    R = math.max(0, math.min(255, R))
    G = math.max(0, math.min(255, G))
    B = math.max(0, math.min(255, B))
    A = math.max(0, math.min(255, A or 255))
    local RHex = string.format("%01X", R)
    local GHex = string.format("%01X", G)
    local BHex = string.format("%01X", B)
    local AHex = string.format("%01X", A)
    local colorCode = "\a" .. RHex .. GHex .. BHex .. AHex .. " ".. str .. " \a89A4B5FF"
    return colorCode
end

local script_db = {}

script_db.username = common.get_username()

script_db.lua_name = 'Mana Lua'

script_db.lua_version = 'BETA'

local png = ui.create("Info", "Mana.lua - Free script")

local Setup_welcome = ui.create("Info", "Misc")

local cfgsys = ui.create("Info", "Config System")

Setup_welcome:label("Welcome, "..RGBToColorString(common.get_username(), 130, 95, 208, 255).. "!") --\aA9ACFFFF

Setup_welcome:label("Mana Lua "..RGBToColorString(script_db.lua_version, 130, 95, 208, 255).. " Ready")

local DDS = Setup_welcome:button("       Discord       ")

local export_cfg = cfgsys:button("       Export Config (soon)       ")

local import_cfg = cfgsys:button("       Import Config (soon)       ")

local defcfg = cfgsys:button("                Load Default Config (soon)                ")



defcfg:set_callback(function()

    common.add_notify("Configs", 'Configs will come soon!')

end, false)



-- export_cfg:set_callback(function()

--     common.add_notify("Configs", 'Configs will come soon!')

-- end, false)



import_cfg:set_callback(function()

    common.add_notify("Configs", 'Configs will come soon!')

end, false)



local Is_Group_Ready = false



local AA_Group = ui.create("Anti-Aim", "Test")

local Misc_Group = ui.create("Misc", "Misc")

local Visuals_Group = ui.create("Visuals", "Main")

local Visuals_Colors = ui.create("Visuals", "Colors")

local Trash_Talk = ui.create("Misc", "Trash Talk")

local Rage_Group = ui.create("Rage", "Main")



local menu = {}



local menu_items = {

    main = {

        Global = ui.create("Anti-Aim", "Global"):visibility(false),

        Standing = ui.create("Anti-Aim", "Standing"):visibility(false),

        Walking = ui.create("Anti-Aim", "Walking"):visibility(false),

        Running = ui.create("Anti-Aim", "Running"):visibility(false),

        Crouching = ui.create("Anti-Aim", "Crouching"):visibility(false),

        In_Air = ui.create("Anti-Aim", "In Air"):visibility(false),

    }

}



-- table.foreach(ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):list(), print)



helpers.dragging_fn = function(name, base_x, base_y)

    return (function()

        local a = {}

        local b, c, f, g, h, i, k, l, m, n, o

        local d, j = {}, {}

        local p = {__index = {drag = function(self, ...)

                    local q, r = self:get()

                    local s, t = a.drag(q, r, ...)

                    if q ~= s or r ~= t then

                        self:set(s, t)

                    end

                    return s, t

                end, set = function(self, q, r)

                    local j = render.screen_size()

                    self.x_reference:set(q / j.x * self.res)

                    self.y_reference:set(r / j.y * self.res)

                end, get = function(self)

                    local j = render.screen_size()

                    return self.x_reference:get() / self.res * j.x, self.y_reference:get() / self.res * j.y

                end}}

        function a.new(u, v, w, x)

            x = x or 10000

            local j = render.screen_size()

            local y = Visuals_Group:slider(u .. ' window position', 0, x, v / j.x * x)

            local z = Visuals_Group:slider(u .. ' window position y', 0, x, w / j.y * x)

            y:visibility(false)

            z:visibility(false)

            return setmetatable({name = u, x_reference = y, y_reference = z, res = x}, p)

        end

        function a.drag(q, r, A, B, C, D, E)

            if globals.framecount ~= b then

                c = ui.get_alpha() > 0

                f, g = d.x, d.y

                d = ui.get_mouse_position()

                i = h

                h = common.is_button_down(0x1) == true

                m = l

                l = {}

                o = n

                n = false

                j = render.screen_size()

            end

            if c and i ~= nil then

                if (not i or o) and h and f > q and g > r and f < q + A and g < r + B then

                    n = true

                    q, r = q + d.x - f, r + d.y - g

                    if not D then

                        q = math.max(0, math.min(j.x - A, q))

                        r = math.max(0, math.min(j.y - B, r))

                    end

                end

            end

            table.insert(l, {q, r, A, B})

            return q, r, A, B

        end

        return a

    end)().new(name, base_x, base_y)

end



function TableFind(key, value)

    for i,v in pairs(key) do

        if v == value then

            return true

        end

    end

    return false

end



function wait(time, callback)
    if not StartTime then 
        StartTime = globals.curtime
    end
    if StartTime + (time * 0.01) < globals.curtime then
        callback()
        StartTime = globals.curtime
    end
end



function FrameWait(frames, callback)
    if not ScoutSwitchCounter then
        ScoutSwitchCounter = 0
    end
    ScoutSwitchCounter = ScoutSwitchCounter + 2
    if ScoutSwitchCounter < frames then
        return
    end
    ScoutSwitchCounter = 0

    callback()

end

function SwitchingWait(speed, callback1, callback2)
    if not ScoutSwitchCounter then
        ScoutSwitchCounter = 0
    end
    if ScoutSwitchCounter == 0 then
        callback1()
        ScoutSwitchCounter = 2
    elseif ScoutSwitchCounter == 2 then
        wait(speed, function()
            ScoutSwitchCounter = 3
        end)
    elseif ScoutSwitchCounter == 3 then
        callback2()
        ScoutSwitchCounter = 4
    elseif ScoutSwitchCounter == 4 then
        wait(speed, function()
            ScoutSwitchCounter = 0
        end)
    end
end



function SwayingNumber(minValue, maxValue, speed)
    return minValue + (math.sin(globals.curtime * speed) + 1) * (maxValue - minValue / 2)
end



local weapons = {"Global","SSG-08","Pistols","AutoSnipers","Snipers","Rifles","SMGs","Shotguns","Machineguns","AWP","AK-47","M4A1/M4A4","Desert Eagle","R8 Revolver","AUG/SG 553","Taser"}

local ui_ragebot = {}



menu_items.Main_Table = {

    main = {

        SlowWalk = AA_Group:switch("Custom Slow Walk"),

        Conditions_Table = AA_Group:list("Enable Conditions", {"Global", "Standing", "Walking", "Running", "Crouching", "In Air"}),

    },

}



local Main_Table = menu_items.Main_Table



menu_items.Items = {

    ["Global"] = {

        Global_Yaw_Add_Type = menu_items.main.Global:combo("Yaw Add Type", {"Static", "Jitter"}),

        Global_Yaw_Modifier = menu_items.main.Global:combo("Yaw Modifier", ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):list()),

        Global_Left_Limit = menu_items.main.Global:slider("Left Limit", 0, 60, 0, 1),

        Global_Right_Limit = menu_items.main.Global:slider("Right Limit", 0, 60, 0, 1),

        Global_Options = menu_items.main.Global:selectable("Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list()),

        Global_Extended_Angels = menu_items.main.Global:switch("Extended Angels", false),

    },

    ["Standing"] = {

        Standing_Yaw_Add_Type = menu_items.main.Standing:combo("Yaw Add Type", {"Static", "Jitter"}),

        Standing_Yaw_Modifier = menu_items.main.Standing:combo("Yaw Modifier", ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):list()),

        Standing_Left_Limit = menu_items.main.Standing:slider("Left Limit", 0, 60, 0, 1),

        Standing_Right_Limit = menu_items.main.Standing:slider("Right Limit", 0, 60, 0, 1),

        Standing_Options = menu_items.main.Standing:selectable("Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list()),

        Standing_Extended_Angels = menu_items.main.Standing:switch("Extended Angels", false),

    },

    ["Walking"] = {

        Walking_Yaw_Add_Type = menu_items.main.Walking:combo("Yaw Add Type", {"Static", "Jitter"}),

        Walking_Yaw_Modifier = menu_items.main.Walking:combo("Yaw Modifier", ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):list()),

        Walking_Left_Limit = menu_items.main.Walking:slider("Left Limit", 0, 60, 0, 1),

        Walking_Right_Limit = menu_items.main.Walking:slider("Right Limit", 0, 60, 0, 1),

        Walking_Options = menu_items.main.Walking:selectable("Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list()),

        Walking_Extended_Angels = menu_items.main.Walking:switch("Extended Angels", false),

    },

    ["Running"] = {

        Running_Yaw_Add_Type = menu_items.main.Running:combo("Yaw Add Type", {"Static", "Jitter"}),

        Running_Yaw_Modifier = menu_items.main.Running:combo("Yaw Modifier", ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):list()),

        Running_Left_Limit = menu_items.main.Running:slider("Left Limit", 0, 60, 0, 1),

        Running_Right_Limit = menu_items.main.Running:slider("Right Limit", 0, 60, 0, 1),

        Running_Options = menu_items.main.Running:selectable("Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list()),

        Running_Extended_Angels = menu_items.main.Running:switch("Extended Angels", false),

    },

    ["Crouching"] = {

        Crouching_Yaw_Add_Type = menu_items.main.Crouching:combo("Yaw Add Type", {"Static", "Jitter"}),

        Crouching_Yaw_Modifier = menu_items.main.Crouching:combo("Yaw Modifier", ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):list()),

        Crouching_Left_Limit = menu_items.main.Crouching:slider("Left Limit", 0, 60, 0, 1),

        Crouching_Right_Limit = menu_items.main.Crouching:slider("Right Limit", 0, 60, 0, 1),

        Crouching_Options = menu_items.main.Crouching:selectable("Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list()),

        Crouching_Extended_Angels = menu_items.main.Crouching:switch("Extended Angels", false),

    },

    ["In_Air"] = {

        In_Air_Yaw_Add_Type = menu_items.main.In_Air:combo("Yaw Add Type", {"Static", "Jitter"}),

        In_Air_Yaw_Modifier = menu_items.main.In_Air:combo("Yaw Modifier", ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):list()),

        In_Air_Left_Limit = menu_items.main.In_Air:slider("Left Limit", 0, 60, 0, 1),

        In_Air_Right_Limit = menu_items.main.In_Air:slider("Right Limit", 0, 60, 0, 1),

        In_Air_Options = menu_items.main.In_Air:selectable("Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list()),

        In_Air_Extended_Angels = menu_items.main.In_Air:switch("Extended Angels", false),

        In_Air_Crazy_AA = menu_items.main.In_Air:switch("Crazy AA", false),

    },

}



Main_Table.CreateElements = {

    ["AA"] = {

        SLW = Main_Table.main.SlowWalk:create(),

        CT_Table = Main_Table.main.Conditions_Table:create(),



        Global_Yaw_Type = menu_items.Items.Global.Global_Yaw_Add_Type:create(),

        Global_E_Angel = menu_items.Items.Global.Global_Extended_Angels:create(),

        Global_YM = menu_items.Items.Global.Global_Yaw_Modifier:create(),



        Standing_Yaw_Type = menu_items.Items.Standing.Standing_Yaw_Add_Type:create(),

        Standing_E_Angel = menu_items.Items.Standing.Standing_Extended_Angels:create(),

        Standing_YM = menu_items.Items.Standing.Standing_Yaw_Modifier:create(),



        Walking_Yaw_Type = menu_items.Items.Walking.Walking_Yaw_Add_Type:create(),

        Walking_E_Angel = menu_items.Items.Walking.Walking_Extended_Angels:create(),

        Walking_YM = menu_items.Items.Walking.Walking_Yaw_Modifier:create(),



        Running_Yaw_Type = menu_items.Items.Running.Running_Yaw_Add_Type:create(),

        Running_E_Angel = menu_items.Items.Running.Running_Extended_Angels:create(),

        Running_YM = menu_items.Items.Running.Running_Yaw_Modifier:create(),



        Crouching_Yaw_Type = menu_items.Items.Crouching.Crouching_Yaw_Add_Type:create(),

        Crouching_E_Angel = menu_items.Items.Crouching.Crouching_Extended_Angels:create(),

        Crouching_YM = menu_items.Items.Crouching.Crouching_Yaw_Modifier:create(),



        In_Air_Yaw_Type = menu_items.Items.In_Air.In_Air_Yaw_Add_Type:create(),

        In_Air_E_Angel = menu_items.Items.In_Air.In_Air_Extended_Angels:create(),

        In_Air_YM = menu_items.Items.In_Air.In_Air_Yaw_Modifier:create(),



    },

}



Main_Table.Elements = {

    Walk_Speed = Main_Table.CreateElements.AA.SLW:slider("Walk Speed", 0, 100, 1, 1),



    Allow_Global = Main_Table.CreateElements.AA.CT_Table:switch("Global"),

    Allow_Standing = Main_Table.CreateElements.AA.CT_Table:switch("Standing"),

    Allow_Walking = Main_Table.CreateElements.AA.CT_Table:switch("Walking"),

    Allow_Running = Main_Table.CreateElements.AA.CT_Table:switch("Running"),

    Allow_Crouching = Main_Table.CreateElements.AA.CT_Table:switch("Crouching"),

    Allow_In_Air = Main_Table.CreateElements.AA.CT_Table:switch("In Air"),



    Global_Y_Add_Left = Main_Table.CreateElements.AA.Global_Yaw_Type:slider("Yaw Add - Left", -90, 90, 0, 1),

    Global_Y_Add_Right = Main_Table.CreateElements.AA.Global_Yaw_Type:slider("Yaw Add - Right", -90, 90, 0, 1),

    Global_E_Angel_Pitch = Main_Table.CreateElements.AA.Global_E_Angel:slider("Extended Pitch", -180, 180, 0, 1),

    Global_E_Angel_Roll = Main_Table.CreateElements.AA.Global_E_Angel:slider("Extended Roll", 0, 90, 0, 1),

    Global_YM_Modifier = Main_Table.CreateElements.AA.Global_YM:slider("Offset", -180, 180, 0, 1),



    Standing_Y_Add_Left = Main_Table.CreateElements.AA.Standing_Yaw_Type:slider("Yaw Add - Left", -90, 90, 0, 1),

    Standing_Y_Add_Right = Main_Table.CreateElements.AA.Standing_Yaw_Type:slider("Yaw Add - Right", -90, 90, 0, 1),

    Standing_E_Angel_Pitch = Main_Table.CreateElements.AA.Standing_E_Angel:slider("Extended Pitch", -180, 180, 0, 1),

    Standing_E_Angel_Roll = Main_Table.CreateElements.AA.Standing_E_Angel:slider("Extended Roll", 0, 90, 0, 1),

    Standing_YM_Modifier = Main_Table.CreateElements.AA.Standing_YM:slider("Offset", -180, 180, 0, 1),



    Walking_Y_Add_Left = Main_Table.CreateElements.AA.Walking_Yaw_Type:slider("Yaw Add - Left", -90, 90, 0, 1),

    Walking_Y_Add_Right = Main_Table.CreateElements.AA.Walking_Yaw_Type:slider("Yaw Add - Right", -90, 90, 0, 1),

    Walking_E_Angel_Pitch = Main_Table.CreateElements.AA.Walking_E_Angel:slider("Extended Pitch", -180, 180, 0, 1),

    Walking_E_Angel_Roll = Main_Table.CreateElements.AA.Walking_E_Angel:slider("Extended Roll", 0, 90, 0, 1),

    Walking_YM_Modifier = Main_Table.CreateElements.AA.Walking_YM:slider("Offset", -180, 180, 0, 1),



    Running_Y_Add_Left = Main_Table.CreateElements.AA.Running_Yaw_Type:slider("Yaw Add - Left", -90, 90, 0, 1),

    Running_Y_Add_Right = Main_Table.CreateElements.AA.Running_Yaw_Type:slider("Yaw Add - Right", -90, 90, 0, 1),

    Running_E_Angel_Pitch = Main_Table.CreateElements.AA.Running_E_Angel:slider("Extended Pitch", -180, 180, 0, 1),

    Running_E_Angel_Roll = Main_Table.CreateElements.AA.Running_E_Angel:slider("Extended Roll", 0, 90, 0, 1),

    Running_YM_Modifier = Main_Table.CreateElements.AA.Running_YM:slider("Offset", -180, 180, 0, 1),



    Crouching_Y_Add_Left = Main_Table.CreateElements.AA.Crouching_Yaw_Type:slider("Yaw Add - Left", -90, 90, 0, 1),

    Crouching_Y_Add_Right = Main_Table.CreateElements.AA.Crouching_Yaw_Type:slider("Yaw Add - Right", -90, 90, 0, 1),

    Crouching_E_Angel_Pitch = Main_Table.CreateElements.AA.Crouching_E_Angel:slider("Extended Pitch", -180, 180, 0, 1),

    Crouching_E_Angel_Roll = Main_Table.CreateElements.AA.Crouching_E_Angel:slider("Extended Roll", 0, 90, 0, 1),

    Crouching_YM_Modifier = Main_Table.CreateElements.AA.Crouching_YM:slider("Offset", -180, 180, 0, 1),



    In_Air_Y_Add_Left = Main_Table.CreateElements.AA.In_Air_Yaw_Type:slider("Yaw Add - Left", -90, 90, 0, 1),

    In_Air_Y_Add_Right = Main_Table.CreateElements.AA.In_Air_Yaw_Type:slider("Yaw Add - Right", -90, 90, 0, 1),

    In_Air_E_Angel_Pitch = Main_Table.CreateElements.AA.In_Air_E_Angel:slider("Extended Pitch", -180, 180, 0, 1),

    In_Air_E_Angel_Roll = Main_Table.CreateElements.AA.In_Air_E_Angel:slider("Extended Roll", 0, 90, 0, 1),

    In_Air_YM_Modifier = Main_Table.CreateElements.AA.In_Air_YM:slider("Offset", -180, 180, 0, 1),



}

Main_Table.main.Conditions_Table:set_callback(function()

    Main_functions_table:Set_Correct_Group_Up(Main_functions_table:GetName(Main_Table.main.Conditions_Table:get(), Main_Table), menu_items, Is_Group_Ready)

    Is_Group_Ready = true

end, false)





function GetState()

    local Player = entity.get_local_player()

    local vec = Player.m_vecVelocity

    local velocity = math.sqrt((vec.x * vec.x) + (vec.y * vec.y))



    if Main_functions_table:isKeyPressed("SHIFT") then

        return "Walking"

    elseif Player.m_fFlags == 256 then

        return "In Air"

    elseif Player.m_flDuckAmount > 0.8 then

        return "Crouching"

    elseif Player.m_flDuckAmount > 0.8 and Player.m_fFlags == 256 then

        return "In Air + Crouching"

    elseif velocity <= 2 then

        return "Standing"

    elseif velocity >= 3 then

        return "Running"

    end

    return nil

end





function Global_AA(allowed)

    if allowed == false then

        if menu_items.Items.Global.Global_Yaw_Add_Type:get() == 'Jitter' then -- Static

            SwitchingWait(0.04, function()

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Global_Y_Add_Right:get())

            end, function()

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Global_Y_Add_Left:get())

            end)

        end

        if menu_items.Items.Global.Global_Yaw_Add_Type:get() == 'Static' then

            if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Global_Y_Add_Left:get())

            else

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Global_Y_Add_Right:get())

            end

        end



        if menu_items.Items.Global.Global_Yaw_Modifier:get() ~= "Disabled" then

            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):set(menu_items.Items.Global.Global_Yaw_Modifier:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):set(Main_Table.Elements.Global_YM_Modifier:get())

        end



        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):set(menu_items.Items.Global.Global_Left_Limit:get())

        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):set(menu_items.Items.Global.Global_Right_Limit:get())

        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):set(menu_items.Items.Global.Global_Options:get())



        if menu_items.Items.Global.Global_Extended_Angels:get() then

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):set(menu_items.Items.Global.Global_Extended_Angels:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):set(Main_Table.Elements.Global_E_Angel_Pitch:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):set(Main_Table.Elements.Global_E_Angel_Roll:get())

        end

    end

end



function Standing_AA()

    -- if Main_Table.Elements.Allow_Standing:get() then

        if menu_items.Items.Standing.Standing_Yaw_Add_Type:get() == 'Jitter' then -- Static

            SwitchingWait(0.04, function()

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Standing_Y_Add_Right:get())

            end, function()

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Standing_Y_Add_Left:get())

            end)

        end

        if menu_items.Items.Standing.Standing_Yaw_Add_Type:get() == 'Static' then

            if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Standing_Y_Add_Left:get())

            else

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Standing_Y_Add_Right:get())

            end

        end



        if menu_items.Items.Standing.Standing_Yaw_Modifier:get() ~= "Disabled" then

            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):set(menu_items.Items.Standing.Standing_Yaw_Modifier:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):set(Main_Table.Elements.Standing_YM_Modifier:get())

        end



        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):set(menu_items.Items.Standing.Standing_Left_Limit:get())

        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):set(menu_items.Items.Standing.Standing_Right_Limit:get())

        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):set(menu_items.Items.Standing.Standing_Options:get())



        if menu_items.Items.Standing.Standing_Extended_Angels:get() then

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):set(menu_items.Items.Standing.Standing_Extended_Angels:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):set(Main_Table.Elements.Standing_E_Angel_Pitch:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):set(Main_Table.Elements.Standing_E_Angel_Roll:get())

        end

    -- end

end



function Walking_AA()

    -- if Main_Table.Elements.Allow_Walking:get() then

        if menu_items.Items.Walking.Walking_Yaw_Add_Type:get() == 'Jitter' then -- Static

            SwitchingWait(0.04, function()

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Walking_Y_Add_Right:get())

            end, function()

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Walking_Y_Add_Left:get())

            end)

        end

        if menu_items.Items.Walking.Walking_Yaw_Add_Type:get() == 'Static' then

            if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Walking_Y_Add_Left:get())

            else

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Walking_Y_Add_Right:get())

            end

        end



        if menu_items.Items.Walking.Walking_Yaw_Modifier:get() ~= "Disabled" then

            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):set(menu_items.Items.Walking.Walking_Yaw_Modifier:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):set(Main_Table.Elements.Walking_YM_Modifier:get())



        end



        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):set(menu_items.Items.Walking.Walking_Left_Limit:get())

        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):set(menu_items.Items.Walking.Walking_Right_Limit:get())

        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):set(menu_items.Items.Walking.Walking_Options:get())



        if menu_items.Items.Walking.Walking_Extended_Angels:get() then

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):set(menu_items.Items.Walking.Walking_Extended_Angels:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):set(Main_Table.Elements.Walking_E_Angel_Pitch:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):set(Main_Table.Elements.Walking_E_Angel_Roll:get())

        end

    -- end

end



function Running_AA()

    -- if Main_Table.Elements.Allow_Running:get() then

        if menu_items.Items.Running.Running_Yaw_Add_Type:get() == 'Jitter' then -- Static

            SwitchingWait(0.04, function()

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Running_Y_Add_Right:get())

            end, function()

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Running_Y_Add_Left:get())

            end)

        end

        if menu_items.Items.Running.Running_Yaw_Add_Type:get() == 'Static' then

            if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Running_Y_Add_Left:get())

            else

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Running_Y_Add_Right:get())

            end

        end



        if menu_items.Items.Running.Running_Yaw_Modifier:get() ~= "Disabled" then

            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):set(menu_items.Items.Running.Running_Yaw_Modifier:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):set(Main_Table.Elements.Running_YM_Modifier:get())



        end



        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):set(menu_items.Items.Running.Running_Left_Limit:get())

        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):set(menu_items.Items.Running.Running_Right_Limit:get())

        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):set(menu_items.Items.Running.Running_Options:get())



        if menu_items.Items.Running.Running_Extended_Angels:get() then

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):set(menu_items.Items.Running.Running_Extended_Angels:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):set(Main_Table.Elements.Running_E_Angel_Pitch:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):set(Main_Table.Elements.Running_E_Angel_Roll:get())

        end

    -- end

end



function Crouching_AA()

    -- if Main_Table.Elements.Allow_Crouching:get() then

        if menu_items.Items.Crouching.Crouching_Yaw_Add_Type:get() == 'Jitter' then -- Static

            SwitchingWait(0.04, function()

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Crouching_Y_Add_Right:get())

            end, function()

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Crouching_Y_Add_Left:get())

            end)

        end

        if menu_items.Items.Crouching.Crouching_Yaw_Add_Type:get() == 'Static' then

            if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Crouching_Y_Add_Left:get())

            else

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.Crouching_Y_Add_Right:get())

            end

        end



        if menu_items.Items.Crouching.Crouching_Yaw_Modifier:get() ~= "Disabled" then

            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):set(menu_items.Items.Crouching.Crouching_Yaw_Modifier:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):set(Main_Table.Elements.Crouching_YM_Modifier:get())



        end



        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):set(menu_items.Items.Crouching.Crouching_Left_Limit:get())

        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):set(menu_items.Items.Crouching.Crouching_Right_Limit:get())

        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):set(menu_items.Items.Crouching.Crouching_Options:get())



        if menu_items.Items.Crouching.Crouching_Extended_Angels:get() then

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):set(menu_items.Items.Crouching.Crouching_Extended_Angels:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):set(Main_Table.Elements.Crouching_E_Angel_Pitch:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):set(Main_Table.Elements.Crouching_E_Angel_Roll:get())

        end

    -- end

end



function In_Air_AA()

    -- if Main_Table.Elements.Allow_In_Air:get() then

        if menu_items.Items.In_Air.In_Air_Yaw_Add_Type:get() == 'Jitter' then -- Static

            SwitchingWait(0.04, function()

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.In_Air_Y_Add_Right:get())

            end, function()

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.In_Air_Y_Add_Left:get())

            end)

        end

        if menu_items.Items.In_Air.In_Air_Yaw_Add_Type:get() == 'Static' then

            if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.In_Air_Y_Add_Left:get())

            else

                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(Main_Table.Elements.In_Air_Y_Add_Right:get())

            end

        end



        if menu_items.Items.In_Air.In_Air_Yaw_Modifier:get() ~= "Disabled" then

            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):set(menu_items.Items.In_Air.In_Air_Yaw_Modifier:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):set(Main_Table.Elements.In_Air_YM_Modifier:get())



        end



        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):set(menu_items.Items.In_Air.In_Air_Left_Limit:get())

        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):set(menu_items.Items.In_Air.In_Air_Right_Limit:get())

        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):set(menu_items.Items.In_Air.In_Air_Options:get())



        if menu_items.Items.In_Air.In_Air_Extended_Angels:get() then

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):set(menu_items.Items.In_Air.In_Air_Extended_Angels:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):set(Main_Table.Elements.In_Air_E_Angel_Pitch:get())

            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):set(Main_Table.Elements.In_Air_E_Angel_Roll:get())

        end

    -- end

end





function Main_AA_Enable()

    if GetState() == "Walking" and Main_Table.Elements.Allow_Walking:get() then

        Walking_AA()

    end



    if GetState() == "In Air" and Main_Table.Elements.Allow_In_Air:get() then

        In_Air_AA()

    end



    if GetState() == "Crouching" and Main_Table.Elements.Allow_Crouching:get() then

        Crouching_AA()

    end



    if GetState() == "Standing" and Main_Table.Elements.Allow_Standing:get() then

        Standing_AA()

    end



    if GetState() == "Running" and Main_Table.Elements.Allow_Running:get() then

        Running_AA()

    end



    if GetState() == "In Air + Crouching" and Main_Table.Elements.Allow_In_Air:get() then

        In_Air_AA()

    end



    Global_AA(

    (GetState() == "Running" and Main_Table.Elements.Allow_Running:get())or

    (GetState() == "Standing" and Main_Table.Elements.Allow_Standing:get())or

    (GetState() == "Crouching" and Main_Table.Elements.Allow_Crouching:get())or

    (GetState() == "In Air" and Main_Table.Elements.Allow_In_Air:get())or

    (GetState() == "Walking" and Main_Table.Elements.Allow_Walking:get())or

    (GetState() == "In Air + Crouching" and Main_Table.Elements.Allow_In_Air:get())

)

end



function WhenWalkIsON(cmd)

    local move_vec = vector(cmd.forwardmove,0,cmd.sidemove)

	move_vec:normalize()

	move_vec = move_vec:scale(Main_Table.Elements.Walk_Speed:get())



    if Main_Table.main.SlowWalk:get() then

        cmd.forwardmove = move_vec.x

        cmd.sidemove = move_vec.z

    end

    if ui.find("Aimbot", "Anti Aim", "Misc", "Slow Walk"):get() then;ui.find("Aimbot", "Anti Aim", "Misc", "Slow Walk"):override(false)end

end



function Visible(object, swi)

    object:visibility(swi:get())

end



-- local Misc_Switch = Misc_Group:switch("Misc", false)



menu_items.Misc_Table = {

    ClanTag = Misc_Group:switch("Clan Tag", false),

    ClanTag_Speed = Misc_Group:slider("Clan Tag Speed", 0, 20, 1.0, .1),

    Custom_Clantag = Misc_Group:switch("Custom Clan Tag"),

    Custom_Clantag_Text = Misc_Group:input("Custom Clan Text", ""),



    Aspect_Ratio_switch = Misc_Group:switch("Aspect Ratio", false),

    slider_Aspect_Ratio = Misc_Group:slider("Value", 0, 20, 1.0, 0.1),

    

    viewmodel = Misc_Group:switch("Custom Viewmodel"):tooltip("Allow to change viewmodel fov"),

    fov = Misc_Group:slider("Fov", 0, 100, 90),

    x = Misc_Group:slider("X", - 15, 15, 0, 1),

    y = Misc_Group:slider("Y", - 15, 15, 0, 1),

    z = Misc_Group:slider("Z", - 15, 15, 0, 1),

}



local Misc_Table = menu_items.Misc_Table



Misc_Table.slider_Aspect_Ratio:set_callback(function ()

    if Misc_Table.Aspect_Ratio_switch:get() then

        cvar.r_aspectratio:float(Misc_Table.slider_Aspect_Ratio:get() / 10)

    end

end, false)



Misc_Table.Aspect_Ratio_switch:set_callback(function ()

    cvar.r_aspectratio:float(Misc_Table.Aspect_Ratio_switch:get() and Misc_Table.slider_Aspect_Ratio:get() / 10 or 0)

end, true)



function Viewmodelfunc()

    Misc_Table.fov:visibility(Misc_Table.viewmodel:get())

    Misc_Table.x:visibility(Misc_Table.viewmodel:get())

    Misc_Table.y:visibility(Misc_Table.viewmodel:get())

    Misc_Table.z:visibility(Misc_Table.viewmodel:get())



    if Misc_Table.viewmodel:get() then

        cvar["sv_competitive_minspec"]:int(0)

        cvar["viewmodel_fov"]:float(Misc_Table.fov:get())

        cvar["viewmodel_offset_x"]:float(Misc_Table.x:get() * 0.5)

        cvar["viewmodel_offset_y"]:float(Misc_Table.y:get())

        cvar["viewmodel_offset_z"]:float(Misc_Table.z:get())

    else

        cvar["sv_competitive_minspec"]:int(1)

        cvar["viewmodel_fov"]:string("def.")

        cvar["viewmodel_offset_x"]:string("def.")

        cvar["viewmodel_offset_y"]:string("def.")

        cvar["viewmodel_offset_z"]:string("def.")

    end

end



local Tag = "Mana.lua"

local TagNum = 0

local CTagNum = 0



local Tag_Table = {"", "M", "Ma", "Man", "Mana", "Mana.", "Mana.l", "Mana.lu", "Mana.lua", "Mana.lua", "Mana.lua", "Mana.lu",'Mana.l',"Mana.","Mana","Man","Ma","M", ""}



local updateCounter = 0

local updateInterval = 5 -- Update every 5 frames



local frameCounter = 0

local frameInterval = 3 -- Update every 3 frames



local CTag_Table = {}



function MakeCustomTag(Tag)

    local Tag_Table = {}



    local currentSubstring = ""

    for character in Tag:gmatch(".") do

        currentSubstring = currentSubstring .. character

        table.insert(Tag_Table, currentSubstring)

    end



    for i = #Tag_Table - 1, 1, -1 do

        table.insert(Tag_Table, Tag_Table[i])

    end

    return Tag_Table

end



function Clan_Tag()

    Misc_Table.ClanTag_Speed:visibility(Misc_Table.ClanTag:get())

    Misc_Table.Custom_Clantag:visibility(Misc_Table.ClanTag:get())



    if not Misc_Table.ClanTag:get() then

        return

    end



    if Misc_Table.Custom_Clantag:get() then

        return

    end



    updateCounter = updateCounter + 1



    if updateCounter < updateInterval then

        return

    end



    updateCounter = 0



    wait(Misc_Table.ClanTag_Speed:get(), function()

        TagNum = TagNum + 1

        common.set_clan_tag(Tag_Table[TagNum])



        if #Tag_Table == TagNum then

            TagNum = 0

        end

    end)

end



function CustomClanTag()

    Misc_Table.Custom_Clantag_Text:visibility(Misc_Table.Custom_Clantag:get())



    if not Misc_Table.Custom_Clantag:get() then

        return

    end



    if not Misc_Table.ClanTag:get() then

        return

    end



    local CTag_Table = MakeCustomTag(Misc_Table.Custom_Clantag_Text:get())



    updateCounter = updateCounter + 1



    if updateCounter < updateInterval then

        return

    end



    updateCounter = 0



    wait(Misc_Table.ClanTag_Speed:get() * 0.1, function()

        CTagNum = CTagNum + 1

        common.set_clan_tag(CTag_Table[CTagNum])



        if #CTag_Table == CTagNum then

            CTagNum = 0

        end

    end)

end



local Trash_Switch = Trash_Talk:switch("Trash Talk")



menu_items.TrashTalk_Table = {

    main = {

        Support_Switch = Trash_Talk:switch("Support Me", false),

        n1_Switch = Trash_Talk:switch("1", false),

        Custom_Switch = Trash_Talk:switch("Custom on kill", false),

    }

}



local TrashTalk_Table = menu_items.TrashTalk_Table



TrashTalk_Table.CreateElements = {

    Cust_Switch = TrashTalk_Table.main.Custom_Switch:create()

}



TrashTalk_Table.Elements = {

    Inp1 = TrashTalk_Table.CreateElements.Cust_Switch:input("Inp 1", "neverlose.cc/market/item?id=LMaW6X"),

    Inp2 = TrashTalk_Table.CreateElements.Cust_Switch:input("Inp 2", "Get Mana.lua! neverlose.cc/market/item?id=LMaW6X"),

    Inp3 = TrashTalk_Table.CreateElements.Cust_Switch:input("Inp 3", "Howdy get 1 in you but"),

}



Trash_Switch:set_callback(function()

    for i,v in pairs(TrashTalk_Table.main) do

        Visible(v, Trash_Switch)

    end

end, false)



local Support_Table = {

    "Howdy %s get good get neverlose.cc/market/item?id=LMaW6X",

    "dang should have gotten Mana.lua!",

    "neverlose.cc/market/item?id=LMaW6X your welcome"

}



local n1_table = {

    "1"

}



events.aim_ack:set(function(e)

    local Custom_Table = {

        TrashTalk_Table.Elements.Inp1:get(),

        TrashTalk_Table.Elements.Inp2:get(),

        TrashTalk_Table.Elements.Inp3:get()

    }

    local target = e.target

    local get_target_entity = entity.get(target)

    if not get_target_entity then return end

    

    local health = get_target_entity.m_iHealth



    if not target:get_name() or not health then return end

    

    if not Trash_Switch:get() then return end

    if health == 0 then

        if TrashTalk_Table.main.Support_Switch:get() then

            utils.console_exec("say " .. (Support_Table[math.random(1, #Support_Table)]):format(target:get_name()))

        end

        if TrashTalk_Table.main.n1_Switch:get() then

            utils.console_exec("say " .. (n1_table[math.random(1, #n1_table)]):format(target:get_name()))

        end

        if TrashTalk_Table.main.Custom_Switch:get() then

            utils.console_exec("say " .. (Custom_Table[math.random(1, #Custom_Table)]):format(target:get_name()))

        end

    end

end)



local Rage_Switch = Rage_Group:switch("Rage")



menu_items.Rage_Table = {

    Scout_Switch = Rage_Group:switch("Scout Switch on shot", false),

    JumpScout = Rage_Group:switch("Jump Scout Fix", false),

    AX = Rage_Group:switch("Anti Exploit"),

}



local Rage_Table = menu_items.Rage_Table



Rage_Switch:set_callback(function()

    for i,v in pairs(Rage_Table) do

        Visible(v, Rage_Switch)

    end

end, false)



function ragebot_item()

    for i, v in pairs(weapons) do

        local Extra = ui.find("Aimbot", "Ragebot", "Accuracy", v)

        ui_ragebot[i] = {

            only_head = Extra:switch("Head Only"),

            Force_Baim_Health = Extra:switch("Baim Health"):tooltip("Baim if enemy health is under or is the selected ammount!"),

            Force_Baim_Health_value = Extra:slider("Health", 1, 100, 0, 1),

            Force_Conditions = Extra:switch("Force Conditions"),

            Force_Conditions_Baim = Extra:selectable("Baim Conditions", {"In Air", "Crouching", "Standing", "Running", "Developer"}),

            Force_Conditions_Head = Extra:selectable("Head Conditions", {"In Air", "Crouching", "Standing", "Running", "Developer"}),

        }

    end

end



function ragebot()

    for i, v in pairs(weapons) do

        local only_head = ui_ragebot[i].only_head:get()

        local FBM = ui_ragebot[i].Force_Baim_Health:get()

        local FBMV = ui_ragebot[i].Force_Baim_Health_value:get()

        local FC = ui_ragebot[i].Force_Conditions:get()

        local FCB = ui_ragebot[i].Force_Conditions_Baim

        local FCH = ui_ragebot[i].Force_Conditions_Head



        ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(only_head and "Head" or nil)

        ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(only_head and "Head" or nil)



        table.foreach(entity.get_players(true, false), function(i1,v1)

            if (v1:is_enemy() and v1:is_alive() and not v1:is_dormant()) then

                if FBM then

                    local Health = v1.m_iHealth

                    ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FBM and Health < FBMV and "Chest" or nil, FBM and "Stomach" or nil)

                    ui.find("Aimbot", "Ragebot", "Safety", v, "Body Aim"):override(FBM and Health < FBMV and "Force" or nil)

                end



                if FC then

                    local Player = entity.get(v1)

                    local vec = Player.m_vecVelocity

                    local velocity = math.sqrt((vec.x * vec.x) + (vec.y * vec.y))

                    

                    -- Head

                    if Player.m_fFlags == 256 and FCH:get("In Air") then -- In Air

                        ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCH:get("In Air") and Player.m_fFlags == 256 and v1.m_iHealth > FBMV and "Head" or nil)

                    elseif Player.m_flDuckAmount > 0.8 and FCH:get("Crouching") then -- Crouching

                        ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCH:get("Crouching") and Player.m_flDuckAmount > 0.8 and v1.m_iHealth > FBMV and "Head" or nil)

                        ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCH:get("Crouching") and Player.m_flDuckAmount > 0.8 and v1.m_iHealth > FBMV and "Head" or nil)

                    elseif velocity <= 2 and FCH:get("Standing") then -- Standing

                        ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCH:get("Standing") and velocity >= 3 and v1.m_iHealth > FBMV and "Head" or nil)

                        ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCH:get("Standing") and velocity >= 3 and v1.m_iHealth > FBMV and "Head" or nil)

                    elseif velocity >= 3 and FCH:get("Running") then -- Running

                        ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCH:get("Running") and velocity >= 3 and v1.m_iHealth > FBMV and "Head" or nil)

                        ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCH:get("Running") and velocity >= 3 and v1.m_iHealth > FBMV and "Head" or nil)

                    else

                        if FCH:get("Developer") then

                            ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCH:get("Developer") and v1.m_iHealth > FBMV and "Head" or nil)

                            ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCH:get("Developer") and v1.m_iHealth > FBMV and "Head" or nil)

                        end

                    end



                    -- Baim

                    if Player.m_fFlags == 256 and FCB:get("In Air") then -- In Air

                        ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCB:get("In Air") and Player.m_fFlags == 256 and v1.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)

                        ui.find("Aimbot", "Ragebot", "Safety", v, "Body Aim"):override(FCB:get("In Air") and Player.m_fFlags == 256 and v1.m_iHealth > FBMV and "Force" or nil)

                    elseif Player.m_flDuckAmount > 0.8 and FCB:get("Crouching") then -- Crouching

                        ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCB:get("Crouching") and Player.m_flDuckAmount > 0.8 and v1.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)

                        ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCB:get("Crouching") and Player.m_flDuckAmount > 0.8 and v1.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)

                    elseif velocity <= 2 and FCB:get("Standing") then -- Standing

                        ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCB:get("Standing") and velocity >= 3 and v1.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)

                        ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCB:get("Standing") and velocity >= 3 and v1.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)

                    elseif velocity >= 3 and FCB:get("Running") then -- Running

                        ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCB:get("Running") and velocity >= 3 and v1.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)

                        ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCB:get("Running") and velocity >= 3 and v1.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)

                    else

                        if FCB:get("Developer") then

                            ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCB:get("Developer") and v1.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)

                            ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCB:get("Developer") and v1.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)

                        end

                    end

                end

            end

        end)



    end

end



local Autostrafe = ui.find("Miscellaneous", "Main", "Movement", "Air Strafe")



function JumpScoutFix()

    if not Rage_Table.JumpScout:get() then return end

    local local_player = entity.get_local_player()

    local math_velocity = math.sqrt(local_player.m_vecVelocity.x ^ 2 + local_player.m_vecVelocity.y ^ 2)

    Autostrafe:set(math_velocity >= 5 and csgo_weapons(local_player:get_player_weapon()).name == "SSG 08" or csgo_weapons(local_player:get_player_weapon()).name ~= "SSG 08")

end



local ScoutSwitchCounter = 0

local ScoutSwitchInterval = 3 -- Update every 3 frames

local ScoutReady = false



function ScoutSwitch()

    if not Rage_Table.Scout_Switch:get() then return end

    if ScoutReady == false then return end

    local local_player = entity.get_local_player()  

    if csgo_weapons(local_player:get_player_weapon()).name ~= "SSG 08" then return end

    utils.console_exec('slot3')

    ScoutSwitchCounter = ScoutSwitchCounter + 2

    

    if ScoutSwitchCounter < ScoutSwitchInterval then

        return

    end

    

    ScoutSwitchCounter = 0

    ScoutReady = false



    utils.console_exec('slot1')

end



function AntiExploit()

    if Rage_Table.AX:get() then 

        cvar.cl_lagcompensation:int(0)

    else 

        cvar.cl_lagcompensation:int(1)

    end

end



function tick()

    frameCounter = frameCounter + 1



    if frameCounter < frameInterval then

        return

    end



    frameCounter = 0



    Clan_Tag()

    CustomClanTag()

end



















menu_items.Main_Anti_Defensive = {

    main = {

        defensive = ui.find("Aimbot", "Anti Aim", "Angles"):switch("Defensive Anti Aim"),

        fs = ui.find("Aimbot", "Anti Aim", "Angles", "Freestanding"),

        hidden = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Hidden"),

        lag_options = ui.find("Aimbot", "Ragebot", "Main", "Double Tap", "Lag Options"),

    }

}



local Main_Anti_Defensive = menu_items.Main_Anti_Defensive



-- pitch = ui.find("Aimbot", "Anti Aim", "Angles", "Pitch"),

-- yaw = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw"),



Main_Anti_Defensive.CreateElements = {

    defensive = Main_Anti_Defensive.main.defensive:create()

}



Main_Anti_Defensive.Elements = {

    pitch = Main_Anti_Defensive.CreateElements.defensive:combo("Pitch", {"Zero", "Up", "Down", "Random", "Jitter", "45 deg"}),

    yaw = Main_Anti_Defensive.CreateElements.defensive:combo("Yaw", {"Static", "Random", "Side-Way", "Spin"}),

    Weapons = Main_Anti_Defensive.CreateElements.defensive:selectable("Weapon", {"AWP", "SSG 08", "AutoSnipers", "Global"}),

    inair = Main_Anti_Defensive.CreateElements.defensive:switch("Only In air"),

    spin = Main_Anti_Defensive.CreateElements.defensive:slider("Spin speed", 120, 7200, 1300),

}



function GetSelectedWeapons(name)

    if name == "SCAR-20" and Main_Anti_Defensive.Elements.Weapons:get("AutoSnipers") then

        return true

    end

    if name == "G3SG1" and Main_Anti_Defensive.Elements.Weapons:get("AutoSnipers") then

        return true

    end

    if name == "SSG 08" and Main_Anti_Defensive.Elements.Weapons:get("SSG 08") then

        return true

    end

    if name == "AWP" and Main_Anti_Defensive.Elements.Weapons:get("AWP") then

        return true

    end

    return false

end



function defensive_aa(cmd)

    local exploit_state = rage.exploit:get() -- Defensive need always lag



    local localplayer = entity.get_local_player()

    if not localplayer then return end



    local prop = localplayer["m_fFlags"]



    local pitch_settings = Main_Anti_Defensive.Elements.pitch:get()

    local yaw_settings = Main_Anti_Defensive.Elements.yaw:get()



    local pitch_override = 0

    local yaw_override = 0

    

    if pitch_settings == "Zero" then

        pitch_override = 0

    elseif pitch_settings == "Up" then

        pitch_override = -89

    elseif pitch_settings == "Down" then

        pitch_override = 89

    elseif pitch_settings == "Random" then

        pitch_override = math.random(-89,89)

    elseif pitch_settings == "Jitter" then

        if (math.floor(globals.curtime * 100000) % 2) == 0 then

            pitch_override = 89

        else

            pitch_override = -89

        end

    elseif pitch_settings == "45 deg" then

        if (math.floor(globals.curtime * 10000) % 2) == 0 then

            pitch_override = 45

        else

            pitch_override = -45

        end

    end





    if yaw_settings == "Static" then

        yaw_override = 0

    elseif yaw_settings == "Random" then

        yaw_override = math.random(-180,180)

    elseif yaw_settings == "Side-Way" then

        if (math.floor(globals.curtime * 100000) % 2) == 0 then

            yaw_override = 89

        else

            yaw_override = -90

        end

    elseif yaw_settings == "Spin" then

        yaw_override = (globals.curtime * Main_Anti_Defensive.Elements.spin:get()) % 360 - 180

    end



    if Main_Anti_Defensive.main.defensive:get() and (GetSelectedWeapons(csgo_weapons('csgo_weapons')(localplayer:get_player_weapon()).name) or Main_Anti_Defensive.Elements.Weapons:get("Global")) and exploit_state ~= 0 or (isKeyPressed("space") and menu_items.Items.In_Air.In_Air_Crazy_AA:get()) then



        Main_Anti_Defensive.main.hidden:override(true)



        if Main_Anti_Defensive.Elements.inair:get() then

            if prop == 256 or prop == 262 then

                rage.antiaim:override_hidden_pitch(pitch_override)

                rage.antiaim:override_hidden_yaw_offset(yaw_override)

                Main_Anti_Defensive.main.lag_options:override("Always On")

            else

                rage.antiaim:override_hidden_pitch(pitch_override)

                rage.antiaim:override_hidden_yaw_offset(yaw_override)

                Main_Anti_Defensive.main.lag_options:override()

            end

        else

            rage.antiaim:override_hidden_pitch(pitch_override)

            rage.antiaim:override_hidden_yaw_offset(yaw_override)

            Main_Anti_Defensive.main.lag_options:override("Always On")



        end

    else

        Main_Anti_Defensive.main.hidden:override()

        Main_Anti_Defensive.main.fs:override()

        Main_Anti_Defensive.main.lag_options:override()

    end



end



local visuals = {}



visuals.base_render = {

    box = function(x,y,w,h,color,rounding)

        render.rect_outline(vector(x,y), vector(x+w,y+h), color, 1, rounding == nil and 0 or rounding, false)

    end,

    box_filled = function(x,y,w,h,color,rounding)

        render.rect(vector(x,y), vector(x+w,y+h), color, rounding == nil and 0 or rounding, false)

    end,

    gradient_box_filled = function(x,y,w,h,horizontal,color,color2)

        render.gradient(vector(x,y), vector(x+w,y+h), color, color, horizontal and color2 or color, horizontal and color or color2, 0)

    end,

    string = function(x,y,cen,string,color,TYPE,font,fontsize)

        if TYPE == 0 then

            render.text(font, vector(x,y), color, cen and 'c' or '', string)

        elseif TYPE == 1 then

            render.text(font, vector(x,y), color, cen and 'c' or '', string)

        elseif TYPE == 2 then

            render.text(font, vector(x,y), color, cen and 'c' or '', string)

        end

    end,

    circle = function(x,y,rad,start,endd,color,seg,th)

        render.circle_outline(vector(x,y), color, rad, start, endd, th)

    end,

    text_size = function(string,font,fontsize)

        return render.measure_text(font, '', string)

    end

}



visuals.global_render = {

    box = function(x, y, w, colorref)

        visuals.base_render.box_filled(x,y+2,w,20,color(17,17,17,120*(180)/255),4)

        visuals.base_render.box_filled(x+3,y+1,w-6,1,color(colorref.r,colorref.g,colorref.b,colorref.a))

        visuals.base_render.circle(x+3,y+4,3,180,0.25,color(colorref.r,colorref.g,colorref.b,colorref.a),75,1)

        visuals.base_render.circle(x+w-3,y+4,3,-90,0.25,color(colorref.r,colorref.g,colorref.b,colorref.a),75,1)

        visuals.base_render.gradient_box_filled(x,y+4,1,12,false,color(colorref.r,colorref.g,colorref.b,colorref.a),color(colorref.r,colorref.g,colorref.b,0))

        visuals.base_render.gradient_box_filled(x+w-1,y+4,1,12,false,color(colorref.r,colorref.g,colorref.b,colorref.a),color(colorref.r,colorref.g,colorref.b,0))

    end

}



visuals.keybinds = {}



visuals.keybinds.get_keys = function()

    local binds = {}

    local cheatbinds = ui.get_binds()

  

    for i = 1, #cheatbinds do

        table.insert(binds, 1, cheatbinds[i])

    end

    return binds

end



visuals.keybinds.names = {

    ['Double Tap'] = 'Double tap',

    ['Hide Shots'] = 'On shot anti-aim',

    ['Slow Walk'] = 'Slow motion',

    ['Edge Jump'] = 'Jump at edge',

    ['Fake Ping'] = 'Ping spike',

    ['Override Resolver'] = 'Resolver override',

    ['Fake Duck'] = 'Duck peek assist',

    ['Minimum Damage'] = 'Damage override',

    ['Auto Peek'] = 'Quick peek assist',

    ['Body Aim'] = 'Force body aim',

    ['Safe Points'] = 'Safe points',

    ['Yaw Base'] = 'Yaw base',

    ['Enable Thirdperson'] = 'Thirdperson',

    ['Manual Yaw Base'] = 'Yaw base',

}



visuals.keybinds.upper_to_lower = function(str)

    local str1 = string.sub(str, 2, #str)

    local str2 = string.sub(str, 1, 1)

    return str2:upper()..str1:lower()

end



visuals.keybinds.vars = {

    alpha = {

        [ '' ] = 0

    },

    window = {

        alpha = 0,

        width = 0

    }

}



visuals.keybinds.dragging = helpers.dragging_fn('KeyBinds', helpers.screen_size.x / 1.3, helpers.screen_size.y / 2.5)



local Selected_KeyBind = Visuals_Group:selectable("KeyBinds", {"Jagoyaw", "Skeet (soon)"})

local Watermark_switch = Visuals_Group:switch("Watermark", true)



local Branche = Visuals_Colors:color_picker("Accent", color(142, 165, 229,255)):visibility(false)



Watermark_switch:set_callback(function()

    Branche:visibility(Watermark_switch:get())

    ui.find("Miscellaneous", "Main", "Other", "Windows"):set("Watermark off")

end, true)



Selected_KeyBind:set_callback(function()

    Branche:visibility(Selected_KeyBind:get("Jagoyaw"))

    ui.find("Miscellaneous", "Main", "Other", "Windows"):set("Hotkeys off")

end, true)



function keybinds_draw()

    if Selected_KeyBind:get("Jagoyaw") then

        local speed = globals.frametime * 5

        local color_ref = Branche:get()

        local pos = { x = 0, y = 0, w = 0, h = 0 }

        pos.x, pos.y = visuals.keybinds.dragging:get()

        pos.x = math.ceil(pos.x)

        pos.y = math.ceil(pos.y)

        local offset = 0

        local maximum_offset = 80



        local binds = visuals.keybinds.get_keys()

        for i = 1, #binds do

            local bind = binds[i]

            local bind_name = visuals.keybinds.names[bind.name] == nil and visuals.keybinds.upper_to_lower(bind.name) or visuals.keybinds.names[bind.name]



            local bind_state = ''

            if bind.value == true then

                local bind_mode = bind.mode

                if bind_mode == 2 then

                    bind_state = 'toggled'

                elseif bind_mode == 1 then

                    bind_state = 'holding'

                end

            else

                bind_state = bind.value

            end

        

            if visuals.keybinds.vars.alpha[bind_name] == nil then

                visuals.keybinds.vars.alpha[bind_name] = 0

            end

        

            local alpha = easing:inOutQuad(visuals.keybinds.vars.alpha[bind_name], 0, 1, 1)

            visuals.keybinds.vars.alpha[bind_name] = math.clamp(visuals.keybinds.vars.alpha[bind_name] + (bind.active and speed or -speed), 0, 1)

        

            local bind_state_size = render.measure_text(1, nil, bind_state)

            local bind_name_size = render.measure_text(1, nil, bind_name)



            -- if UI.get('ui_style') == 0 then

                visuals.base_render.string(pos.x + 4, pos.y + 21 + offset, false, bind_name, color(255, 255, 255, alpha*255), 1, 1)

                visuals.base_render.string(pos.x + (visuals.keybinds.vars.window.width - bind_state_size.x - 10), pos.y + 20 + offset, false, '[' .. bind_state .. ']', color(255, 255, 255, alpha*255), 1, 1)

            -- elseif UI.get('ui_style') == 1 then

            --     render.text(bind_name, vector(pos.x + 4 + 1, pos.y + 21 + 1 + offset), color(0, 0, 0, alpha), fonts.verdanar11.size, fonts.verdanar11.font)

            --     render.text(bind_name, vector(pos.x + 4, pos.y + 21 + offset), color(1, 1, 1, alpha), fonts.verdanar11.size, fonts.verdanar11.font)

            

            --     render.text('[' .. bind_state .. ']', vector(pos.x + 1 + (visuals.keybinds.vars.window.width - bind_state_size.x - 10), pos.y + 20 + 1 + offset), color(0, 0, 0, alpha), fonts.verdanar11.size, fonts.verdanar11.font)

            --     render.text('[' .. bind_state .. ']', vector(pos.x + (visuals.keybinds.vars.window.width - bind_state_size.x - 10), pos.y + 20 + offset), color(1, 1, 1, alpha), fonts.verdanar11.size, fonts.verdanar11.font)

            -- end



            offset = offset + 16 * alpha



            if maximum_offset < (bind_name_size.x + bind_state_size.x) + 30 then

                maximum_offset = bind_name_size.x + bind_state_size.x + 30

            end

        end



        pos.w = math.ceil(visuals.keybinds.vars.window.width)

        pos.h = 16



        local window_alpha = easing:inOutQuad(visuals.keybinds.vars.window.alpha, 0, 1, 1)

        visuals.keybinds.vars.window.alpha = math.clamp(visuals.keybinds.vars.window.alpha + ((ui.get_alpha() > 0 or #binds > 0) and speed or -speed), 0, 1)



        visuals.keybinds.vars.window.width = helpers.lerp(visuals.keybinds.vars.window.width, maximum_offset, speed * 2)



        -- if UI.get('ui_style') == 0 then

            visuals.global_render.box(pos.x, pos.y - 2, pos.w + 2, { r = color_ref.r, g = color_ref.g, b = color_ref.b, a = window_alpha * 255 })



            local main_text = render.measure_text(1, nil, 'keybinds')

    

            visuals.base_render.string(pos.x + 1 + pos.w / 2, pos.y + main_text.y - 3, true, 'keybinds', color(255, 255, 255, window_alpha * 255), 1, 1)

        -- elseif UI.get('ui_style') == 1 then

            -- visuals.Render_engine.container(pos.x, pos.y, pos.w, pos.h, { r = color.r, g = color.g, b = color.b, a = window_alpha }, 'keybinds', fonts.verdanar11.size, fonts.verdanar11.font)

        -- end



        visuals.keybinds.dragging:drag(pos.w, (10 + (8 * #binds)) * 2)

    end

end



function Watermark()

    local speed = globals.frametime * 5

    local color_ref = Branche:get()

    local pos = { x = 0, y = 0, w = 0, h = 0 }

    pos.x, pos.y = render.screen_size().x, 0



    local offset = { x = 10, y = 10 }



    pos.x = pos.x - offset.x

    pos.y = pos.y + offset.y



    local text = ''



    local username = script_db.username



    -- if UI.get('watermark_name') == 'Custom' then

    --     username = UI.get('watermark_name_ref')

    -- end



    text = text .. script_db.lua_name .. ' [ '.. script_db.lua_version ..'] | ' .. script_db.username .. ' | '



    local local_time = common.get_system_time()



    local time = string.format("%02d:%02d:%02d", local_time.hours, local_time.minutes, local_time.seconds)



    local ping = globals.is_in_game and math.floor(utils.net_channel().avg_latency[1] * 1000) or 0



    text = text .. 'delay: ' .. ping .. 'ms | ' .. time



    local text_size = render.measure_text(1, '', text)



    pos.x = pos.x - text_size.x

    pos.w = text_size.x

    pos.h = 16



    -- if UI.get('ui_style') == 0 then

        visuals.global_render.box(pos.x - 10, pos.y, pos.w + 10, { r = color_ref.r, g = color_ref.g, b = color_ref.b, a = 255 })



        visuals.base_render.string(pos.x - 10 + 6, pos.y + text_size.y / 2 - 0.1, false, text, color(255, 255, 255, 255), 1, 1)

    -- elseif UI.get('ui_style') == 1 then

    --     visuals.Render_engine.container(pos.x - 9, pos.y, pos.w + 9, pos.h, { r = color.r, g = color.g, b = color.b, a = 1 }, text, fonts.verdanar11.size, fonts.verdanar11.font)

    -- end



end

common.add_notify("Welcome", tostring(common.get_username()))

function once_callback()

    ragebot_item()

end



events.render:set(function()

    Viewmodelfunc()

    keybinds_draw()

    Watermark()

end)



events.createmove(function()

    JumpScoutFix()

    tick()

    ScoutSwitch()

    Main_AA_Enable()

    AntiExploit()

    ragebot()

end)



events.createmove:set(function(cmd)

    WhenWalkIsON(cmd)

    defensive_aa(cmd)

end)



events.aim_fire(function(e)

    ScoutReady = true

    -- print(e.id, e.target, e.damage, e.hitchance, e.hitgroup, e.backtrack, e.aim, e.angle)

end)



events.shutdown:set(function()

    cvar.r_aspectratio:float(0)

    rage.antiaim:inverter(false)

end)



once_callback()


end
return Main
