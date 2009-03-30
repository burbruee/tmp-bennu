Const
	VERSION 		= "0.1";
	SCREEN_X 	= 800;
	SCREEN_Y		= 600;
	SCREEN_BPP	= 16;
	FPS_GAME		= 30;
	
	KEY_UP		= 1;
	KEY_DOWN		= 2;
	KEY_LEFT		= 3;
	KEY_RIGHT	= 4;
	KEY_A			= 5;
	KEY_B			= 6;
	KEY_C			= 7;
	KEY_D			= 8;
	KEY_START	= 9;
	KEY_CLOSE	= 10;
	NUM_KEYS		= 10;
	
	PLAYER_1		= 1;
	PLAYER_2		= 2;
	NUM_PLAYERS	= 2;
Global
	int player_key[NUM_PLAYERS][NUM_KEYS];
	int vol_music		= 50;
	int vol_effects	= 128;
Begin
	rand_seed(get_timer()+(time()%1000)*1000);
	set_mode(SCREEN_X, SCREEN_Y, SCREEN_BPP);
	set_fps(FPS_GAME,0);
	set_title("TROLLET MiniGames Collection "+VERSION);
	
	get_desktop_size(&x,&y);
	set_window_pos((x/2)-(SCREEN_X/2),(y/2)-(SCREEN_Y/2));
	
	set_default_keys();
	menu();
End
Process menu()
Private
	int i;
	int option		= 0;
	int textsTemp[100];
	int num_option;
	string game_name[100];
	int selected	= 0;
	
	int counter_time;
	int key_press;
Begin
	signal(father,s_kill);
	game_name[num_option++] = "Tetris";
	game_name[num_option++] = "Draw Application";
	game_name[num_option++] = "Exit";
	
	for(i=0; i<num_option; i++)
		textsTemp[i] = write(0, SCREEN_X/2, 50+(i*10), 4, game_name[i]);
	end;
	
	write(0, SCREEN_X/2, SCREEN_Y - 30, 4, "Push F for fullscreen");
	write(0, SCREEN_X/2, SCREEN_Y - 20, 4, "Push W for windowed");
	selected = selected_line(SCREEN_X/2, 50);
	
	while(!key(player_key[PLAYER_1][KEY_START]))
		if(scan_code == 0)
			counter_time = 0;
		end;
		if(key(_f)) full_screen = true; set_mode(SCREEN_X, SCREEN_Y, SCREEN_BPP); end;
		if(key(_w)) full_screen = false; set_mode(SCREEN_X, SCREEN_Y, SCREEN_BPP); end;
		key_press = 0;
		
		while(scan_code <> 0)
			key_press = scan_code;
			counter_time++;
			if(counter_time == 10)
				counter_time--;
				break;
			end;
			frame;
		end;
		
		switch(key_press)
			case player_key[PLAYER_1][KEY_UP]:
				option--;
				selected.y-=10;
				if(option<0)
					option=0;
					selected.y+=10;
				end;
			end;
			case player_key[PLAYER_1][KEY_DOWN]:
				option++;
				selected.y+=10;
				if(option>=num_option)
					option=num_option-1;
					selected.y-=10;
				end;
			end;
			case player_key[PLAYER_1][KEY_CLOSE]:
				exit("Thank you for playing!",0);
			end;
		end;
		frame;
	end;
	
	for(i=0; i<num_option; i++)
		delete_text(textsTemp[i]);
	end;
	
	while(key(player_key[PLAYER_1][KEY_START]))
		frame;
	end;
	let_me_alone();
	i = 0;
	switch(option)
		case i++:
			TETRIS_main();
		end;
		case i++:
			TEST_Main();
		end;
	end;
End
Process selected_line(int x, int y)
Begin
	graph = new_map(200, 10, SCREEN_BPP);
	map_clear(0, graph, rgb(0, 128, 0));
	while(!key(player_key[PLAYER_1][KEY_CLOSE]))
		frame;
	end;
	unload_map(0, graph);
End
Function set_default_keys()
Begin
	player_key[PLAYER_1][KEY_UP] 		= _up;
	player_key[PLAYER_1][KEY_DOWN]	= _down;
	player_key[PLAYER_1][KEY_LEFT]	= _left;
	player_key[PLAYER_1][KEY_RIGHT]	= _right;
	player_key[PLAYER_1][KEY_A]		= _q;
	player_key[PLAYER_1][KEY_B]		= _w;
	player_key[PLAYER_1][KEY_C]		= _e;
	player_key[PLAYER_1][KEY_D]		= _r;
	player_key[PLAYER_1][KEY_START]	= _enter;
	player_key[PLAYER_1][KEY_CLOSE]	= _esc;
	
	player_key[PLAYER_2][KEY_UP]		= _o;
	player_key[PLAYER_2][KEY_DOWN]	= _l;
	player_key[PLAYER_2][KEY_LEFT]	= _k;
	player_key[PLAYER_2][KEY_RIGHT]	= _SEMICOLON;
	player_key[PLAYER_2][KEY_A]		= _t;
	player_key[PLAYER_2][KEY_B]		= _y;
	player_key[PLAYER_2][KEY_C]		= _u;
	player_key[PLAYER_2][KEY_D]		= _i;
	player_key[PLAYER_2][KEY_START]	= _enter;
	player_key[PLAYER_2][KEY_CLOSE]	= _esc;
End
include "TETRIS.prg"
include "TEST.prg"
