CONST
	SCREENX 	= 320;
	SCREENY 	= 240;
	SCREEN_X = 800;
	SCREEN_Y = 480;
GLOBAL
	//GP2X Keys
	__A = _control;
	__B = _alt;
	__SELECT = _space;
	__R = _tab;

	__L = _backspace;
	__START = _enter;
	
    int player;
    int points = 0;
    int highscore[3];
    int difficulty;
    int diff[3];
    int score;
    int level;
    int fpg;
    int music;
    int n;
    int t2;
    int takingscreenshot;
Process TWIP_Main()
BEGIN;
	
    //set_fps(60,0);
    set_title("TROLLET II");
//    scale_mode = SCALE_HQ2X;
//	set_mode(SCREENX,SCREENY,16);
	if(!file_exists("scores.dat"));
   		save("scores.dat",highscore);
	end
	
	load("scores.dat", highscore);
	
	t2 = load_fpg("data/t2.fpg");
    /*drawing_color(rgb(255,0,0));
    drawing_z(100);
    draw_box(0,8,SCREENX,20);
    write_int(0, 10, 10, 0, &points);
    drawPlayer();*/
    score = 0;
    level = 1;
    TWIP_Title();
//    Menu();

END;

PROCESS TWIP_Title()
PRIVATE;
	title1;
	title2;
	title3;
	i;
BEGIN;
/*	loop;
		
		(0, "data/bucket.png", 160, 240);
	frame;
	end;
*/
   title1 = load_png("data/title1.png");
   title2 = load_png("data/title2.png");
   title3 = load_png("data/title3.png");
   
   put_screen(0,title1);
   for (i=0;i<100;i++)
       frame(100);
   end
   
   fade_off();
   fade_on();
   clear_screen();
   
   put_screen(0,title2);
   for(i=0;i<100;i++)
   		frame(100);
   end;
   fade_off();
   fade_on();
   clear_screen();
   
   put_screen(0,title3);
   for(i=0;i<100;i++)
   		frame(100);
   end;
   fade_off();
   fade_on();
   clear_screen();
   
   
   
   TWIP_Menu();
END;

PROCESS TWIP_Menu()
PRIVATE;
	i;
	String diff[3] = "Easy", "Medium", "Hard", "Endless";
	text, text2;
BEGIN;
	TWIP_fill_map();
	
	difficulty = 1;
	
	music = load_song("data/nac_freedomofhell.it");
	
	play_song(music, 100);	
	
	
	
	
	graph = write_in_map( 0, "TROLLET II", 4);
	write(0, SCREEN_X/2, SCREEN_Y/4, 4, '"Mystic Handgun Massacre"');
	
	write(0,SCREEN_X/2,SCREEN_Y/2+SCREEN_Y/9,4,"Press [Start] To Start");
	write(0,SCREEN_X/2,SCREEN_Y/2+SCREEN_Y/9+10,4,"[Select] to Quit");
	text = write(0,SCREEN_X/2+30,SCREEN_Y/2+SCREEN_Y/9+30,1,diff[difficulty-1]);
	write(0,SCREEN_X/2,SCREEN_Y/2+SCREEN_Y/9+40,2,"HighScore:");
	text2 = write_int(0,SCREEN_X/2+20,SCREEN_Y/2+SCREEN_Y/9+40,1,&highscore[difficulty-1]);
	write(0,SCREEN_X/2,SCREEN_Y/2+SCREEN_Y/9+30,2,"Difficulty:");
	write(0,SCREEN_X/2,SCREEN_Y/2+SCREEN_Y/2-70,4,"By Burbruee ");
	write(0,SCREEN_X/2,SCREEN_Y/2+SCREEN_Y/2-80,4,"http://143.mine.nu/");
	
	x = SCREEN_X / 2;
	y = SCREEN_Y / 3;
	
	loop;
		if ( key( _esc )) exit("",0); end;
		i += 7000;
		
		size_x = 300;
		size_y = abs(get_distx(i, 300));
		
		if ( get_distx( i, 200) < 0 )
			flags = 2;
		else
			flags = 0;
		end;
		
		if ( key( _left ) and difficulty > 1 )
    		difficulty--;
    		delete_text( text );
    		delete_text( text2 );
    		text = write(0,SCREEN_X/2+30,SCREEN_Y/2+SCREEN_Y/9+30,1,diff[difficulty-1]);
    		text2 = write_int(0,SCREEN_X/2+20,SCREEN_Y/2+SCREEN_Y/9+40,1,&highscore[difficulty-1]);
    		while ( key( _left ))frame; end
  		end
		
		if ( key(_right ) and difficulty < 4 )
    		difficulty++;
    		delete_text( text );
    		delete_text( text2 );
    		text = write(0,SCREEN_X/2+30,SCREEN_Y/2+SCREEN_Y/9+30,1,diff[difficulty-1]);
    		text2 = write_int(0,SCREEN_X/2+20,SCREEN_Y/2+SCREEN_Y/9+40,1,&highscore[difficulty-1]);
    		while ( key( _right ))frame; end
  		end
		
		if ( key( __START ))
			fade_off();
			fade_on();
			TWIP_drawPlayer();
			
//			play_song(music, 100);	
			break;
		end;
		
		if ( key( __SELECT ))
			exit("",0);
		end;
		
		frame;
	end;
	
set_fps(20+difficulty*7,0);
delete_text(all_text);

TWIP_Render();


drawing_color(rgb(128,156,164));
drawing_z(100);
draw_box(SCREENX-SCREENX, SCREENY-50, SCREENX, SCREENY);

write_int(0,SCREENX-SCREENX + 40,SCREENY-30,4,&score);
write(0,SCREENX-SCREENX + 40,SCREENY-40,4,"Score:");

write(0,SCREENX-SCREENX + 120,SCREENY-40,4,"Level:");
write_int(0,SCREENX-SCREENX + 120,SCREENY-30,4,&level);

write(0,SCREENX-SCREENX + 200,SCREENY-40,4,"Hiscore:");
write_int(0,SCREENX-SCREENX + 200,SCREENY-30,4,&highscore[difficulty-1]);


//Debug-stuff
write_int(0,10,10,0, &fps);

//game();

END;

PROCESS TWIP_Render()
PRIVATE;
	i, j, k, l;
BEGIN;
	loop;
	
	put(t2,4,160,95);
		if(key(__SELECT))
		fade_off();
		fade_on();
			while(key(__SELECT)) frame; end;
			clear_screen();
			delete_text(all_text);
			delete_draw(0);
			score = 0;
			difficulty = 0;
			let_me_alone();
			stop_song();
			set_fps(30,0);
			TWIP_Menu();
			return;
		end;
	frame;
	end;	
END;

PROCESS TWIP_drawPlayer()
BEGIN;
    //player = new_map(48, 48, 8);
    //map_clear(0,player,rgb(255,255,0));
    player = load_png("data/trolletfix2.png");

    x = SCREENX / 2;
    y = SCREENY - 73;
    //x=mouse.x;
    //y=mouse.y;
    
    graph = player;
    
    
    loop;
       if(key(_left)) x-=4; score++; end;
       if(key(_right)) x+=4; score++; end;
       if( x < 24 ) x = 24; end;
       if( x > SCREENX - 24 ) x = SCREENX - 24; end; 
	   //if( key(_enter)) exit("",0); end;
	   if (highscore[difficulty-1]<=score) highscore[difficulty-1]=score; save("scores.dat", highscore); end;
	   
	   If (key(_f12)) 
        If (takingscreenshot==0)
            takingscreenshot=1;
             graph=get_screen(); // grabs the screen and sets it as the program graphic
             save_png(0,graph,"shot"+rand(0,9999)+".png"); // saves the graphic as a png with a
                                                           // random number in the filename to
                                                           // prevent overwriting 
             unload_map(0,graph);  //frees the graphic
             graph=player;
        Else
             takingscreenshot=0;
        End
     		End         
	   
       frame;
    end;
END;

PROCESS TWIP_fill_map()
BEGIN;
	for ( y = 0; y < SCREEN_Y; y++ )
		z = 64 + ( y * 16 / SCREEN_Y );
		for ( x = 0; x < SCREEN_X; x++ )
			put_pixel( x, y, z );
		end;
	end;
END;
