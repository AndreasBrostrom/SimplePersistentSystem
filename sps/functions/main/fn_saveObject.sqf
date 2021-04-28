#include "..\script_component.hpp"

params[
    ["_object", objNull, [objNull]],
    ["_init", false, [false]]
];

if (!isServer) exitWith {};
if (isNull _object) exitWith {[formatText["Not possible to save %1.", _object]] call FUNC(error);};

private _saveHashMap = profileNamespace getVariable QEGVAR(missionProfiledObjects,SavedUnits);

private _objectData = _object call FUNC(getObjectSaveData);

#ifdef DEBUG_MODE
    if (_init) then {
        [formatText["Profiling state of %1 :: %2", _object, _objectData#1]] call FUNC(log);
    } else {
        [formatText["Saving state of %1 :: %2", _object, _objectData#1]] call FUNC(log);
    };
#endif

_saveHashMap set _objectData;
_object setVariable [QGVAR(objData), _objectData#1];
profileNamespace setVariable [QEGVAR(missionProfiledObjects,SavedUnits), _saveHashMap];

true