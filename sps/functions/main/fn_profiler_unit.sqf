#include "..\script_component.hpp"

params[["_unit", objNull, [objNull]]];

if (!isServer) exitWith {};

private _saveHashMap = profileNamespace getVariable QEGVAR(missionProfiledObjects,SavedUnits);
if (!isNil {_saveHashMap get str _unit}) then {
    private _saveData = _saveHashMap get str _unit;
    [formatText["Restoring state of %1 :: %2", _unit, _saveData]] call FUNC(info);
    if (_saveData#0 != typeOf _unit) then {
        [formatText["%1 classname miss match. Got %2 expected %3...", _unit, typeOf _unit, _saveData#0]] call FUNC(error);
    };
    
    if !(_saveData#3) exitWith {
        [formatText["Unit %1 is destroyed removing...", _unit]] call FUNC(log);
        deleteVehicle _unit;
    };
    _unit setVariable [QGVAR(objData), _saveData];
    _unit setPos _saveData#1;
    _unit setDir _saveData#2;
    
} else {
    [_unit, true] call FUNC(saveObject);
};

_unit addEventHandler ["Killed", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];

    if (isNull _unit) exitWith {};
    [formatText["%1 killed saving profile state...", _unit]] call FUNC(log);
    _unit setVariable [QEGVAR(Profile,Alive), false];

    [_unit] call FUNC(saveObject); 
}];