/// @description Spawn Players

var _player_layer = layer_get_id("Instances");

for (var _player = 0; _player < array_length(player_list); _player++)
{
	var _pos = GrabSpawnPoint(_player);
	var _inst = instance_create_layer(_pos.x, _pos.y, _player_layer, obj_Player, {
		steamName	: player_list[_player].steamName,
		steamID		: player_list[_player].steamID,
		lobbyMemberID : _player
	})
	player_list[_player].character = _inst;
	player_list[_player].start_pos = _pos;
	if (player_list[_player].steamID == steamID) character = _inst;
}