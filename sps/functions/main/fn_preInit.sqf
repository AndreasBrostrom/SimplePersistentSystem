#include "..\script_component.hpp"

// Chat commands
["saveMission", {
    [QEGVAR(EH,saveMissionState), [format["%1 (%2)", name player, getPlayerUID player]]] call CBA_fnc_serverEvent;
}, "all"] call CBA_fnc_registerChatCommand;

["save", {
    [QEGVAR(EH,savePlayerState), [format["%1 (%2)", name player, getPlayerUID player], player]] call CBA_fnc_serverEvent;
}, "all"] call CBA_fnc_registerChatCommand;

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

addMissionEventHandler ["HandleDisconnect", {
	params ["_unit", "_id", "_uid", "_name"];
    [QEGVAR(EH,saveMissionState)] call CBA_fnc_serverEvent;
    true;
}, []];

addMissionEventHandler ["PlayerConnected", {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
    player call FUNC(profile);
}];