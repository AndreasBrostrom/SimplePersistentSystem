#include "..\script_component.hpp"

if (!isServer) exitWith {};

profileNamespace setVariable [QEGVAR(missionProfiledObjects,SavedUnits), nil];

true