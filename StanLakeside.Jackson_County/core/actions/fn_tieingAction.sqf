/*
	File: fn_restrainAction.sqf
	
	
	Description:
	Retrains the target.
*/

private["_unit"];
_unit = cursorTarget;

if(life_inv_tierope < 1) exitWith {
	["Musisz kupic line z marketu aby to zrobic..", false] spawn domsg;
};

if((life_action_inUse) || (player getVariable ["tied", false]) || (player getVariable ["restrained", false])) exitWith { 
["Nie mozesz tego zrobic!", false] spawn domsg;

}; 
if(isNull _unit) exitWith {}; //Not valid
if((_unit getVariable ["tied", false])) exitWith {};

if(player isEqualTo _unit) exitWith {};
if(!isPlayer _unit) exitWith {};
//Broadcast!

life_action_inUse = true;
["Wiaze!", false] spawn domsg;

playSound3D ["cg_sndimg\sounds\tieup.ogg", player, false, getPosASL player, 1, 1, 125];
["Remove",20] call fnc_karma;
_randycunt = 3;
_num = 1;
_myposy = getPos player;
while {_randycunt > _num} do {
_randycunt = _randycunt - 1;
player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
waitUntil{animationState player != "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";};
uiSleep 1;
};
	_unit setVariable["tied", true, true];
	[player] remoteExecCall ["life_fnc_tieing", _unit];
	life_rope = 1;
	_playerID = getPlayerUID player;
	_playerName = name player;
	_toPlayerID = getPlayerUID _unit;
	_toPlayerName = name _unit;
	_type = 0;
	[_playerID,_playerName,_toPlayerID,_toPlayerName,_type,""] remoteExecCall ["TON_fnc_actionLog", (call life_fnc_HCC)];

life_action_inUse = false;
