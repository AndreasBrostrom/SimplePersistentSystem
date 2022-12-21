#include "..\script_component.hpp"

params[["_vehicle", objNull, [objNull]]];

if (!isServer) exitWith {};

private _saveHashMap = profileNamespace getVariable QEGVAR(missionProfiledObjects,SavedUnits);

if (!isNil {_saveHashMap get str _vehicle}) then {
    private _saveData = _saveHashMap get str _vehicle;
    [formatText["Restoring state of %1 :: %2", _vehicle, _saveData]] call FUNC(info);
    if (_saveData#0 != typeOf _vehicle) then {
        [formatText["%1 classname miss match. Got %2 expected %3...", _vehicle, typeOf _vehicle, _saveData#0]] call FUNC(error);
    };
    
    if !(_saveData#3) exitWith {
        [formatText["Unit %1 is destroyed whreching it...", _vehicle]] call FUNC(log);
    };
    _vehicle setVariable [QGVAR(objData), _saveData];
    _vehicle setPos _saveData#1;
    _vehicle setVectorDirAndUp _saveData#2;
    
    if (_saveData#4) then {
        createVehicleCrew _vehicle;
        _vehicle setVariable [QEGVAR(Profile,vehicleCrewed), true];
    };

} else {
    [_vehicle, true] call FUNC(saveObject);
};

_vehicle addEventHandler ["Killed", {
    params ["_vehicle", "_killer", "_instigator", "_useEffects"];

    if (isNull _vehicle) exitWith {};

    [formatText["%1 killed saving profile state...", _vehicle]] call FUNC(log);
    _vehicle setVariable [QEGVAR(Profile,Alive), false];

    [_vehicle] call FUNC(saveObject); 
}];

this addEventHandler ["GetOut", {
    params ["_vehicle", "_role", "_unit", "_turret"];
    if (isNull _vehicle) exitWith {};

    [_vehicle] call FUNC(saveObject); 
}];