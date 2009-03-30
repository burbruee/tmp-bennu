Type _players
	int x;
	int y;
End

Global
	_players player, enemy;	
	int lives;
	int energy;
	int score;
	int hiscore;
	
	int dmap;
End

Process TEST_Main()
Begin
	set_title("TEST Game");
//	say("Hello World!");
	init();
	prnt();
	dmap = new_map(10,10,16);
	map_clear(0,dmap,rgb(255,255,255));
	loop
		mouse.graph=dmap;
		if(mouse.left)
			put_pixel(mouse.x,mouse.y,rgb(255,255,0));
//			frame;
		end;
	while (!is_key_pressed(PLAYER_1,KEY_START))
	    if(is_key_pressed(PLAYER_1,KEY_CLOSE))
          While (is_key_pressed(PLAYER_1,KEY_CLOSE))
             Frame;
          End
          let_me_alone();
          delete_text(all_text);
          delete_draw(0);
          menu();
          return;
       end //Acabar la ejecuci�n si se ha seleccionado la tecla SELECT
       frame;
   end	                                                          		
		frame;
	end;
End

Process init()
Begin
	lives 	= 3;
	energy 	= 100;
	score 	= 0;
	hiscore 	= score;
	player.x = 10;
	player.y = 120;
	enemy.x	= 540;
	enemy.y	= 80;
End

Process prnt()
Begin
	draw_line(0, 20, SCREEN_X, 20);
	draw_line(0, 329, SCREEN_X, 329);
	drawing_z(1000);
	drawing_color(rgb(52,108,164));
	draw_box(0, 330, SCREEN_X, SCREEN_Y);
	draw_box(0, 0, SCREEN_X, 19);
	drawing_color(rgb(255,255,255));

	put_pixel(player.x,player.y,rgb(255,255,255));
	put_pixel(enemy.x,enemy.y,rgb(255,255,255));
	write(0, 320, 10, 4, "A NEW GAME, NOT STARRING TROLLET");
	
	write(0, 32, 370, 0, "Lives:");
	write(0, 32, 390, 0, "Energy:");
	write(0, 32, 410, 0, "Score:");
	write(0, 32, 430, 0, "Hiscore:");

	write(0, 132, 370, 0, "Player.X:");
	write(0, 132, 390, 0, "Player.Y:");

	write(0, 232, 370, 0, "Enemy.X:");
	write(0, 232, 390, 0, "Enemy.Y:");

	loop
		write_int(0, 32+59, 370, 0, &lives);
		write_int(0, 32+59, 390, 0, &energy);
		write_int(0, 32+59, 410, 0, &score);
		write_int(0, 32+59, 430, 0, &hiscore);

		write_int(0, 132+59, 370, 0, &player.x);
		write_int(0, 132+59, 390, 0, &player.y);

		write_int(0, 232+59, 370, 0, &enemy.x);
		write_int(0, 232+59, 390, 0, &enemy.y);
		frame;
	end;
	frame;
End;
