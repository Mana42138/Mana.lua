--[[
    Welcome To Mana's Multi Script

    This is an example on how to make your very own online Live Build
    Neverlose script that will only require a bit of brain :)
]]--
    local Test = {}

--[[
    Here is how to set it up
    you will use the neverlose API docs
    to input into the function arguments which will look like this:

        {Require File}

        local Main = {}
        function Main:dev(print_)
            print_('LULULULUL')
        end

        return Main

        {Main File}
        
        local Main = require('Mango/main')
        Main:dev(print) -- i won't recommend using the normal print functions since neverlose is designed to only have one main file where the docs are built into

        -- Anyways we are using the print function to define the print_ in the main file
]]
    function Test:pr(pprint)
        pprint("script_is_ready")
    end




    function Test:dev(files_, color_, common_, cvar_, entity_, esp_, events_, globals_, json_, materials_, math_, ui_, network_, panorama_, rage_, render_, utils_, vector_, clipboard, csgo_weapons, base64)
        local files, color, common, cvar, entity, esp, events, globals, json, materials, math, ui, network, panorama, rage, render, utils, vector = files_, color_, common_, cvar_, entity_, esp_, events_, globals_, json_, materials_, math_, ui_, network_, panorama_, rage_, render_, utils_, vector_
        
        files.create_folder('nl\\mana')
        files.create_folder('nl\\mana\\easing')
        files.create_folder('nl\\mana\\configs')

        local Main_Folder = 'nl\\mana\\'
        local Configs_Path = Main_Folder..'configs'

        -- // Files \\ --
        files.write('nl\\mana\\easing\\main.lua', network.get("https://pastebin.com/raw/m97ut0TN"))
        if not files.read('nl\\mana\\configs.json') then
            files.write('nl\\mana\\configs.json', json.stringify({}))
        end

        local Config_Data = 'nl\\mana\\configs.json'
        
        local easing = require 'mana/easing/main'
        local ffi = require("ffi")
        local helpers = {}

        for i = 1,3 do
            common_.add_notify('Mana Dev', "Live Version")
        end

        ffi.cdef[[
            void* __stdcall URLDownloadToFileA(void* LPUNKNOWN, const char* LPCSTR, const char* LPCSTR2, int a, int LPBINDSTATUSCALLBACK);        
            void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);
            int remove(const char *filename);
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

        helpers.screen_size = render_.screen_size()

        local Keys = {LBUTTON = 0x01,RBUTTON = 0x02,CANCEL = 0x03,MBUTTON = 0x04,XBUTTON1 = 0x05,XBUTTON2 = 0x06,BACK = 0x08,TAB = 0x09,CLEAR = 0x0C,RETURN = 0x0D,SHIFT = 0x10,CONTROL = 0x11,MENU = 0x12,PAUSE = 0x13,CAPITAL = 0x14,ESCAPE = 0x1B,SPACE = 0x20,PRIOR = 0x21,NEXT = 0x22,END = 0x23,HOME = 0x24,LEFT = 0x25,UP = 0x26,RIGHT = 0x27,DOWN = 0x28,SELECT = 0x29,PRINT = 0x2A,EXECUTE = 0x2B,SNAPSHOT = 0x2C,INSERT = 0x2D,DELETE = 0x2E,HELP = 0x2F,["0"] = 0x30,["1"] = 0x31,["2"] = 0x32,["3"] = 0x33,["4"] = 0x34,["5"] = 0x35,["6"] = 0x36,["7"] = 0x37,["8"] = 0x38,["9"] = 0x39,A = 0x41,B = 0x42,C = 0x43,D = 0x44,E = 0x45,F = 0x46,G = 0x47,H = 0x48,I = 0x49,J = 0x4A,K = 0x4B,L = 0x4C,M = 0x4D,N = 0x4E,O = 0x4F,P = 0x50,Q = 0x51,R = 0x52,S = 0x53,T = 0x54,U = 0x55,V = 0x56,W = 0x57,X = 0x58,Y = 0x59,Z = 0x5A,LWIN = 0x5B,RWIN = 0x5C,APPS = 0x5D,SLEEP = 0x5F,NUMPAD0 = 0x60,NUMPAD1 = 0x61,NUMPAD2 = 0x62,NUMPAD3 = 0x63,NUMPAD4 = 0x64,NUMPAD5 = 0x65,NUMPAD6 = 0x66,NUMPAD7 = 0x67,NUMPAD8 = 0x68,NUMPAD9 = 0x69,MULTIPLY = 0x6A,ADD = 0x6B,SEPARATOR = 0x6C,SUBTRACT = 0x6D,DECIMAL = 0x6E,DIVIDE = 0x6F,F1 = 0x70,F2 = 0x71,F3 = 0x72,F4 = 0x73,F5 = 0x74,F6 = 0x75,F7 = 0x76,F8 = 0x77,F9 = 0x78,F10 = 0x79,F11 = 0x7A,F12 = 0x7B,F13 = 0x7C,F14 = 0x7D,F15 = 0x7E,F16 = 0x7F,F17 = 0x80,F18 = 0x81,F19 = 0x82,F20 = 0x83,F21 = 0x84,F22 = 0x85,F23 = 0x86,F24 = 0x87,NUMLOCK = 0x90,SCROLL = 0x91,LSHIFT = 0xA0,RSHIFT = 0xA1,LCONTROL = 0xA2,RCONTROL = 0xA3,LMENU = 0xA4,RMENU = 0xA5,BROWSER_BACK = 0xA6,BROWSER_FORWARD = 0xA7,BROWSER_REFRESH = 0xA8,BROWSER_STOP = 0xA9,BROWSER_SEARCH = 0xAA,BROWSER_FAVORITES = 0xAB,BROWSER_HOME = 0xAC,VOLUME_MUTE = 0xAD,VOLUME_DOWN = 0xAE,VOLUME_UP = 0xAF,MEDIA_NEXT_TRACK = 0xB0,MEDIA_PREV_TRACK = 0xB1,MEDIA_STOP = 0xB2,MEDIA_PLAY_PAUSE = 0xB3,LAUNCH_MAIL = 0xB4,LAUNCH_MEDIA_SELECT = 0xB5,LAUNCH_APP1 = 0xB6,LAUNCH_APP2 = 0xB7,OEM_1 = 0xBA,OEM_PLUS = 0xBB,OEM_COMMA = 0xBC,OEM_MINUS = 0xBD,OEM_PERIOD = 0xBE,OEM_2 = 0xBF,OEM_3 = 0xC0,OEM_4 = 0xDB,OEM_5 = 0xDC,OEM_6 = 0xDD,OEM_7 = 0xDE,OEM_8 = 0xDF,OEM_102 = 0xE2,PROCESSKEY = 0xE5,PACKET = 0xE7,ATTN = 0xF6,CRSEL = 0xF7,EXSEL = 0xF8,EREOF = 0xF9,PLAY = 0xFA,ZOOM = 0xFB,NONAME = 0xFC,PA1 = 0xFD,OEM_CLEAR = 0xFE}

        local function isKeyPressed(keyName)
            local vKey = Keys[string.upper(keyName)]
            if vKey then
                return ffi.C.GetAsyncKeyState(vKey) ~= 0
            else
                return false
            end
        end
        local menu = {}

        local function RGBToColorString(str, color)
            R = math.max(0, math.min(255, color.r))
            G = math.max(0, math.min(255, color.g))
            B = math.max(0, math.min(255, color.b))
            A = math.max(0, math.min(255, color.a))
        
            local RHex = string.format("%01X", R)
            local GHex = string.format("%01X", G)
            local BHex = string.format("%01X", B)
            local AHex = string.format("%01X", A)
        
            local colorCode = "\a" .. RHex .. GHex .. BHex .. AHex .. " ".. str .. " \a89A4B5FF"
            
            return colorCode
        end

        local Is_Group_Ready = false
        local menu_items = {}
        menu_items.Items = {}

        menu_items.new = function(name, item, conditions)
            if menu_items.Items[name] ~= nil then
                error("item already have "..name)
                return
            end
            menu_items.Items[name] = item
            if type(conditions) == "function" then
                menu_items.visibler[name] = { ref = item, condition = conditions }
            end
            return item
        end

        local function TableFind(key, value)
            for i,v in pairs(key) do
                if v == value then
                    return true
                end
            end
            return false
        end
        
        local function wait(time, callback)
            if not StartTime then 
                StartTime = globals.curtime
            end
        
            if StartTime + (time * 0.01) < globals.curtime then
                callback()
                StartTime = globals.curtime
            end
        end
        
        local function FrameWait(frames, callback)
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
        
        local function SwitchingWait(speed, callback1, callback2)
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
        
        local function SwayingNumber(minValue, maxValue, speed)
            return minValue + (math.sin(globals.curtime * speed) + 1) * (maxValue - minValue / 2)
        end
        
        local weapons = {"Global","SSG-08","Pistols","AutoSnipers","Snipers","Rifles","SMGs","Shotguns","Machineguns","AWP","AK-47","M4A1/M4A4","Desert Eagle","R8 Revolver","AUG/SG 553","Taser"}
        local ui_ragebot = {}


        local Info = ui_.create("Info", "Main")
        local Setup_welcome = ui_.create("Info", "Misc")
        local cfgsys = ui_.create("Info", "Config System")

        local Configs = cfgsys:combo("Configs", {})
        Configs:set_callback(function()
            Configs:update(json.parse(files.read(Config_Data)))
        end, true)
        
        local CFG_Name = cfgsys:input("Config Name", "")
        local CFG_create = cfgsys:button("     Create Config     ")
        local CFG_load = cfgsys:button("      Load Config      ")
        local CFG_save = cfgsys:button("                 Save Config                 ")
        local export_cfg = cfgsys:button("    Export Config     ")
        local import_cfg = cfgsys:button("    Import Config     ")
        
        local CFG_delete = cfgsys:button("Delete Config")
        local CFG_ConfirmDeletion_Yes = cfgsys:button("   Confirm   "):visibility(false)
        local CFG_ConfirmDeletion_No = cfgsys:button("   Cancel   "):visibility(false)
        
        CFG_delete:set_callback(function()
            CFG_ConfirmDeletion_Yes:visibility(true)
            CFG_ConfirmDeletion_No:visibility(true)
        end)

        menu_items.Tabs = {
            AA_Group = ui.create("Anti-Aim", "Test"),
            Misc_Group = ui.create("Misc", "Misc"),
            Visuals_Group = ui.create("Visuals", "Main"),
            Visuals_Colors = ui.create("Visuals", "Colors"),
            Trash_Talk = ui.create("Misc", "Trash Talk"),
            Rage_Group = ui.create("Rage", "Main"),
        }

        menu_items.sections = {
            Global = ui.create("Anti-Aim", "Global"):visibility(false),
            Standing = ui.create("Anti-Aim", "Standing"):visibility(false),
            Walking = ui.create("Anti-Aim", "Walking"):visibility(false),
            Running = ui.create("Anti-Aim", "Running"):visibility(false),
            Crouching = ui.create("Anti-Aim", "Crouching"):visibility(false),
            In_Air = ui.create("Anti-Aim", "In Air"):visibility(false),
        }

        local script_db = {}

        script_db.username = common_.get_username()
        script_db.lua_name = 'Mana Lua'
        script_db.lua_version = 'BETA'

        Setup_welcome:label("Welcome, "..RGBToColorString(common_.get_username(), color(130, 95, 208, 255)).. "!") --\aA9ACFFFF
        Setup_welcome:label("Mana Lua "..RGBToColorString(script_db.lua_version, color(130, 95, 208, 255)).. " Live Build")
        
        local DDS = Setup_welcome:button("       Discord       ")


        DDS:set_callback(function()
            clipboard.set("https://discord.gg/qq6WgyMwkw")
        end, false)


        local AA_Group = menu_items.Tabs.AA_Group
        local Visuals_Group = menu_items.Tabs.Visuals_Group
        local Visuals_Colors = menu_items.Tabs.Visuals_Colors
        local Trash_Talk = menu_items.Tabs.Trash_Talk
        local Rage_Group = menu_items.Tabs.Rage_Group
        local Misc_Group = menu_items.Tabs.Misc_Group

        menu.SlowWalk = menu_items.new('Custom Slow Walk', AA_Group:switch("Custom Slow Walk"))
        menu.Conditions_Table = AA_Group:list("Enable Conditions", {"Global", "Standing", "Walking", "Running", "Crouching", "In Air"})



                menu.Global_Yaw_Add_Type = menu_items.new('Global Yaw Add Type', menu_items.sections.Global:combo("Yaw Add Type", {"Static", "Jitter"}))
                menu.Global_Yaw_Modifier = menu_items.new('Global Yaw Modifier', menu_items.sections.Global:combo("Yaw Modifier", ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):list()))
                menu.Global_Left_Limit = menu_items.new('Global Left Limit', menu_items.sections.Global:slider("Left Limit", 0, 60, 0, 1))
                menu.Global_Right_Limit = menu_items.new('Global Right Limit', menu_items.sections.Global:slider("Right Limit", 0, 60, 0, 1))
                menu.Global_Options = menu_items.new('Global Options', menu_items.sections.Global:selectable("Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list()))
                menu.Global_Extended_Angels = menu_items.new('Global Extended Angels', menu_items.sections.Global:switch("Extended Angels", false))



                menu.Standing_Yaw_Add_Type = menu_items.new('Standing Yaw Add Type', menu_items.sections.Standing:combo("Yaw Add Type", {"Static", "Jitter"}))
                menu.Standing_Yaw_Modifier = menu_items.new('Standing Yaw Modifier', menu_items.sections.Standing:combo("Yaw Modifier", ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):list()))
                menu.Standing_Left_Limit = menu_items.new('Standing Left Limit', menu_items.sections.Standing:slider("Left Limit", 0, 60, 0, 1))
                menu.Standing_Right_Limit = menu_items.new('Standing Right Limit', menu_items.sections.Standing:slider("Right Limit", 0, 60, 0, 1))
                menu.Standing_Options = menu_items.new('Standing Options', menu_items.sections.Standing:selectable("Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list()))
                menu.Standing_Extended_Angels = menu_items.new('Standing Extended Angels', menu_items.sections.Standing:switch("Extended Angels", false))



                menu.Walking_Yaw_Add_Type = menu_items.new('Walking Yaw Add Type', menu_items.sections.Walking:combo("Yaw Add Type", {"Static", "Jitter"}))
                menu.Walking_Yaw_Modifier = menu_items.new('Walking Yaw Modifier', menu_items.sections.Walking:combo("Yaw Modifier", ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):list()))
                menu.Walking_Left_Limit = menu_items.new('Walking Left Limit', menu_items.sections.Walking:slider("Left Limit", 0, 60, 0, 1))
                menu.Walking_Right_Limit = menu_items.new('Walking Right Limit', menu_items.sections.Walking:slider("Right Limit", 0, 60, 0, 1))
                menu.Walking_Options = menu_items.new('Walking Options', menu_items.sections.Walking:selectable("Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list()))
                menu.Walking_Extended_Angels = menu_items.new('Walking Extended Angels', menu_items.sections.Walking:switch("Extended Angels", false))
        

        
                menu.Running_Yaw_Add_Type = menu_items.new('Running Yaw Add Type', menu_items.sections.Running:combo("Yaw Add Type", {"Static", "Jitter"}))
                menu.Running_Yaw_Modifier = menu_items.new('Running Yaw Modifier', menu_items.sections.Running:combo("Yaw Modifier", ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):list()))
                menu.Running_Left_Limit = menu_items.new('Running Left Limit', menu_items.sections.Running:slider("Left Limit", 0, 60, 0, 1))
                menu.Running_Right_Limit = menu_items.new('Running Right Limit', menu_items.sections.Running:slider("Right Limit", 0, 60, 0, 1))
                menu.Running_Options = menu_items.new('Running Options', menu_items.sections.Running:selectable("Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list()))
                menu.Running_Extended_Angels = menu_items.new('Running Extended Angels', menu_items.sections.Running:switch("Extended Angels", false))


                menu.Crouching_Yaw_Add_Type = menu_items.new('Crouching Yaw Add Type', menu_items.sections.Crouching:combo("Yaw Add Type", {"Static", "Jitter"}))
                menu.Crouching_Yaw_Modifier = menu_items.new('Crouching Yaw Modifier', menu_items.sections.Crouching:combo("Yaw Modifier", ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):list()))
                menu.Crouching_Left_Limit = menu_items.new('Crouching Left Limit', menu_items.sections.Crouching:slider("Left Limit", 0, 60, 0, 1))
                menu.Crouching_Right_Limit = menu_items.new('Crouching Right Limit', menu_items.sections.Crouching:slider("Right Limit", 0, 60, 0, 1))
                menu.Crouching_Options = menu_items.new('Crouching Options', menu_items.sections.Crouching:selectable("Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list()))
                menu.Crouching_Extended_Angels = menu_items.new('Crouching Extended Angels', menu_items.sections.Crouching:switch("Extended Angels", false))


                menu.In_Air_Yaw_Add_Type = menu_items.new('In_Air Yaw Add Type', menu_items.sections.In_Air:combo("Yaw Add Type", {"Static", "Jitter"}))
                menu.In_Air_Yaw_Modifier = menu_items.new('In_Air Yaw Modifier', menu_items.sections.In_Air:combo("Yaw Modifier", ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):list()))
                menu.In_Air_Left_Limit = menu_items.new('In_Air Left Limit', menu_items.sections.In_Air:slider("Left Limit", 0, 60, 0, 1))
                menu.In_Air_Right_Limit = menu_items.new('In_Air Right Limit', menu_items.sections.In_Air:slider("Right Limit", 0, 60, 0, 1))
                menu.In_Air_Options = menu_items.new('In_Air Options', menu_items.sections.In_Air:selectable("Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list()))
                menu.In_Air_Extended_Angels = menu_items.new('In_Air Extended Angels', menu_items.sections.In_Air:switch("Extended Angels", false))
                menu.In_Air_Crazy_AA = menu_items.new('In_Air Crazy AA', menu_items.sections.In_Air:switch("Crazy AA", false))


            menu.Walk_Speed = menu_items.new('Walk Speed', menu.SlowWalk:create():slider("Walk Speed", 0, 100, 1, 1))
        
            menu.Allow_Global = menu_items.new('Global', menu.Conditions_Table:create():switch("Global"))
            menu.Allow_Standing = menu_items.new('Standing', menu.Conditions_Table:create():switch("Standing"))
            menu.Allow_Walking = menu_items.new('Walking', menu.Conditions_Table:create():switch("Walking"))
            menu.Allow_Running = menu_items.new('Running', menu.Conditions_Table:create():switch("Running"))
            menu.Allow_Crouching = menu_items.new('Crouching', menu.Conditions_Table:create():switch("Crouching"))
            menu.Allow_In_Air = menu_items.new('In Air', menu.Conditions_Table:create():switch("In Air"))
        
            menu.Global_Y_Add_Left = menu_items.new('Global Yaw Add - Left', menu.Global_Yaw_Add_Type:create():slider("Yaw Add - Left", -90, 90, 0, 1))
            menu.Global_Y_Add_Right = menu_items.new('Global Yaw Add - Right', menu.Global_Yaw_Add_Type:create():slider("Yaw Add - Right", -90, 90, 0, 1))
            menu.Global_E_Angel_Pitch = menu_items.new('Global Extended Pitch', menu.Global_Extended_Angels:create():slider("Extended Pitch", -180, 180, 0, 1))
            menu.Global_E_Angel_Roll = menu_items.new('Global Extended Roll', menu.Global_Extended_Angels:create():slider("Extended Roll", 0, 90, 0, 1))
            menu.Global_YM_Modifier = menu_items.new('Global Offset', menu.Global_Yaw_Modifier:create():slider("Offset", -180, 180, 0, 1))
        
            menu.Standing_Y_Add_Left = menu_items.new('Standing Yaw Add - Left', menu.Standing_Yaw_Add_Type:create():slider("Yaw Add - Left", -90, 90, 0, 1))
            menu.Standing_Y_Add_Right = menu_items.new('Standing Yaw Add - Right', menu.Standing_Yaw_Add_Type:create():slider("Yaw Add - Right", -90, 90, 0, 1))
            menu.Standing_E_Angel_Pitch = menu_items.new('Standing Extended Pitch', menu.Standing_Extended_Angels:create():slider("Extended Pitch", -180, 180, 0, 1))
            menu.Standing_E_Angel_Roll = menu_items.new('Standing Extended Roll', menu.Standing_Extended_Angels:create():slider("Extended Roll", 0, 90, 0, 1))
            menu.Standing_YM_Modifier = menu_items.new('Standing Offset', menu.Standing_Yaw_Modifier:create():slider("Offset", -180, 180, 0, 1))
        
            menu.Walking_Y_Add_Left = menu_items.new('Walking Yaw Add - Left', menu.Walking_Yaw_Add_Type:create():slider("Yaw Add - Left", -90, 90, 0, 1))
            menu.Walking_Y_Add_Right = menu_items.new('Walking Yaw Add - Right', menu.Walking_Yaw_Add_Type:create():slider("Yaw Add - Right", -90, 90, 0, 1))
            menu.Walking_E_Angel_Pitch = menu_items.new('Walking Extended Pitch', menu.Walking_Extended_Angels:create():slider("Extended Pitch", -180, 180, 0, 1))
            menu.Walking_E_Angel_Roll = menu_items.new('Walking Extended Roll', menu.Walking_Extended_Angels:create():slider("Extended Roll", 0, 90, 0, 1))
            menu.Walking_YM_Modifier = menu_items.new('Walking Offset', menu.Walking_Yaw_Modifier:create():slider("Offset", -180, 180, 0, 1))
        
            menu.Running_Y_Add_Left = menu_items.new('Running Yaw Add - Left', menu.Running_Yaw_Add_Type:create():slider("Yaw Add - Left", -90, 90, 0, 1))
            menu.Running_Y_Add_Right = menu_items.new('Running Yaw Add - Right', menu.Running_Yaw_Add_Type:create():slider("Yaw Add - Right", -90, 90, 0, 1))
            menu.Running_E_Angel_Pitch = menu_items.new('Running Extended Pitch', menu.Running_Extended_Angels:create():slider("Extended Pitch", -180, 180, 0, 1))
            menu.Running_E_Angel_Roll = menu_items.new('Running Extended Roll', menu.Running_Extended_Angels:create():slider("Extended Roll", 0, 90, 0, 1))
            menu.Running_YM_Modifier = menu_items.new('Running Offset', menu.Running_Yaw_Modifier:create():slider("Offset", -180, 180, 0, 1))
        
            menu.Crouching_Y_Add_Left = menu_items.new('Crouching Yaw Add - Left', menu.Crouching_Yaw_Add_Type:create():slider("Yaw Add - Left", -90, 90, 0, 1))
            menu.Crouching_Y_Add_Right = menu_items.new('Crouching Yaw Add - Right', menu.Crouching_Yaw_Add_Type:create():slider("Yaw Add - Right", -90, 90, 0, 1))
            menu.Crouching_E_Angel_Pitch = menu_items.new('Crouching Extended Pitch', menu.Crouching_Extended_Angels:create():slider("Extended Pitch", -180, 180, 0, 1))
            menu.Crouching_E_Angel_Roll = menu_items.new('Crouching Extended Roll', menu.Crouching_Extended_Angels:create():slider("Extended Roll", 0, 90, 0, 1))
            menu.Crouching_YM_Modifier = menu_items.new('Crouching Offset', menu.Crouching_Yaw_Modifier:create():slider("Offset", -180, 180, 0, 1))
        
            menu.In_Air_Y_Add_Left = menu_items.new('In_Air Yaw Add - Left', menu.In_Air_Yaw_Add_Type:create():slider("Yaw Add - Left", -90, 90, 0, 1))
            menu.In_Air_Y_Add_Right = menu_items.new('In_Air Yaw Add - Right', menu.In_Air_Yaw_Add_Type:create():slider("Yaw Add - Right", -90, 90, 0, 1))
            menu.In_Air_E_Angel_Pitch = menu_items.new('In_Air Extended Pitch', menu.In_Air_Extended_Angels:create():slider("Extended Pitch", -180, 180, 0, 1))
            menu.In_Air_E_Angel_Roll = menu_items.new('In_Air Extended Roll', menu.In_Air_Extended_Angels:create():slider("Extended Roll", 0, 90, 0, 1))
            menu.In_Air_YM_Modifier = menu_items.new('In_Air Offset', menu.In_Air_Yaw_Modifier:create():slider("Offset", -180, 180, 0, 1))
        
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

        function helpers.get_nearest_enemy(plocal, enemies)
            local local_player = entity.get_local_player()
            if not local_player or not local_player:is_alive() then return end
        
            local camera_position = render.camera_position()
        
            local camera_angles = render.camera_angles()
        
            local direction = vector():angles(camera_angles)
        
            local closest_distance, closest_enemy = math.huge
            for i = 1, #enemies do
                local enemy = entity.get(enemies[i])
                local head_position = enemy:get_hitbox_position(1)
        
                local ray_distance = head_position:dist_to_ray(
                    camera_position, direction
                )
              
                if ray_distance < closest_distance then
                    closest_distance = ray_distance
                    closest_enemy = enemy
                end
            end
        
            if not closest_enemy then
                return
            end
            return closest_enemy
        end

    local function Set_Correct_Group_Up(name)
        if Is_Group_Ready == false then return end
        for i,v in pairs(menu_items.sections) do
            if i == name then
                v:visibility(true)
            else
                v:visibility(false)
            end
        end
    end

    local function GetName(id)
        if id == 1 and menu.Allow_Global:get() then
        return 'Global'
        elseif id == 2 and menu.Allow_Standing:get() then
        return 'Standing'
        elseif id == 3 and menu.Allow_Walking:get() then
        return 'Walking'
        elseif id == 4 and menu.Allow_Running:get() then
        return 'Running'
        elseif id == 5 and menu.Allow_Crouching:get() then
        return 'Crouching'
        elseif id == 6 and menu.Allow_In_Air:get() then
        return 'In_Air'
        else
        return nil
        end
    end
    
    menu.Conditions_Table:set_callback(function()
        Set_Correct_Group_Up(GetName(menu.Conditions_Table:get()))
        Is_Group_Ready = true
    end, false)
    
    
    local function GetState()
        local Player = entity.get_local_player()
        local vec = Player.m_vecVelocity
        local velocity = math.sqrt((vec.x * vec.x) + (vec.y * vec.y))
    
        if isKeyPressed("SHIFT") then
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



    local function Global_AA(allowed)
        if allowed == false then
            if menu.Global_Yaw_Add_Type:get() == 'Jitter' then -- Static
                SwitchingWait(0.04, function()
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Global_Y_Add_Right:get())
                end, function()
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Global_Y_Add_Left:get())
                end)
            end
            if menu.Global_Yaw_Add_Type:get() == 'Static' then
                if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Global_Y_Add_Left:get())
                else
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Global_Y_Add_Right:get())
                end
            end
    
            if menu.Global_Yaw_Modifier:get() ~= "Disabled" then
                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):set(menu.Global_Yaw_Modifier:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):set(menu.Global_YM_Modifier:get())
            end
    
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):set(menu.Global_Left_Limit:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):set(menu.Global_Right_Limit:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):set(menu.Global_Options:get())
    
            if menu.Global_Extended_Angels:get() then
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):set(menu.Global_Extended_Angels:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):set(menu.Global_E_Angel_Pitch:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):set(menu.Global_E_Angel_Roll:get())
            end
        end
    end
    
    local function Standing_AA()
        -- if menu.Allow_Standing:get() then
            if menu.Standing_Yaw_Add_Type:get() == 'Jitter' then -- Static
                SwitchingWait(0.04, function()
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Standing_Y_Add_Right:get())
                end, function()
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Standing_Y_Add_Left:get())
                end)
            end
            if menu.Standing_Yaw_Add_Type:get() == 'Static' then
                if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Standing_Y_Add_Left:get())
                else
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Standing_Y_Add_Right:get())
                end
            end
    
            if menu.Standing_Yaw_Modifier:get() ~= "Disabled" then
                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):set(menu.Standing_Yaw_Modifier:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):set(menu.Standing_YM_Modifier:get())
            end
    
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):set(menu.Standing_Left_Limit:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):set(menu.Standing_Right_Limit:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):set(menu.Standing_Options:get())
    
            if menu.Standing_Extended_Angels:get() then
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):set(menu.Standing_Extended_Angels:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):set(menu.Standing_E_Angel_Pitch:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):set(menu.Standing_E_Angel_Roll:get())
            end
        -- end
    end
    
    local function Walking_AA()
        -- if menu.Allow_Walking:get() then
            if menu.Walking_Yaw_Add_Type:get() == 'Jitter' then -- Static
                SwitchingWait(0.04, function()
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Walking_Y_Add_Right:get())
                end, function()
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Walking_Y_Add_Left:get())
                end)
            end
            if menu.Walking_Yaw_Add_Type:get() == 'Static' then
                if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Walking_Y_Add_Left:get())
                else
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Walking_Y_Add_Right:get())
                end
            end
    
            if menu.Walking_Yaw_Modifier:get() ~= "Disabled" then
                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):set(menu.Walking_Yaw_Modifier:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):set(menu.Walking_YM_Modifier:get())
    
            end
    
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):set(menu.Walking_Left_Limit:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):set(menu.Walking_Right_Limit:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):set(menu.Walking_Options:get())
    
            if menu.Walking_Extended_Angels:get() then
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):set(menu.Walking_Extended_Angels:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):set(menu.Walking_E_Angel_Pitch:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):set(menu.Walking_E_Angel_Roll:get())
            end
        -- end
    end
    
    local function Running_AA()
        -- if menu.Allow_Running:get() then
            if menu.Running_Yaw_Add_Type:get() == 'Jitter' then -- Static
                SwitchingWait(0.04, function()
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Running_Y_Add_Right:get())
                end, function()
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Running_Y_Add_Left:get())
                end)
            end
            if menu.Running_Yaw_Add_Type:get() == 'Static' then
                if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Running_Y_Add_Left:get())
                else
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Running_Y_Add_Right:get())
                end
            end
    
            if menu.Running_Yaw_Modifier:get() ~= "Disabled" then
                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):set(menu.Running_Yaw_Modifier:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):set(menu.Running_YM_Modifier:get())
    
            end
    
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):set(menu.Running_Left_Limit:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):set(menu.Running_Right_Limit:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):set(menu.Running_Options:get())
    
            if menu.Running_Extended_Angels:get() then
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):set(menu.Running_Extended_Angels:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):set(menu.Running_E_Angel_Pitch:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):set(menu.Running_E_Angel_Roll:get())
            end
        -- end
    end
    
    local function Crouching_AA()
        -- if menu.Allow_Crouching:get() then
            if menu.Crouching_Yaw_Add_Type:get() == 'Jitter' then -- Static
                SwitchingWait(0.04, function()
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Crouching_Y_Add_Right:get())
                end, function()
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Crouching_Y_Add_Left:get())
                end)
            end
            if menu.Crouching_Yaw_Add_Type:get() == 'Static' then
                if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Crouching_Y_Add_Left:get())
                else
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.Crouching_Y_Add_Right:get())
                end
            end
    
            if menu.Crouching_Yaw_Modifier:get() ~= "Disabled" then
                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):set(menu.Crouching_Yaw_Modifier:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):set(menu.Crouching_YM_Modifier:get())
    
            end
    
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):set(menu.Crouching_Left_Limit:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):set(menu.Crouching_Right_Limit:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):set(menu.Crouching_Options:get())
    
            if menu.Crouching_Extended_Angels:get() then
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):set(menu.Crouching_Extended_Angels:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):set(menu.Crouching_E_Angel_Pitch:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):set(menu.Crouching_E_Angel_Roll:get())
            end
        -- end
    end
    
    local function In_Air_AA()
        -- if menu.Allow_In_Air:get() then
            if menu.In_Air_Yaw_Add_Type:get() == 'Jitter' then -- Static
                SwitchingWait(0.04, function()
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.In_Air_Y_Add_Right:get())
                end, function()
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.In_Air_Y_Add_Left:get())
                end)
            end
            if menu.In_Air_Yaw_Add_Type:get() == 'Static' then
                if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.In_Air_Y_Add_Left:get())
                else
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):set(menu.In_Air_Y_Add_Right:get())
                end
            end
    
            if menu.In_Air_Yaw_Modifier:get() ~= "Disabled" then
                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):set(menu.In_Air_Yaw_Modifier:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):set(menu.In_Air_YM_Modifier:get())
    
            end
    
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):set(menu.In_Air_Left_Limit:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):set(menu.In_Air_Right_Limit:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):set(menu.In_Air_Options:get())
    
            if menu.In_Air_Extended_Angels:get() then
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):set(menu.In_Air_Extended_Angels:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):set(menu.In_Air_E_Angel_Pitch:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):set(menu.In_Air_E_Angel_Roll:get())
            end
        -- end
    end




    function Test:Main_AA_Enable()
        if GetState() == "Walking" and menu.Allow_Walking:get() then
            Walking_AA()
        end
    
        if GetState() == "In Air" and menu.Allow_In_Air:get() then
            In_Air_AA()
        end
    
        if GetState() == "Crouching" and menu.Allow_Crouching:get() then
            Crouching_AA()
        end
    
        if GetState() == "Standing" and menu.Allow_Standing:get() then
            Standing_AA()
        end
    
        if GetState() == "Running" and menu.Allow_Running:get() then
            Running_AA()
        end
    
        if GetState() == "In Air + Crouching" and menu.Allow_In_Air:get() then
            In_Air_AA()
        end
    
        Global_AA(
        (GetState() == "Running" and menu.Allow_Running:get())or
        (GetState() == "Standing" and menu.Allow_Standing:get())or
        (GetState() == "Crouching" and menu.Allow_Crouching:get())or
        (GetState() == "In Air" and menu.Allow_In_Air:get())or
        (GetState() == "Walking" and menu.Allow_Walking:get())or
        (GetState() == "In Air + Crouching" and menu.Allow_In_Air:get())
    )
    end



    function Test:WhenWalkIsON(cmd)
        local move_vec = vector(cmd.forwardmove,0,cmd.sidemove)
        move_vec:normalize()
        move_vec = move_vec:scale(menu.Walk_Speed:get())
    
        if menu.SlowWalk:get() then
            cmd.forwardmove = move_vec.x
            cmd.sidemove = move_vec.z
        end
        if ui.find("Aimbot", "Anti Aim", "Misc", "Slow Walk"):get() then;ui.find("Aimbot", "Anti Aim", "Misc", "Slow Walk"):override(false)end
    end
    
    function Visible(object, swi)
        object:visibility(swi:get())
    end
    
    menu.ClanTag = menu_items.new('Clan Tag', Misc_Group:switch("Clan Tag", false))
    menu.ClanTag_Speed = menu_items.new('Clan Tag Speed', Misc_Group:slider("Clan Tag Speed", 0, 20, 1.0, 1))
    menu.Custom_Clantag = menu_items.new('Custom Clan Tag', Misc_Group:switch("Custom Clan Tag"))
    menu.Custom_Clantag_Text = menu_items.new('Custom Clan Text', Misc_Group:input("Custom Clan Text", ""))
    menu.Aspect_Ratio_switch = menu_items.new('Aspect Ratio', Misc_Group:switch("Aspect Ratio", false))
    menu.slider_Aspect_Ratio = menu_items.new('Value', Misc_Group:slider("Value", 0, 20, 1.0, 0.1))
    menu.viewmodel = menu_items.new('Custom Viewmodel', Misc_Group:switch("Custom Viewmodel"):tooltip("Allow to change viewmodel fov"))
    menu.fov = menu_items.new('Fov', Misc_Group:slider("Fov", 0, 100, 90))
    menu.x = menu_items.new('X', Misc_Group:slider("X", - 15, 15, 0, 1))
    menu.y = menu_items.new('Y', Misc_Group:slider("Y", - 15, 15, 0, 1))
    menu.z = menu_items.new('Z', Misc_Group:slider("Z", - 15, 15, 0, 1))
    
    menu.slider_Aspect_Ratio:set_callback(function ()
        if menu.Aspect_Ratio_switch:get() then
            cvar.r_aspectratio:float(menu.slider_Aspect_Ratio:get() / 10)
        end
    end, false)
    
    menu.Aspect_Ratio_switch:set_callback(function ()
        cvar.r_aspectratio:float(menu.Aspect_Ratio_switch:get() and menu.slider_Aspect_Ratio:get() / 10 or 0)
    end, true)
    
    function Test:Viewmodelfunc()
        menu.fov:visibility(menu.viewmodel:get())
        menu.x:visibility(menu.viewmodel:get())
        menu.y:visibility(menu.viewmodel:get())
        menu.z:visibility(menu.viewmodel:get())
    
        if menu.viewmodel:get() then
            cvar["sv_competitive_minspec"]:int(0)
            cvar["viewmodel_fov"]:float(menu.fov:get())
            cvar["viewmodel_offset_x"]:float(menu.x:get() * 0.5)
            cvar["viewmodel_offset_y"]:float(menu.y:get())
            cvar["viewmodel_offset_z"]:float(menu.z:get())
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
        menu.ClanTag_Speed:visibility(menu.ClanTag:get())
        menu.Custom_Clantag:visibility(menu.ClanTag:get())
    
        if not menu.ClanTag:get() then
            return
        end
    
        if menu.Custom_Clantag:get() then
            return
        end
    
        updateCounter = updateCounter + 1
    
        if updateCounter < updateInterval then
            return
        end
    
        updateCounter = 0
    
        wait(menu.ClanTag_Speed:get(), function()
            TagNum = TagNum + 1
            common.set_clan_tag(Tag_Table[TagNum])
    
            if #Tag_Table == TagNum then
                TagNum = 0
            end
        end)
    end
    
    function CustomClanTag()
        menu.Custom_Clantag_Text:visibility(menu.Custom_Clantag:get())
    
        if not menu.Custom_Clantag:get() then
            return
        end
    
        if not menu.ClanTag:get() then
            return
        end
    
        local CTag_Table = MakeCustomTag(menu.Custom_Clantag_Text:get())
    
        updateCounter = updateCounter + 1
    
        if updateCounter < updateInterval then
            return
        end
    
        updateCounter = 0
    
        wait(menu.ClanTag_Speed:get() * 0.1, function()
            CTagNum = CTagNum + 1
            common.set_clan_tag(CTag_Table[CTagNum])
    
            if #CTag_Table == CTagNum then
                CTagNum = 0
            end
        end)
    end
    
    -- menu.Trash_Switch = menu_items.new('Trash Talk', Trash_Talk:switch("Trash Talk"))
    menu.Support_Switch = menu_items.new('Support Me', Trash_Talk:switch("Support Me"))
    menu.n1_Switch = menu_items.new('1', Trash_Talk:switch("1"))
    menu.Custom_Switch = menu_items.new('Custom on kill', Trash_Talk:switch("Custom on kill"))
    
    menu.Inp1 = menu_items.new('Inp 1', menu.Custom_Switch:create():input("Inp 1", "neverlose.cc/market/item?id=LMaW6X"))
    menu.Inp2 = menu_items.new('Inp 2', menu.Custom_Switch:create():input("Inp 2", "Get Mana.lua! neverlose.cc/market/item?id=LMaW6X"))
    menu.Inp3 = menu_items.new('Inp 3', menu.Custom_Switch:create():input("Inp 3", "Howdy get 1 in you but"))
    
    -- menu.Trash_Switch:set_callback(function()
    --     for i,v in pairs(TrashTalk_Table.main) do
    --         Visible(v, menu.Trash_Switch)
    --     end
    -- end, false)
    
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
            menu.Inp1:get(),
            menu.Inp2:get(),
            menu.Inp3:get()
        }
        local target = e.target
        local get_target_entity = entity.get(target)
        if not get_target_entity then return end
        
        local health = get_target_entity.m_iHealth
    
        if not target:get_name() or not health then return end
        
        -- if not menu.Trash_Switch:get() then return end
        if health == 0 then
            if menu.Support_Switch:get() then
                utils.console_exec("say " .. (Support_Table[math.random(1, #Support_Table)]):format(target:get_name()))
            end
            if menu.n1_Switch:get() then
                utils.console_exec("say " .. (n1_table[math.random(1, #n1_table)]):format(target:get_name()))
            end
            if menu.Custom_Switch:get() then
                utils.console_exec("say " .. (Custom_Table[math.random(1, #Custom_Table)]):format(target:get_name()))
            end
        end
    end)
    
    -- menu.Rage_Switch = menu_items.new('Rage', Rage_Group:switch("Rage"))
    menu.JumpScout = menu_items.new('Jump Scout Fix', Rage_Group:switch("Jump Scout Fix", false))
    menu.AX = menu_items.new('Anti Exploit', Rage_Group:switch("Anti Exploit"))
    
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
    
    function Test:ragebot()
        for i, v in pairs(weapons) do
            local exploit_state = rage.exploit:get()
            local entity_ID = helpers.get_nearest_enemy(entity.get_local_player(), entity.get_players(true))
    
            local only_head = ui_ragebot[i].only_head:get()
            local FBM = ui_ragebot[i].Force_Baim_Health:get()
            local FBMV = ui_ragebot[i].Force_Baim_Health_value:get()
            local FC = ui_ragebot[i].Force_Conditions:get()
            local FCB = ui_ragebot[i].Force_Conditions_Baim
            local FCH = ui_ragebot[i].Force_Conditions_Head
    
            ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(only_head and "Head" or nil)
            ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(only_head and "Head" or nil)
    
    
                    if FBM then
                        ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FBM and entity_ID.m_iHealth < FBMV and "Chest" or nil, FBM and "Stomach" or nil)
                        ui.find("Aimbot", "Ragebot", "Safety", v, "Body Aim"):override(FBM and entity_ID.m_iHealth < FBMV and "Force" or nil)
                    end
    
                    if FC then
                        local Player = entity_ID --entity.get(entity_ID)
                        local vec = Player.m_vecVelocity
                        local velocity = math.sqrt((vec.x * vec.x) + (vec.y * vec.y))
                        
                        -- Head
                        if Player.m_fFlags == 256 and FCH:get("In Air") then -- In Air
                            ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCH:get("In Air") and exploit_state == 0 and Player.m_fFlags == 256 and entity_ID.m_iHealth > FBMV and "Head" or nil)
                        elseif Player.m_flDuckAmount > 0.8 and FCH:get("Crouching") then -- Crouching
                            ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCH:get("Crouching") and exploit_state == 0 and Player.m_flDuckAmount > 0.8 and entity_ID.m_iHealth > FBMV and "Head" or nil)
                            ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCH:get("Crouching") and exploit_state == 0 and Player.m_flDuckAmount > 0.8 and entity_ID.m_iHealth > FBMV and "Head" or nil)
                        elseif velocity <= 2 and FCH:get("Standing") then -- Standing
                            ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCH:get("Standing") and exploit_state == 0 and velocity <= 2 and entity_ID.m_iHealth > FBMV and "Head" or nil)
                            ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCH:get("Standing") and exploit_state == 0 and velocity <= 2 and entity_ID.m_iHealth > FBMV and "Head" or nil)
                        elseif velocity >= 3 and FCH:get("Running") then -- Running
                            ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCH:get("Running") and exploit_state == 0 and velocity >= 3 and entity_ID.m_iHealth > FBMV and "Head" or nil)
                            ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCH:get("Running") and exploit_state == 0 and velocity >= 3 and entity_ID.m_iHealth > FBMV and "Head" or nil)
                        else
                            if FCH:get("Developer") then
                                ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCH:get("Developer") and exploit_state == 0 and entity_ID.m_iHealth > FBMV and "Head" or nil)
                                ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCH:get("Developer") and exploit_state == 0 and entity_ID.m_iHealth > FBMV and "Head" or nil)
                            end
                        end
    
                        -- Baim
                        if Player.m_fFlags == 256 and FCB:get("In Air") then -- In Air
                            ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCB:get("In Air") and Player.m_fFlags == 256 and entity_ID.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)
                            ui.find("Aimbot", "Ragebot", "Safety", v, "Body Aim"):override(FCB:get("In Air") and Player.m_fFlags == 256 and entity_ID.m_iHealth > FBMV and "Force" or nil)
                        elseif Player.m_flDuckAmount > 0.8 and FCB:get("Crouching") then -- Crouching
                            ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCB:get("Crouching") and Player.m_flDuckAmount > 0.8 and entity_ID.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)
                            ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCB:get("Crouching") and Player.m_flDuckAmount > 0.8 and entity_ID.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)
                        elseif velocity <= 2 and FCB:get("Standing") then -- Standing
                            ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCB:get("Standing") and velocity <= 2 and entity_ID.m_iHealth > FBMV and "Chest" and "Stomach" or nil)
                            ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCB:get("Standing") and velocity <= 2 and entity_ID.m_iHealth > FBMV and "Chest" and "Stomach" or nil)
                        elseif velocity >= 3 and FCB:get("Running") then -- Running
                            ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCB:get("Running") and velocity >= 3 and entity_ID.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)
                            ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCB:get("Running") and velocity >= 3 and entity_ID.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)
                        else
                            if FCB:get("Developer") then
                                ui.find("Aimbot", "Ragebot", "Selection", v, "Hitboxes"):override(FCB:get("Developer") and entity_ID.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)
                                ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint"):override(FCB:get("Developer") and entity_ID.m_iHealth > FBMV and "Chest" or nil, FBM and "Stomach" or nil)
                            end
                        end
                    end
    
        end
    end
    
    local Autostrafe = ui.find("Miscellaneous", "Main", "Movement", "Air Strafe")
    
    function Test:JumpScoutFix()
        if not menu.JumpScout:get() then return end
        local local_player = entity.get_local_player()
        local math_velocity = math.sqrt(local_player.m_vecVelocity.x ^ 2 + local_player.m_vecVelocity.y ^ 2)
        Autostrafe:set(math_velocity >= 5 and csgo_weapons(local_player:get_player_weapon()).name == "SSG 08" or csgo_weapons(local_player:get_player_weapon()).name ~= "SSG 08")
    end
    
    function Test:AntiExploit()
        if menu.AX:get() then 
            cvar.cl_lagcompensation:int(0)
        else 
            cvar.cl_lagcompensation:int(1)
        end
    end
    
    function Test:tick()
        frameCounter = frameCounter + 1
    
        if frameCounter < frameInterval then
            return
        end
    
        frameCounter = 0
    
        Clan_Tag()
        CustomClanTag()
    end
    
    
    menu.defensive = menu_items.new('Defensive Anti Aim', ui.find("Aimbot", "Anti Aim", "Angles"):switch("Defensive Anti Aim"))
    
    menu.pitch = menu_items.new('Pitch', menu.defensive:create():combo("Pitch", {"Zero", "Up", "Down", "Random", "Jitter", "45 deg"}))
    menu.yaw = menu_items.new('Yaw', menu.defensive:create():combo("Yaw", {"Static", "Random", "Side-Way", "Spin"}))
    menu.Weapons = menu_items.new('Weapon', menu.defensive:create():selectable("Weapon", {"AWP", "SSG 08", "AutoSnipers", "Global"}))
    menu.inair = menu_items.new('Only In air', menu.defensive:create():switch("Only In air"))
    menu.spin = menu_items.new('Spin speed', menu.defensive:create():slider("Spin speed", 120, 7200, 1300))
    
    menu_items.Main_Anti_Defensive = {
        main = {
            fs = ui.find("Aimbot", "Anti Aim", "Angles", "Freestanding"),
            hidden = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Hidden"),
            lag_options = ui.find("Aimbot", "Ragebot", "Main", "Double Tap", "Lag Options"),
        }
    }
    
    function GetSelectedWeapons(name)
        if name == "SCAR-20" and menu.Weapons:get("AutoSnipers") then
            return true
        end
        if name == "G3SG1" and menu.Weapons:get("AutoSnipers") then
            return true
        end
        if name == "SSG 08" and menu.Weapons:get("SSG 08") then
            return true
        end
        if name == "AWP" and menu.Weapons:get("AWP") then
            return true
        end
        return false
    end
    
    local Allowed_Players = {'Mana421328'}
    
    function Test:Better_Rage()
        if not TableFind(Allowed_Players, common.get_username()) then return end
        local exploit_state = rage.exploit:get()
        local localplayer = entity.get_local_player()
    
        if exploit_state ~= 0 and csgo_weapons(localplayer:get_player_weapon()).name == "SSG 08" then
            ui.find("Aimbot", "Ragebot", "Main", "Double Tap", "Fake Lag Limit"):override(math.random(1, 4))
            ui.find("Aimbot", "Ragebot", "Main", "Double Tap", "Lag Options"):override('Disabled')
        end
    
        if exploit_state ~= 0 and (csgo_weapons(localplayer:get_player_weapon()).name == "G3SG1" or csgo_weapons(localplayer:get_player_weapon()).name == "SCAR-20") then
            ui.find("Aimbot", "Ragebot", "Main", "Double Tap", "Fake Lag Limit"):override(1)
            ui.find("Aimbot", "Ragebot", "Main", "Double Tap", "Lag Options"):override('Always On')
        end
    end
    
    function Test:defensive_aa()
        local exploit_state = rage.exploit:get() -- Defensive need always lag
    
        local localplayer = entity.get_local_player()
        if not localplayer then return end
    
        local prop = localplayer["m_fFlags"]
    
        local pitch_settings = menu.pitch:get()
        local yaw_settings = menu.yaw:get()
    
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
            yaw_override = (globals.curtime * menu.spin:get()) % 360 - 180
        end
    
        if menu.defensive:get() and (GetSelectedWeapons(csgo_weapons(localplayer:get_player_weapon()).name) or menu.Weapons:get("Global")) and exploit_state ~= 0 or (isKeyPressed("space") and menu.In_Air_Crazy_AA:get()) then
    
            menu_items.Main_Anti_Defensive.main.hidden:override(true)
    
            if menu.inair:get() then
                if prop == 256 or prop == 262 then
                    rage.antiaim:override_hidden_pitch(pitch_override)
                    rage.antiaim:override_hidden_yaw_offset(yaw_override)
                    if not TableFind(Allowed_Players, common.get_username()) then menu_items.Main_Anti_Defensive.main.lag_options:override("Always On") end
                else
                    rage.antiaim:override_hidden_pitch(pitch_override)
                    rage.antiaim:override_hidden_yaw_offset(yaw_override)
                    if not TableFind(Allowed_Players, common.get_username()) then menu_items.Main_Anti_Defensive.main.lag_options:override() end
                    -- menu_items.Main_Anti_Defensive.main.lag_options:override()
                end
            else
                rage.antiaim:override_hidden_pitch(pitch_override)
                rage.antiaim:override_hidden_yaw_offset(yaw_override)
                if not TableFind(Allowed_Players, common.get_username()) then menu_items.Main_Anti_Defensive.main.lag_options:override("Always On") end
                -- menu_items.Main_Anti_Defensive.main.lag_options:override("Always On")
            end
        else
            menu_items.Main_Anti_Defensive.main.hidden:override()
            menu_items.Main_Anti_Defensive.main.fs:override()
            if not TableFind(Allowed_Players, common.get_username()) then menu_items.Main_Anti_Defensive.main.lag_options:override() end
            -- menu_items.Main_Anti_Defensive.main.lag_options:override()
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
    visuals.hitlog = {}
    
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
    
    visuals.hitlog.vars = {
        alpha = {
            [ '' ] = 0
        },
        window = {
            alpha = 0,
            width = 0
        }
    }
    
    visuals.keybinds.dragging = helpers.dragging_fn('KeyBinds', helpers.screen_size.x / 1.3, helpers.screen_size.y / 2.5)
    
    menu.Selected_KeyBind = menu_items.new('KeyBinds', Visuals_Group:selectable("KeyBinds", {"Jagoyaw", "Skeet (soon)"}))
    menu.Watermark_switch = menu_items.new('Watermark', Visuals_Group:switch("Watermark", true))
    menu.Branche = menu_items.new('Accent', Visuals_Colors:color_picker("Accent", color(142, 165, 229,255)):visibility(false))
    
    menu.Watermark_switch:set_callback(function()
        menu.Branche:visibility(menu.Watermark_switch:get())
        ui.find("Miscellaneous", "Main", "Other", "Windows"):set("Watermark off")
    end, true)
    
    menu.Selected_KeyBind:set_callback(function()
        menu.Branche:visibility(menu.Selected_KeyBind:get("Jagoyaw"))
        ui.find("Miscellaneous", "Main", "Other", "Windows"):set("Hotkeys off")
    end, true)
    
    function Test:Watermark()
        local speed = globals.frametime * 5
        local color_ref = menu.Branche:get()
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
    
        text = text .. script_db.lua_name .. ' [ '.. script_db.lua_version ..' ] | ' .. script_db.username .. ' | '
    
        local local_time = common.get_system_time()
    
        local time = string.format("%02d:%02d:%02d", local_time.hours, local_time.minutes, local_time.seconds)
    
        local ping = globals.is_in_game and math.floor(utils.net_channel().avg_latency[1] * 1000) or 0
    
        text = text .. 'delay: ' .. ping .. 'ms | ' .. time
    
        local text_size = render.measure_text(1, '', text)
    
        pos.x = pos.x - text_size.x
        pos.w = text_size.x
        pos.h = 16
    
        -- if UI.get('ui_style') == 0 then
            visuals.global_render.box(pos.x - 10, pos.y, pos.w + 10, {r=menu.Branche:get().r, g=menu.Branche:get().g, b=menu.Branche:get().b, a=menu.Branche:get().a or 255})
    
            visuals.base_render.string(pos.x - 10 + 6, pos.y + text_size.y / 2 - 0.1, false, text, color(255, 255, 255, 255), 1, 1)
        -- elseif UI.get('ui_style') == 1 then
        --     visuals.Render_engine.container(pos.x - 9, pos.y, pos.w + 9, pos.h, { r = color.r, g = color.g, b = color.b, a = 1 }, text, fonts.verdanar11.size, fonts.verdanar11.font)
        -- end
    
    end
    
    
    function Test:keybinds_draw()
        if menu.Selected_KeyBind:get("Jagoyaw") then
            local speed = globals.frametime * 5
            local color_ref = menu.Branche:get()
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
    
                if bind_state == "0" then
                    visuals.base_render.string(pos.x + (visuals.keybinds.vars.window.width - bind_state_size.x - 10), pos.y + 20 + offset, false, '[' .. 'Auto' .. ']', color(255, 255, 255, alpha*255), 1, 1)
                else
                    visuals.base_render.string(pos.x + (visuals.keybinds.vars.window.width - bind_state_size.x - 10), pos.y + 20 + offset, false, '[' .. bind_state .. ']', color(255, 255, 255, alpha*255), 1, 1)
    
                end
    
                -- if UI.get('ui_style') == 0 then
                    visuals.base_render.string(pos.x + 4, pos.y + 21 + offset, false, bind_name, color(255, 255, 255, alpha*255), 1, 1)
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
                visuals.global_render.box(pos.x, pos.y - 2, pos.w + 2, {r=menu.Branche:get().r, g=menu.Branche:get().g, b=menu.Branche:get().b, a=menu.Branche:get().a or 255})
    
                local main_text = render.measure_text(1, nil, 'keybinds')
        
                visuals.base_render.string(pos.x + 1 + pos.w / 2, pos.y + main_text.y - 3, true, 'keybinds', color(255, 255, 255, window_alpha * 255), 1, 1)
            -- elseif UI.get('ui_style') == 1 then
                -- visuals.Render_engine.container(pos.x, pos.y, pos.w, pos.h, { r = color.r, g = color.g, b = color.b, a = window_alpha }, 'keybinds', fonts.verdanar11.size, fonts.verdanar11.font)
            -- end
    
            visuals.keybinds.dragging:drag(pos.w, (10 + (8 * #binds)) * 2)
        end
    end
    
    
    local logs = {}
    local logSpacing = 25  -- Adjust the spacing between log entries as needed
    
    function add_log(text, miss)
        table.insert(logs, 1, { text = text, miss = miss, expiration = 5 })
    end
    
    function Test:Hit_Logs_Testing()
        local color_ref = menu.Branche:get()
        local Miss_Color
        local pos = { x = 0, y = 0, w = 50 }
        pos.x, pos.y = render.screen_size().x/2 - 70, render.screen_size().y / 2 + 200
        pos.x = math.ceil(pos.x)
        pos.y = math.ceil(pos.y)
        
        local binds = logs
        local text = ''
        for i = 1, #binds do
            local bind = binds[i]
            pcall(function()
                text = bind.text
            end)
    
            local Box_Size = 15
            local text_size = render.measure_text(1, '', text)
    
            pos.w = text_size.x
            
            pcall(function()
                if bind.miss == false then
                    Miss_Color = color(255, 50, 50)
                else
                    Miss_Color = color_ref
                end
            end)
    
            -- Calculate position for each log entry (making them go upwards)
            local logY = pos.y + (i - 1) * logSpacing
            
            visuals.global_render.box(pos.x, logY, pos.w + Box_Size, { r = Miss_Color.r, g = Miss_Color.g, b = Miss_Color.b, a = 255 })
    
            local centerX = pos.x + (pos.w + Box_Size) / 2
            local centerY = logY + 8
    
            local textX = centerX - text_size.x / 2
            local textY = centerY - text_size.y / 2
    
            visuals.base_render.string(textX, textY, false, text, color(255, 255, 255), 1, 1)
    
            -- Check if the log entry has expired and remove it
            pcall(function()
                if bind.expiration <= 0 then
                    table.remove(logs, i)
                else
                    -- Decrement the expiration time
                    bind.expiration = bind.expiration - globals.frametime
                end
            end)
        end
    end
    
    
    local lucida = render.load_font("C:\\Windows\\Fonts\\lucon.ttf", 10, "d")
    
    local hb = {
        [0] = 'generic',
        'head', 'chest', 'stomach',
        'left arm', 'right arm',
        'left leg', 'right leg',
        'neck', 'generic', 'gear'
    }
    local reason =
    {
        ["spread"] = "spread" ,
        ["correction"]= "?" ,
        ["occlusion"] = "spread",
        ["jitter correction"] = "?" ,
        ["prediction error"] = "prediction error" ,
        ["lagcomp failure"] = "?"
    }
    
    function log_log()
        if #logs <= 0 then
            return
        end
    
        local x = 8
        local y = 5
        local size = 12 + 1
    
        for i = 1, #logs do
            local notify = logs[ i ]
    
            if not notify then end
    
            logs[ i ].expiration = logs[ i ].expiration - globals.frametime
    
            if logs[ i ].expiration <= 0.0 then
                table.remove( logs, i )
            end
        end
    
        for i = 1, #logs do
            local notify = logs[ i ]
    
            if not notify then end
    
            local left = logs[ i ].expiration
            local color = color( )
          
            if left <= 0.5 then
                local f = left;
                math.clamp( f, 0.0, 0.5 )
    
                f = f / 0.5;
    
                color.a = math.floor( f * 255.0 )
    
                if i == 1 and f <= 0.2 then
                    y = y - ( size * ( 1.0 - f / 0.2 ) )
                end
            else
                color.a = 255
            end
    
            render.text( lucida, vector( x, y ), color, "", logs[ i ].text )
            y = y + size
        end
    end
    
    local TICKS_TO_TIME = function(ticks)
        return globals.tickinterval * ticks
    end
    
    local print_skeet = function( ctx )
        local col = color( 220, 220, 220, 255 )
        local col_str = col:to_hex( )
        local acc = color( 160, 203, 39 )
        local acc_str = acc:to_hex( )
        print_raw( string.format( "\a%s[gamesense] \a%s%s", acc_str:sub(0, 6), col_str:sub( 0 , 6 ), ctx ) )
    end
    
    function Test:on_hit( ctx )
        local name = ctx.target:get_name()
        local hitgroup_ = hb[ctx.hitgroup]
        local hitgroup = hb[ctx.wanted_hitgroup]
        local bt_ms = math.floor(TICKS_TO_TIME(ctx.backtrack) * 1000)
        local random1 = math.random(0,1000)
        local random12 = math.random(0,1000)
        local random13 = math.random(0,1000)
        local random2 = math.random(0,9)
        local random22 = math.random(0,9)
        local random23 = math.random(0,9)
        local random24 = math.random(0,9)
        local random25 = math.random(0,9)
        local random3 = math.random(0,58)
        local random4 = math.random(0,20)
        local random5 = math.random(0,20)
        local health = ctx.target.m_iHealth
        local wanted_dmg_str = ctx.damage ~= ctx.wanted_damage and string.format("(%i)", ctx.wanted_damage) or ""
        local string = string.format("Registred shot at "..RGBToColorString('%s', {r=menu.Branche:get().r, g=menu.Branche:get().g, b=menu.Branche:get().b, a=menu.Branche:get().a or 255}).." for %i dammage",name, ctx.damage)
    
        add_log(string, true)
    end
    
    function Test:on_miss( ctx )
    
        local name = ctx.target:get_name()
        local hitgroup = hb[ctx.wanted_hitgroup]
        local reason = reason[ctx.state]
        local bt_ms = math.floor(TICKS_TO_TIME(ctx.backtrack) * 1000)
        local random1 = math.random(0,1000)
        local random12 = math.random(0,1000)
        local random13 = math.random(0,1000)
        local random2 = math.random(0,9)
        local random22 = math.random(0,9)
        local random23 = math.random(0,9)
        local random24 = math.random(0,9)
        local random25 = math.random(0,9)
        local random3 = math.random(0,58)
        local random4 = math.random(0,20)
        local random5 = math.random(0,20)
    
    
        add_log(string.format('Missed '..RGBToColorString('%s', color(130, 95, 208, 255))..' due to %s', name, reason), false)
    end
    
    -- events.aim_ack:set( function( ctx )
    
        -- if ctx.state then
        --     on_miss( ctx )
        --     return
        -- end
    
        -- on_hit(ctx)
    -- end)
    
    -- common.add_notify("Welcome", tostring(common.get_username()))
    
    function once_callback()
        ragebot_item()
    end
    
    -- events.aim_fire(function(e)
        -- ScoutReady = true
        -- print(e.id, e.target, e.damage, e.hitchance, e.hitgroup, e.backtrack, e.aim, e.angle)
    -- end)
    
    once_callback()
    
    local function GetCFG()
        clipboard.set(files.read(Configs_Path.."\\"..Configs:get()..".lua"))
    end
    
    CFG_create:set_callback(function()
        local new_data = {}
        local Config_Data_Open = json.parse(files.read(Config_Data))
        for i,v in pairs(Config_Data_Open) do table.insert(new_data, v)end
        table.insert(new_data, CFG_Name:get())
        files.write('nl\\mana\\configs.json', json.stringify(new_data))
    
            local cfg_data = {}
            for i, v in pairs(menu_items.Items) do
                local ui_value = v:get()
                if type(ui_value) == "userdata" then
                    cfg_data[i] = ui_value:to_hex()
                else
                    cfg_data[i] = ui_value
                end
            end
    
            local json_config = json.stringify(cfg_data)
            local encoded_config = base64.encode(json_config)
            files.write(Configs_Path.."\\"..CFG_Name:get()..".lua", "Mana_"..encoded_config)
            Configs:update(json.parse(files.read(Config_Data)))
            CFG_Name:set("")
    end, false)
    
    local function config_load(text)
            local text = base64.decode(text)
            local cfg_data = json.parse(text)
            if cfg_data ~= nil then
                for key, value in pairs(cfg_data) do
                    local item = menu_items.Items[key]
                    if item ~= nil then
                        local invalue = value
                        item:set(invalue)
                    end
                end
            end
    end
    
    local function config_save()
        local cfg_data = {}
        for i, v in pairs(menu_items.Items) do
            local ui_value = v:get()
            if type(ui_value) == "userdata" then
                cfg_data[i] = ui_value:to_hex()
            else
                cfg_data[i] = ui_value
            end
        end
    
        local json_config = json.stringify(cfg_data)
        local encoded_config = base64.encode(json_config)
        files.write(Configs_Path.."\\"..Configs:get()..".lua", "Mana_"..encoded_config)
        Configs:update(json.parse(files.read(Config_Data)))
        common.add_notify(RGBToColorString('Mana.Lua', color(155,155,255,255)), "Saved Config to "..RGBToColorString(Configs:get(), color(122,122,255,255)))
    end
    
    CFG_load:set_callback(function()
        config_load(files.read(Configs_Path.."\\"..Configs:get()..".lua"):gsub("Mana_", ""))
        common.add_notify("Mana.Lua", Configs:get().." has been Loaded!")
    end)
    
    CFG_load:set_callback(function()
        config_load(files.read(Configs_Path.."\\"..Configs:get()..".lua"):gsub("Mana_", ""))
    end)
    
    CFG_save:set_callback(function()
        config_save()
    end)
    
    import_cfg:set_callback(function()
        config_load(clipboard.get():gsub("Mana_", ""))
    end)
    
    export_cfg:set_callback(function()
        GetCFG()
    end)
    
    CFG_ConfirmDeletion_Yes:set_callback(function()
        CFG_ConfirmDeletion_Yes:visibility(false)
        CFG_ConfirmDeletion_No:visibility(false)
    
        local Config_Data_Open = json.parse(files.read(Config_Data))
    
        local dataToRemove = Configs:get()
    
        local function remove(jsonArray, itemToRemove)
            for i, item in ipairs(jsonArray) do
                if item == itemToRemove then
                    table.remove(jsonArray, i)
                    return true
                end
            end
            return false
        end
        if remove(Config_Data_Open, dataToRemove) then
            local updatedData = json.stringify(Config_Data_Open)
            files.write(Config_Data, updatedData)
            common.add_notify(RGBToColorString('Mana.Lua', color(155,155,255,255)), "Deleted "..Configs:get())
        else
            common.add_notify(RGBToColorString('Mana.Lua', color(155,155,255,255)), "There is no such config!")
        end
        Configs:update(json.parse(files.read(Config_Data)))
    end)
    
    CFG_ConfirmDeletion_No:set_callback(function()
        CFG_ConfirmDeletion_Yes:visibility(false)
        CFG_ConfirmDeletion_No:visibility(false)
        Configs:update(json.parse(files.read(Config_Data)))
    end)

end
return Test
    
