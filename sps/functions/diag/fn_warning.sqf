#include "..\script_component.hpp"
/*
 * Author: CPL.Brostrom.A
 *  This function print a formated rpt message.
 *
 * Arguments:
 * 0: message <STRING>
 * 1: componant <STRING>
 * 2: type <STRING>
 * 3: showInChat <BOOL>
 *
 * Example:
 * ["Something is wrong here."] call FUNC(warning)
 * [formatText["%1 is a player.", player]] call FUNC(warning)
 *
 */

params [
    ["_message", "", [text "", ""]],
    ["_componant", "", [""]],
    ["_type", "WARNING", [""]],
    ["_showInChat", true, [true]]
];

[_message, _componant, _type, _showInChat] call FUNC(log);