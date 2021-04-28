#include "..\script_component.hpp"

params[["_player", objNull, [objNull]]];

if (!isServer) exitWith {};

private _saveHashMap = profileNamespace getVariable QEGVAR(missionProfiledObjects,SavedUnits);
if (!isNil {_saveHashMap get getPlayerUID _player}) then {
    private _saveData = _saveHashMap get getPlayerUID _player;
    [formatText["Restoring state of player %1...", name _player, _saveData]] call FUNC(info);

    _player setVariable [QGVAR(objData), _saveData];
    _player setPos _saveData#1;
    _player setDir _saveData#2;
    _player setUnitLoadout _saveData#5;
    
} else {
    [_player, true] call FUNC(saveObject);
};

_player addMPEventHandler ["MPRespawn", {
    params ["_player", "_corpse"];
    [_player] call FUNC(saveObject); 
}];

_player addEventHandler ["GetOutMan", {
	params ["_player", "_role", "_vehicle", "_turret"];
    [_player] call FUNC(saveObject); 
}];

_player addEventHandler ["GetInMan", {
	params ["_player", "_role", "_vehicle", "_turret"];
    [_player] call FUNC(saveObject); 
}];

_player addEventHandler ["InventoryClosed", {
	params ["_player", "_container"];
    [_player] call FUNC(saveObject); 
}];