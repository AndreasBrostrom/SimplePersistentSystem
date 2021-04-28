#include "..\script_component.hpp"

if (!isServer) exitWith {};

private _saveHashMap = profileNamespace getVariable QEGVAR(missionProfiledObjects,SavedUnits);

{
    _x params["_unit"];
    if (!isNil {_saveHashMap get str _unit}) then {
        [_unit] call FUNC(saveObject);
    };
} forEach vehicles + allUnits + allPlayers;

true