//--Includes------------------------------------------------------------|
include "project1.prg"
//--End-----------------------------------------------------------------|

//--Declarations--------------------------------------------------------|

//--End-----------------------------------------------------------------|

//--Constants-----------------------------------------------------------|
Const
	VERSION = "0.1";
	SCREEN_X = 800;
	SCREEN_Y = 480;
	SCREEN_BPP = 16;
	OPT_FPS = 60;
	
	KEY_UP = 1;
	KEY_DOWN = 2;
	KEY_LEFT = 3;
	KEY_RIGHT = 4;
	KEY_A = 5;
	KEY_B = 6;
	KEY_C = 7;
	KEY_D = 8;
	KEY_START = 9;
	KEY_EXIT = 10;
	KEY_BACK = 11;
	KEY_NEXT = 12;
	
	KEYS = 12;
	PLAYER_1 = 1;
	PLAYERS = 1;
End
//--End-----------------------------------------------------------------|

//--Globals-------------------------------------------------------------|
Global
	int player_key[PLAYERS][KEYS];
End
//--End-----------------------------------------------------------------|

//--Main----------------------------------------------------------------|
Process Main()
Begin
	//Set the scale mode
	SCALE_MODE = SCALE_NONE;
	
	//Initialize the randomizer.
	rand_seed( get_timer() + ( time() % 1000) * 1000 );
	
	//Set the resolution
	set_mode(SCREEN_X, SCREEN_Y, SCREEN_BPP);
	
	//Set the frames_per_second
	set_fps(OPT_FPS, 0);
	
	//Set window-title
	set_title("TROLLET MiniGames Project v" + VERSION);
	
	//Center the window to the user's desktop, whatever resolution s/he uses
	get_desktop_size(&x, &y);
	set_window_pos( (x/2) - (SCREEN_X / 2), (y/2) - (SCREEN_Y / 2) );
	
	//Set the default key configuration, TODO: Make customizable
	configure_keys();
	
	//Lauch the graphical selector
	gMenu();
End
//--End-----------------------------------------------------------------|

//--Graphical-Menu------------------------------------------------------|
Process gMenu()
Private
	int i;
	int sel = 0;
	int opt = 0;
	int opt_id;
	int txt[100];
	int draw[100];
	string game_name[100];
	int counterTime;
	int keyPress;
	int pic;
Begin
	//Kill your father :(
	signal(father, s_kill);
	
	//Load resources
	pic = load_png("data/0011.png");
	
	//Draw the graphical menu, should ALWAYS be present!
	drawing_color(rgb(52,101,164));
	drawing_z(1000);
	draw_box(0, SCREEN_Y - 49, SCREEN_X, SCREEN_Y);
	draw_box(0, 0, SCREEN_X, 49);
	drawing_color(rgb(255,255,255));
	draw_line(0, SCREEN_Y - 50, SCREEN_X, SCREEN_Y - 50);
	draw_line(0, 50, SCREEN_X, 50);
	
	//Draw the lines across the screen	
	draw[1] = draw_line(0, 240, SCREEN_X, 240);
	draw[2] = draw_line(SCREEN_X / 2, 0, SCREEN_X / 2, SCREEN_Y);

	//Placeholders, not in used once all previews are present, should be removed.
/*
	drawing_color(rgb(117,7,7));
	draw_box(0, 0, SCREEN_X / 2, SCREEN_Y / 2);
	drawing_color(rgb(7,116,7));
	draw_box(SCREEN_X / 2, 0, SCREEN_X, SCREEN_Y / 2);
	drawing_color(rgb(7,7,116));
	draw_box(0, SCREEN_Y / 2, SCREEN_X / 2, SCREEN_Y);
	drawing_color(rgb(117,117,7));
	draw_box(SCREEN_X / 2, SCREEN_Y / 2, SCREEN_X, SCREEN_Y);
*/	
	//Enlarged Title Text
	x = SCREEN_X / 2;
	y = 20;
	size_x = 300;
	size_y = 300;
	graph = write_in_map(0, "TROLLET MiniGames Project", 4);

	//Text that should always be visible
	write(0, SCREEN_X / 2, SCREEN_Y - 30, 4, "[A] - TROLLET v0.0.1  |  [B] - TROLLET v0.0.2  | [C] - TROLLET v0.0.3  |  [D] - TROLLET v0.0.4");
	write(0, SCREEN_X / 2, SCREEN_Y - 15, 4, " [F1] - PREVIOUS PAGE  |  [F2] - NEXT PAGE");
	
	//Text that should only be visible in the selector (first page)
	txt[0] = write(0, SCREEN_X / 4, SCREEN_Y / 4 + 25, 4, "[PLACEHOLDER v0.0.1]");
	txt[1] = write(0, SCREEN_X / 2 + SCREEN_X / 4, SCREEN_Y / 2 - SCREEN_Y / 4 + 25, 4, "[PLACEHOLDER v0.0.2]");
	txt[2] = write(0, SCREEN_X / 2 + SCREEN_X / 4, SCREEN_Y / 2 + SCREEN_Y / 4 - 25, 4, "[PLACEHOLDER v0.0.4]");
	txt[3] = write(0, SCREEN_X / 4, SCREEN_Y / 4 + SCREEN_Y / 2 - 25, 4, "[PLACEHOLDER v0.0.3]");
	
	//This is the previews
	put(0, pic, 190, 190);
	put(0, pic, SCREEN_X-60, 190);
	put(0, pic, SCREEN_X-50, 0);
	put(0, pic, 50, 0);
	
	//Delete the lines separating the previews
	delete_draw(draw[1]);
	delete_draw(draw[2]);
	
	//main-loop	
	Loop
		//Delete the selector-text and start the game
		if(key(player_key[PLAYER_1][KEY_D]))
			for(i=0; i<=3; i++)
				delete_text(txt[i]);
			end
			TWIP_Main();
		end
		frame;
	end
End
//--End-----------------------------------------------------------------|

//--Selected-Line-------------------------------------------------------|
/* Useful function to select a line, but currently not in use */
Process SelLine(int x, int y)
Begin
	graph = new_map(200, 10, SCREEN_BPP);
	map_clear(0, graph, rgb(0, 128, 0));
	while(!key(player_key[PLAYER_1][KEY_EXIT]))
		frame;
	end;
	unload_map(0, graph);
End
//--End-----------------------------------------------------------------|

//--Key-Configuration---------------------------------------------------|
Function configure_keys()
Begin
	player_key[PLAYER_1][KEY_UP] = _s;
	player_key[PLAYER_1][KEY_DOWN] = _x;
	player_key[PLAYER_1][KEY_LEFT] = _z;
	player_key[PLAYER_1][KEY_RIGHT] = _c;
	player_key[PLAYER_1][KEY_A] = _b;
	player_key[PLAYER_1][KEY_B] = _n;
	player_key[PLAYER_1][KEY_C] = _m;
	player_key[PLAYER_1][KEY_D] = _space;
	player_key[PLAYER_1][KEY_START] = _enter;
	player_key[PLAYER_1][KEY_EXIT] = _esc;
	player_key[PLAYER_1][KEY_BACK] = _F1;
	player_key[PLAYER_1][KEY_NEXT] = _F2;
End
//--End-----------------------------------------------------------------|
