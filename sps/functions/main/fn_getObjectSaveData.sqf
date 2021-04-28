#include "..\script_component.hpp"

params[
    ["_obj", objNull, [objNull]],
    ["_pos", [0,0,0], [[]]]
];

private _objName = str _obj;
private _playerLoadout = [];

if (isPlayer _obj) then { 
    _objName = getPlayerUID _obj;
    _playerLoadout = getUnitLoadout _obj;
};

if (_pos isEqualTo [0,0,0]) then {_pos = getPos _obj;};

if (_obj isKindOf "AllVehicles") then {
    if (isNull objectParent player) then {
        if (count (crew _obj) > 0) then {
            _obj setVariable [QEGVAR(Profile,vehicleCrewed), true];
        };
    };
};

private _data = [
    _objName, [         // Object id or player GUID
        typeOf _obj,    // className
        _pos,           // position
        direction _obj, // direction
        _obj getVariable [QEGVAR(Profile,Alive), true],
        _obj getVariable [QEGVAR(Profile,vehicleCrewed), false],
        _playerLoadout  // unitLoadout (for players only)
    ]
];

_data