#include "..\script_component.hpp"

// Chat commands
["saveMission", {
    ["Saved mission and all players", "", true] call FUNC(info);
    [QEGVAR(EH,saveMissionState), [format["%1 (%2)", name player, getPlayerUID player]]] call CBA_fnc_serverEvent;
}, "adminLogged"] call CBA_fnc_registerChatCommand;

["save", {
    ["Saved", "", true] call FUNC(info);
    [QEGVAR(EH,savePlayerState), [format["%1 (%2)", name player, getPlayerUID player], player]] call CBA_fnc_serverEvent;
}, "all"] call CBA_fnc_registerChatCommand;

["removeSaveMission", {
    ["Removed all save data", "", true] call FUNC(info);
    [QEGVAR(EH,clearMissionState), [format["%1 (%2)", name player, getPlayerUID player]]] call CBA_fnc_serverEvent;
}, "admin"] call CBA_fnc_registerChatCommand;

if (!isServer) exitWith {};


// Global ID init number
PROFILE_ID_NUMBER = 0;


// Create save folder
private _saveHashMap = profileNamespace getVariable [QEGVAR(missionProfiledObjects,SavedUnits), createHashMap];
if (count _saveHashMap == 0) exitWith {
    profileNamespace setVariable [QEGVAR(missionProfiledObjects,SavedUnits), createHashMap];
};


// Event Handlers
[QEGVAR(EH,saveMissionState), {
    _this params[
        ["_triggerer", "server", [""]]
    ];
    [formatText["Full save event triggerd by %1...", _triggerer]] call FUNC(info);
    
    call FUNC(saveMissionState)
}] call CBA_fnc_addEventHandlerArgs;

[QEGVAR(EH,savePlayerState), {
    _this params[
        ["_triggerer", "server", [""]],
        ["_object", objNull, [objNull]]
    ];
    [formatText["Player save event triggerd by %1...", _triggerer]] call FUNC(info);
    [_object] call FUNC(saveObject);
}] call CBA_fnc_addEventHandlerArgs;

[QEGVAR(EH,clearMissionState), {
    _this params[
        ["_triggerer", "server", [""]]
    ];
    [formatText["Clear save event triggerd by %1...", _triggerer]] call FUNC(info);
    
    call FUNC(removeProfileData);
    endMission "CONTINUE";
}] call CBA_fnc_addEventHandlerArgs;


// Connections
addMissionEventHandler ["HandleDisconnect", {
    params ["_unit", "_id", "_uid", "_name"];
    [QEGVAR(EH,saveMissionState)] call CBA_fnc_serverEvent;
    true;
}, []];

addMissionEventHandler ["PlayerConnected", {
    params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
    player call FUNC(profile);
}];