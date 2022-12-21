#include "..\script_component.hpp"

params[
    ["_obj", objNull, [objNull]]
];

if (!isServer) exitWith {};

// Catch players befor assigning id
if (isPlayer _obj) exitWith { _obj call EFUNC(profiler,player); };

PROFILE_ID_NUMBER = PROFILE_ID_NUMBER + 1;
private _profileVarId = [QEGVAR(obj,id), PROFILE_ID_NUMBER] joinString "_";
_obj setVehicleVarName _profileVarId;

// If variable detected not profile exit
if (_obj getVariable [QGVAR(noProfileing), false]) exitWith {};

switch (true) do {
    case (_obj isKindOf "man"): { _obj call EFUNC(profiler,unit); };
    case (_obj isKindOf "AllVehicles"): { _obj call EFUNC(profiler,vehicle); };
    default {
        [formatText["%1 (%2) not supported profile object...", _obj, typeOf _obj]] call FUNC(warning);
    };
};