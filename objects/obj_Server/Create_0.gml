/// @description Init server variables

player_list = [];

steamID = steam_get_user_steam_id();
steamName = steam_get_persona_name();

character = undefined;
lobbyMemberID = 0;
player_list[0] = {
	steamID	: steamID,
	steamName	: steamName,
	character	: undefined,
	start_pos	: GrabSpawnPoint(0),
	lobbyMemberID: 0
}