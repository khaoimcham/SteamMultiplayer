/// @description Init Client Variables

player_list = [];

steamID = steam_get_user_steam_id();
steamName = steam_get_persona_name();

character = undefined;
lobbyMemberID = 0;

inbuf = buffer_create(16, buffer_grow, 1);


player_list[0] = {
	steamID	: steamID,
	steamName	: steamName,
	character	: undefined,
	start_pos	: GrabSpawnPoint(0),
	lobbyMemberID: 0
}