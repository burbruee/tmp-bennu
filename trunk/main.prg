//--Includes------------------------------------------------------------|

//--End-----------------------------------------------------------------|

//--Declarations--------------------------------------------------------|

//--End-----------------------------------------------------------------|

//--Constants-----------------------------------------------------------|
Const
	VERSION = "0.1";
	SCREEN_X = 800;
	SCREEN_Y = 600;
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
	
	KEYS = 10;
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
	rand_seed( get_timer() + ( time() % 1000) * 1000 );
	set_mode(SCREEN_X, SCREEN_Y, SCREEN_BPP);
	set_fps(OPT_FPS, 0);
	set_title("TROLLET MiniGames Project v" + VERSION);
	get_desktop_size(&x, &y);
	set_window_pos( (x/2) - (SCREEN_X / 2), (y/2) - (SCREEN_Y / 2) );
	configure_keys();
	menu();
End
//--End-----------------------------------------------------------------|

//--Menu----------------------------------------------------------------|
Process menu()
Private
	int i;
	int sel = 0;
	int opt = 0;
	int opt_id;
	int txt[100];
	string game_name[100];
	
	int counterTime;
	int keyPress;
Begin
	signal(father, s_kill);
	game_name[opt_id++] = "TROLLET v0.0.1";
	game_name[opt_id++] = "TROLLET v0.0.2";
	game_name[opt_id++] = "TROLLET v0.0.3";
	game_name[opt_id++] = "TROLLET v0.0.4";
	game_name[opt_id++] = "TROLLET v0.0.5";
	game_name[opt_id++] = "TROLLET v0.0.6";
	game_name[opt_id++] = "TROLLET II";
	game_name[opt_id++] = "TROLLET III";
	game_name[opt_id++] = "TROLLET IV";
	game_name[opt_id++] = "TROLLET HD";
	game_name[opt_id++] = "Exit";
	
	for(i=0; i < opt_id; i++)
		txt[i] = write(0, SCREEN_X / 2, 50 + (i * 10), 4, game_name[i]);
	end;
	sel = selLine(SCREEN_X / 2, 50);
	
	while(!key(player_key[PLAYER_1][KEY_START]))
		if(scan_code == 0)
			counterTime = 0;
		end;
		//FS-WIN
		keyPress = 0;
		
		while(scan_code <> 0)
			keyPress = scan_code;
			counterTime++;
			if(counterTime == 10)
				counterTime--;
				break;
			end;
			frame;
		end;
		
		switch(keyPress)
			case player_key[PLAYER_1][KEY_UP]:
				opt--;
				sel.y -= 10;
				if(opt < 0)
					opt = 0;
					sel.y += 10;
				end;
			end;
			case player_key[PLAYER_1][KEY_DOWN]:
				opt++;
				sel.y += 10;
				if(opt >= opt_id)
					opt = opt_id - 1;
					sel.y -= 10;
				end;
			end;
			case player_key[PLAYER_1][KEY_EXIT]:
				exit("Thanks for playing...");
			end;
		end;
		frame;
	end;		

	for(i=0; i < opt_id; i++)
		delete_text(txt[i]);
	end;
		
	while(key(player_key[PLAYER_1][KEY_START]))
		frame;
	end;
	let_me_alone();
	i = 0;
		
	switch(opt)
		case i++:
			//T001
		end;
		case i++:
			//T002
		end;
		case i++:
			//T003
		end;
		case i++:
			//T004
		end;
		case i++:
			//T005
		end;
		case i++:
			//T006
		end;
		case i++:
			//T2
		end;
		case i++:
			//T3
		end;
		case i++:
			//T4
		end;
		case i++:
			//THD
		end;
	end;
End
//--End-----------------------------------------------------------------|

//--Selected-Line-------------------------------------------------------|
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
End
//--End-----------------------------------------------------------------|
