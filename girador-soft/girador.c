#include<pic.h>
__CONFIG(0x3F32);
#define _XTAL_FREQ 20000000
#define uns8 unsigned char
#define uns16 unsigned long

//    INFORMACOES    GERAIS
// Interrupcoes:
// TMR1: adiciona 1 ao tempo, pode vir a redesenhar
// TMR0: Adiciona 1 ao frame, desenha o atual e prepara proximo.
// INTL: zera frame, zera TMR0 e joga desenho 0 na tela
// INTH: joga desenho 1,frame=1, delay=TMR0 

uns8 SENSOR, LAST_SENSOR;
uns8 CALIBRACAO; 
uns8 parte,sl,sh,ml,mh,hl,hh;//relogio
uns8 telaL[60], telaHF[60], telaHL[60];//buffer
uns8 delay; //delay entre as posicoes do braco
uns8 frame; //numero atual da frame
uns8 mudar;

void ponto(char x, char y, char aceso){
	unsigned int raiz;
	char bits, parity, up, ang;
	
	parity = 0;
	if(x>0b10000000){x=-x;parity=0b00001111;}
	if(y>0b10000000){y=-y;parity|=0b11110000;}
			
	raiz = x*x+y*y;
		  if(raiz==0)return;
	else if(raiz<=1)bits=0b10000000;
	else if(raiz<=4)bits=0b01000000;
	else if(raiz<=9)bits=0b00100000;
	else if(raiz<=16)bits=0b00010000;
	else if(raiz<=25)bits=0b00001000;
	else if(raiz<=36)bits=0b00000100;
	else if(raiz<=49)bits=0b00000010;
	else if(raiz<=64)bits=0b00000001;
	else if(raiz<=81)bits=0b10000000;
	else if(raiz<=100)bits=0b01000000;
	else if(raiz<=121)bits=0b00100000;
	else if(raiz<=144)bits=0b00010000;
	else if(raiz<=169)bits=0b00001000;
	else if(raiz<=196)bits=0b00000100;
	else if(raiz<=225)bits=0b00000010;
	else if(raiz<=256)bits=0b00000001;
	else              return;
	if(raiz>64)up = 1;
	else       up = 0;
	
	if(x==0 || y==0){
		if(x==0){
         if(parity==0)ang=30;
         else ang=90;
      }else{
         if(parity==0)ang=0;
         else ang=60;
      }
	}else{
		if(parity==0b00000000){       //x>0 y>0
			ang = 0;
			raiz = (y<<8)/x;
		}else if(parity==0b00001111){ //x<0 y>0
			ang = 30;
			raiz = (x<<8)/y;
		}else if(parity==0b11111111){ //x<0 y<0
			ang = 60;
			raiz = (y<<8)/x;
		}else{                        //x>0 y<0
			ang = 90;
			raiz = (x<<8)/y;
		}
		     if(raiz<7);
		else if(raiz<20)ang++;
		else if(raiz<34)ang+=2;
		else if(raiz<47)ang+=3;
		else if(raiz<62)ang+=4;
		else if(raiz<76)ang+=5;
		else if(raiz<91)ang+=6;
		else if(raiz<106)ang+=7;
		else if(raiz<122)ang+=8;
		else if(raiz<139)ang+=9;
		else if(raiz<157)ang+=10;
		else if(raiz<176)ang+=11;
		else if(raiz<197)ang+=12;
		else if(raiz<219)ang+=13;
		else if(raiz<243)ang+=14;
		else if(raiz<270)ang+=15;
		else if(raiz<300)ang+=16;
		else if(raiz<334)ang+=17;
		else if(raiz<373)ang+=18;
		else if(raiz<418)ang+=19;
		else if(raiz<471)ang+=20;
		else if(raiz<537)ang+=21;
		else if(raiz<618)ang+=22;
		else if(raiz<723)ang+=23;
		else if(raiz<864)ang+=24;
		else if(raiz<1066)ang+=25;
		else if(raiz<1381)ang+=26;
		else if(raiz<1945)ang+=27;
		else if(raiz<3253)ang+=28;
		else ang+=29;
	}
	if(aceso){
		if(up){
			if(ang<60)telaHF[ang]   |=bits;
			else      telaHL[ang-60]|=bits;
		}else        telaL[ang>>1] |=bits;
	}else{
		if(up){
			if(ang<60)telaHF[ang]   &=!bits;
			else      telaHL[ang-60]&=!bits;
		}else        telaL[ang>>1] &=!bits;
	}
}

void linha(char x1, char y1, char x3, char y3, char def, char clear){
	char n,x,y;
	if(x3>0b10000000){x3=-x3;x1-=x3;}
	if(y3>0b10000000){y3=-y3;y1-=y3;}
	for(n=0;n<=def;n++){
		x = x1+(n*x3)/def;
		y = y1+(n*y3)/def;
		ponto(x,y,clear);
	}
} 
void desenhar_numero(char num, char x, char y){
     /* padrao
             ponto(x,y,1);
             ponto(x,y-1,1);
             ponto(x,y-2,1);
             ponto(x,y-3,1);
             ponto(x,y-4,1);
             ponto(x,y-5,1);
             ponto(x,y-6,1);
             ponto(x+1,y,1);
             ponto(x+1,y-1,1);
             ponto(x+1,y-2,1);
             ponto(x+1,y-3,1);
             ponto(x+1,y-4,1);
             ponto(x+1,y-5,1);
             ponto(x+1,y-6,1);
             ponto(x+2,y,1);
             ponto(x+2,y-1,1);
             ponto(x+2,y-2,1);
             ponto(x+2,y-3,1);
             ponto(x+2,y-4,1);
             ponto(x+2,y-5,1);
             ponto(x+2,y-6,1);
             ponto(x+3,y,1);
             ponto(x+3,y-1,1);
             ponto(x+3,y-2,1);
             ponto(x+3,y-3,1);
             ponto(x+3,y-4,1);
             ponto(x+3,y-5,1);
             ponto(x+3,y-6,1);
             ponto(x+4,y,1);
             ponto(x+4,y-1,1);
             ponto(x+4,y-2,1);
             ponto(x+4,y-3,1);
             ponto(x+4,y-4,1);
             ponto(x+4,y-5,1);
             ponto(x+4,y-6,1);
     */
     switch(num){
        case 0:
             ponto(x,y-1,1);
             ponto(x,y-2,1);
             ponto(x,y-3,1);
             ponto(x,y-4,1);
             ponto(x,y-5,1);
             ponto(x+1,y,1);
             ponto(x+1,y-6,1);
             ponto(x+2,y,1);
             ponto(x+2,y-6,1);
             ponto(x+3,y,1);
             ponto(x+3,y-6,1);
             ponto(x+4,y-1,1);
             ponto(x+4,y-2,1);
             ponto(x+4,y-3,1);
             ponto(x+4,y-4,1);
             ponto(x+4,y-5,1);
             break;
        case 1:
             ponto(x,y-2,1);
             ponto(x,y-6,1);
             ponto(x+1,y-1,1);
             ponto(x+1,y-6,1);
             ponto(x+2,y,1);
             ponto(x+2,y-1,1);
             ponto(x+2,y-2,1);
             ponto(x+2,y-3,1);
             ponto(x+2,y-4,1);
             ponto(x+2,y-5,1);
             ponto(x+2,y-6,1);
             ponto(x+3,y-6,1);
             ponto(x+4,y-6,1);
             break;
        case 2:
        		 ponto(x,y-1,1);
             ponto(x,y-6,1);
             ponto(x+1,y,1);
             ponto(x+1,y-5,1);
             ponto(x+1,y-6,1);
             ponto(x+2,y,1);
             ponto(x+2,y-4,1);
             ponto(x+2,y-6,1);
             ponto(x+3,y,1);
             ponto(x+3,y-3,1);
             ponto(x+3,y-6,1);
             ponto(x+4,y-1,1);
             ponto(x+4,y-2,1);
             ponto(x+4,y-6,1);
             break;
        case 3:
        		 ponto(x,y-1,1);
             ponto(x,y-5,1);
             ponto(x+1,y,1);
             ponto(x+1,y-6,1);
             ponto(x+2,y,1);
             ponto(x+2,y-3,1);
             ponto(x+2,y-6,1);
             ponto(x+3,y,1);
             ponto(x+3,y-3,1);
             ponto(x+3,y-6,1);
             ponto(x+4,y-1,1);
             ponto(x+4,y-2,1);
             ponto(x+4,y-4,1);
             ponto(x+4,y-5,1);
             break;
        case 4:
        		 ponto(x,y-3,1);
             ponto(x,y-4,1);
             ponto(x+1,y-2,1);
             ponto(x+1,y-4,1);
             ponto(x+2,y-1,1);
             ponto(x+2,y-4,1);
             ponto(x+3,y,1);
             ponto(x+3,y-1,1);
             ponto(x+3,y-2,1);
             ponto(x+3,y-3,1);
             ponto(x+3,y-4,1);
             ponto(x+3,y-5,1);
             ponto(x+3,y-6,1);
             ponto(x+4,y-4,1);
             break;
        case 5:
        		 ponto(x,y,1);
             ponto(x,y-1,1);
             ponto(x,y-2,1);
             ponto(x,y-3,1);
             ponto(x,y-5,1);
             ponto(x+1,y,1);
             ponto(x+1,y-3,1);
             ponto(x+1,y-6,1);
             ponto(x+2,y,1);
             ponto(x+2,y-3,1);
             ponto(x+2,y-6,1);
             ponto(x+3,y,1);
             ponto(x+3,y-3,1);
             ponto(x+3,y-6,1);
             ponto(x+4,y,1);
             ponto(x+4,y-4,1);
             ponto(x+4,y-5,1);
             break;
        case 6:
        		 ponto(x,y-1,1);
             ponto(x,y-2,1);
             ponto(x,y-3,1);
             ponto(x,y-4,1);
             ponto(x,y-5,1);
             ponto(x+1,y,1);
             ponto(x+1,y-3,1);
             ponto(x+1,y-6,1);
             ponto(x+2,y,1);
             ponto(x+2,y-3,1);
             ponto(x+2,y-6,1);
             ponto(x+3,y,1);
             ponto(x+3,y-3,1);
             ponto(x+3,y-6,1);
             ponto(x+4,y-1,1);
             ponto(x+4,y-4,1);
             ponto(x+4,y-5,1);
             break;
        case 7:
        		 ponto(x,y,1);
             ponto(x,y-1,1);
             ponto(x+1,y,1);
             ponto(x+2,y,1);
             ponto(x+2,y-1,1);
             ponto(x+2,y-5,1);
             ponto(x+2,y-6,1);
             ponto(x+3,y,1);
             ponto(x+3,y-3,1);
             ponto(x+3,y-4,1);
             ponto(x+4,y,1);
             ponto(x+4,y-1,1);
             ponto(x+4,y-2,1);
             break;
        case 8:
        		 ponto(x,y-1,1);
             ponto(x,y-2,1);
             ponto(x,y-4,1);
             ponto(x,y-5,1);
             ponto(x+1,y,1);
             ponto(x+1,y-3,1);
             ponto(x+1,y-6,1);
             ponto(x+2,y,1);
             ponto(x+2,y-3,1);
             ponto(x+2,y-6,1);
             ponto(x+3,y,1);
             ponto(x+3,y-3,1);
             ponto(x+3,y-6,1);
             ponto(x+4,y-1,1);
             ponto(x+4,y-2,1);
             ponto(x+4,y-4,1);
             ponto(x+4,y-5,1);
             break;
        case 9:
        		 ponto(x,y-1,1);
             ponto(x,y-2,1);
             ponto(x,y-5,1);
             ponto(x+1,y,1);
             ponto(x+1,y-3,1);
             ponto(x+1,y-6,1);
             ponto(x+2,y,1);
             ponto(x+2,y-3,1);
             ponto(x+2,y-6,1);
             ponto(x+3,y,1);
             ponto(x+3,y-3,1);
             ponto(x+3,y-6,1);
             ponto(x+4,y-1,1);
             ponto(x+4,y-2,1);
             ponto(x+4,y-3,1);
             ponto(x+4,y-4,1);
             ponto(x+4,y-5,1);
     }
}
void desenhar_relogio_digital(){
       for(char buffer=0;buffer<60;buffer++){
	    		telaHF[buffer]=telaHL[buffer]=telaL[buffer]=0; 
	    }
       desenhar_numero(sl,1,-1);
       desenhar_numero(sh,-6,-1);
       desenhar_numero(ml,7,8);
       desenhar_numero(mh,1,8);
       desenhar_numero(hl,-6,8);
       desenhar_numero(hh,-12,8);
       if(sl%2==0){
	       telaL[15] = 0b00010001;
       }
       linha(-14,10,29,0,29,1);
       linha(-14,-10,29,0,29,1);
       linha(14,-10,0,21,21,1);
       linha(-14,-10,0,21,21,1);
}
void desenhar_relogio_analogico(){
	char hora,minuto,segundo, a;
	hora = 15-(((hl+hh*10)%12)*5);
	minuto = 15-(ml+mh*10);
	segundo = 15-(sl+sh*10);
	if(segundo>128)segundo+=60;
	if(minuto>128)minuto+=60;
	if(hora>128)hora+=60;
	for(a=0;a<60;a++){
		telaL[a]=telaHL[a]=telaHF[a]=0;
		if(a%10==0)telaHL[a]=telaHF[a]=0b00000001;
	}
	telaHF[2 ]=0b00000111;
	telaHF[1 ]=0b00000001;
	telaHF[0 ]=0b00000111;
	telaHL[59]=0b00000001;
	telaHL[58]=0b00000111;
	
	telaHF[58]=0b00000111;
	telaHF[59]=0b00000101;
	telaHL[0 ]=0b00000111;
	telaHL[1 ]=0b00000100;
	telaHL[2 ]=0b00000111;
	
	telaHL[29]=0b00011111;
	telaHL[30]=0b00010101;
	telaHL[31]=0b00010111;
	
	telaHF[32]=0b00011111;
	telaHF[31]=0b00000000;
	telaHF[30]=0b00011101;
	telaHF[29]=0b00010101;
	telaHF[28]=0b00010111;
		
	telaL[hora]|=0b11111111;
	telaL[minuto]|=0b11111111;
	telaL[segundo]|=0b11111111;
	
	minuto=minuto<<1;
	segundo=segundo<<1;
	if(minuto<60)telaHF[minuto]|=0b11110000;
	else         telaHL[minuto-60]|=0b11110000;
	if(segundo<60)telaHF[segundo]|=0b11111100;
	else          telaHL[segundo-60]|=0b11111100;
}
/*
void ler_hora_de_fora(){
	//RCO = mudar tempo
	//RC7 = mudar digito
	//PORTD = telaH
	//PORTA:RE1:RE2 = telaL
	PORTE = 0;
	PORTA = 3;
	PORTD = sl;
	while(!RC7){
		if(RC6){
			sl+=1;
			if(sl>=10)sl=0;
			PORTD = sl;
			while(RC6);
			__delay_ms(33);__delay_ms(33);__delay_ms(33);
		}
	}
	while(RC7);
	__delay_ms(33);__delay_ms(33);__delay_ms(33);
	
	
	PORTA = 5;
	PORTD = sh;
	while(!RC7){
		if(RC6){
			sh+=1;
			if(sh>=6)sh=0;
			PORTD = sh;
			while(RC6);
			__delay_ms(33);__delay_ms(33);__delay_ms(33);
		}
	}
	while(RC7);
	__delay_ms(33);__delay_ms(33);__delay_ms(33);
	
	
	PORTA = 9;
	PORTD = ml;
	while(!RC7){
		if(RC6){
			ml+=1;
			if(ml>=10)ml=0;
			PORTD = ml;
			while(RC6);
			__delay_ms(33);__delay_ms(33);__delay_ms(33);
		}
	}
	while(RC7);
	__delay_ms(33);__delay_ms(33);__delay_ms(33);
	
	PORTA = 17;
	PORTD = mh;
	while(!RC7){
		if(RC6){
			mh+=1;
			if(mh>=6)mh=0;
			PORTD = mh;
			while(RC6);
			__delay_ms(33);__delay_ms(33);__delay_ms(33);
		}
	}
	while(RC7);
	__delay_ms(33);__delay_ms(33);__delay_ms(33);
	
	PORTA = 33;
	PORTD = hl;
	while(!RC7){
		if(RC6){
			hl+=1;
			if(hl>=10)hl=0;
			PORTD = hl;
			while(RC6);
			__delay_ms(33);__delay_ms(33);__delay_ms(33);
		}
	}
	while(RC7);
	__delay_ms(33);__delay_ms(33);__delay_ms(33);
	
	PORTA = 127;
	PORTD = hh;
	while(!RC7){
		if(RC6){
			hh+=1;
			if(hh>=3)hh=0;
			PORTD = hh;
			while(RC6);
			__delay_ms(33);__delay_ms(33);__delay_ms(33);
		}
	}
	while(RC7);
	__delay_ms(33);__delay_ms(33);__delay_ms(33);
	PORTD = PORTA= 0;
	
}*/
char ultima;
void mostrar_caractere(char posx,char letra){
	switch(letra){
		case 'p':
			ponto(posx,3,1);  //p
			ponto(posx,2,1);
			ponto(posx,1,1);
			ponto(posx,0,1);
			ponto(posx,-1,1);
			ponto(posx,-2,1);
			ponto(posx,-3,1);
			ponto(posx+1,3,1);
			ponto(posx+1,0,1);
			ponto(posx+2,3,1);
			ponto(posx+2,0,1);
			ponto(posx+3,3,1);
			ponto(posx+3,2,1);
			ponto(posx+3,1,1);
			ponto(posx+3,0,1);
			break;
		case 'e':
			ponto(posx,3,1);  //e
			ponto(posx,2,1);
			ponto(posx,1,1);
			ponto(posx,0,1);
			ponto(posx,-1,1);
			ponto(posx,-2,1);
			ponto(posx,-3,1);
			ponto(posx+1,3,1);
			ponto(posx+1,0,1);
			ponto(posx+1,-3,1);
			ponto(posx+2,3,1);
			ponto(posx+2,0,1);
			ponto(posx+2,-3,1);
			ponto(posx+3,3,1);
			ponto(posx+3,0,1);
			ponto(posx+3,-3,1);
			break;
		case 't':
			ponto(posx,3,1);  //t
			ponto(posx+1,3,1);
			ponto(posx+2,3,1);
			ponto(posx+2,2,1);
			ponto(posx+2,1,1);
			ponto(posx+2,0,1);
			ponto(posx+2,-1,1);
			ponto(posx+2,-2,1);
			ponto(posx+2,-3,1);
			ponto(posx+3,3,1);
			ponto(posx+4,3,1);
			break;
		case 'l':
			ponto(posx,3,1); //L
			ponto(posx,2,1);
			ponto(posx,1,1);
			ponto(posx,0,1);
			ponto(posx,-1,1);
			ponto(posx,-2,1);
			ponto(posx,-3,1);
			ponto(posx+1,-3,1);
			ponto(posx+2,-3,1);
			ponto(posx+3,-3,1);
			break;
		case 'a':
			ponto(posx,-3,1);
			ponto(posx,-2,1);
			ponto(posx+1,-1,1);
			ponto(posx+1,0,1);
			ponto(posx+1,1,1);
			ponto(posx+2,2,1);
			ponto(posx+2,3,1);
			ponto(posx+4,-3,1);
			ponto(posx+4,-2,1);
			ponto(posx+3,-1,1);
			ponto(posx+3,0,1);
			ponto(posx+3,1,1);
			ponto(posx+2,2,1);
			ponto(posx+2,3,1);
			ponto(posx+2,0,1);
			break;
		case 'c':
			ponto(posx,-2,1);
			ponto(posx,-1,1);
			ponto(posx,-0,1);
			ponto(posx,1,1);
			ponto(posx,2,1);
			ponto(posx+1,3,1);
			ponto(posx+1,-3,1);
			ponto(posx+2,3,1);
			ponto(posx+2,-3,1);
			ponto(posx+3,3,1);
			ponto(posx+4,-3,1);
			break;
		case 'i':
			ponto(posx+2,-3,1);
			ponto(posx+2,-2,1);
			ponto(posx+2,-1,1);
			ponto(posx+2,-0,1);
			ponto(posx+2,1,1);
			ponto(posx+2,3,1);
			break;
		case 'r':
			ponto(posx,-3,1);
			ponto(posx,-2,1);
			ponto(posx,-1,1);
			ponto(posx,-0,1);
			ponto(posx,1,1);
			ponto(posx,2,1);
			ponto(posx,3,1);
			ponto(posx+1,3,1);
			ponto(posx+1,0,1);
			ponto(posx+1,-1,1);
			ponto(posx+2,3,1);
			ponto(posx+2,0,1);
			ponto(posx+2,-2,1);
			ponto(posx+3,2,1);
			ponto(posx+3,1,1);
			ponto(posx+3,-3,1);
			break;
			
	}
}
	
void tentar_mostrar_expoeletrica(){
	char k;
	if(sh%3==2){
		if(ultima!=(TMR1H&0b01111111)>>4){
			ultima = (TMR1H&0b01111111)>>4;
			
			for(k=0;k<60;k++){
				telaL[k]=telaHL[k]=telaHF[k]=0;
			}
			k = sl<<3|ultima;
			
			mostrar_caractere(-k,'p');
			mostrar_caractere(5-k,'e');
			mostrar_caractere(10-k,'t');
			mostrar_caractere(28-k,'e');
			mostrar_caractere(33-k,'l');
			mostrar_caractere(38-k,'e');
			mostrar_caractere(43-k,'t');
			mostrar_caractere(49-k,'r');
			mostrar_caractere(54-k,'i');
			mostrar_caractere(59-k,'c');
			mostrar_caractere(64-k,'a');			
		}
	}
}
void verificar_botoes(){
	if(SENSOR!=0){
		if(SENSOR&1){
			CALIBRACAO++;
			telaL[37]=0b11110000;
		}
		if(SENSOR&2){
			CALIBRACAO--;
			telaL[44]=0b11110000;
		}
		if(SENSOR&4){
			sl++;
			if(sl==10)sl=0;
			telaL[52]=0b11110000;
		}
		if(SENSOR&8){
			sh++;
			if(sh==6)sh=0;
			telaL[59]=0b11110000;
		}
		if(SENSOR&16){
			ml++;
			if(ml==10)ml=0;
			telaL[6]=0b11110000;
		}
		if(SENSOR&32){
			mh++;
			if(mh==6)mh=0;
			telaL[14]=0b11110000;
		}
		if(SENSOR&64){
			hl++;
			if(hl==10){
				hh++;
				hl=0;
			}
			if(hh==2 && hl==4){
				hh=0;
				hl=0;
			}
			telaL[21]=0b11110000;
		}
		if(SENSOR&128){
			telaL[29]=0b11110000;
		}
		__delay_ms(33);__delay_ms(33);__delay_ms(33);
		while(SENSOR!=0);
		__delay_ms(33);__delay_ms(33);__delay_ms(33);
	}
}
void main(){
	TRISA = 0;
	TRISE = 0;
	TRISD = 0;
	TRISC = 0b11101111;
	PORTD = 0;
	PORTA = 0;
	PORTE = 0; //Todas as saidas/leds estao desligadas
	
	mudar = 0;
	
	sl=0;
	sh=0;
	ml=0;
	mh=0;
	hl=0;
	hh=0;//seta-se o relogio
   //ler_hora_de_fora();
	
	OPTION_REG = 0b10000011;//PORTBPullups, IEDGE, PRESCALER 1:16
	                    //sem habilitar TMR0IE(ainda nao)
	INTCON = 0b11010000;//enable interrupts:TMR0 & INT
	PIE1   = 0b00000001;//enable interrupt :TMR1
	
	//TMR1L = 0b00000000;//0b10010101
	TMR1H = 0b10000000;//0b00010010
	T1CON = 0b00001111;//TMR1 com 1:8 e ativo
	//desenhar_relogio_digital();
	telaHF[15] = 1;
	telaHF[30] = 1;
	telaHF[45] = 1;
	telaHL[0] = 1;
	telaHL[15] = 1;
	telaHL[30] = 1;
	telaHL[45] = 1;
	telaHL[59] = 3;
	CALIBRACAO = 72;
	while(1){
       if(mudar){
       	if     (sh%3==0)desenhar_relogio_analogico();
       	else if(sh%3==1)desenhar_relogio_digital();
       	mudar = 0;
       }
       tentar_mostrar_expoeletrica();
	   verificar_botoes();
	}
}

interrupt void interrupcoes(){
	uns8 buf;
	//A interrupcao mais importante eh a de TMR1, pois ela vai
	//definir o horario, o que precisa ser preciso(ou quase...)
	//Aprimeira coisa a ser fazer numa interrupcao eh limpar
	//o bit de interrupcao TMR1IF.
	//Logo apos resetaremos o TMR1, para que faca uma interrupcao
	//daqui a 100ms
	//A partir daqui comeca a parte logica, podendo-se incluir 
	//renderizacao de animacoes em ate 10fps
	if(TMR1IF){
		TMR1IF=0;
		TMR1L = 1;
		TMR1H = 0b10000000;//0b00010010
		T1CON = 0b00001111;//TMR1 com 1:8 e ativo
		mudar = 1;
		sl++;
		if(sl>=10){
			sl = 0;
			sh++;
			if(sh>=6){
			   sh = 0;
			   ml++;
			   if(ml>=10){
			      ml = 0;
			      mh++;
			      if(mh>=6){
			         mh = 0;
			         hl++;
			         if(hh==2 && hl==4){
				         hh = 0;
				         hl = 0;
				      }
				      if(hl>=10){
			            hl = 0;
			            hh++;
			         }
			      }
			   }
			}
		}
	}
	//Logo apos vem a interrupcao do TMR0, que tem como objetivo
	//mostrar o frame atual correspondente a posicao do braco.
	//Primeiro se seta tudo para a proxima exibicao, depois
	//se coloca a informacao devida em PORTA, PORTD e PORTE.
	//Se este frame for o numero 121, isso significa que o tempo
	//esta muito pequeno, entao, alem de cancelar esta interrupcao,
	//ele diminui a variavel delay para que o tempo aumente
	if(TMR0IF&&TMR0IE){
		/*TMR0IF = 0;
		TMR0 = delay;
	   if(frame<120){
	   	if(frame<60)PORTD = telaHF[frame];
			else        PORTD = telaHL[frame-60];
			if(frame%2==0){
				buf = telaL[frame>>1];
				PORTE = buf;
				PORTA = buf>>2;
			}
		}
		frame++;
		if(frame==122){TMR0IE = 0;delay--;}
		*/
		
		TMR0IF = 0;
		TMR0 = delay;
	    if(frame<60)PORTD = telaHF[frame];
		else        PORTD = telaHL[frame-60];
		if(frame%2==0){
			buf = telaL[frame>>1];
			PORTE = buf;
			PORTA = buf>>2;
		}
		if(frame==15){
			if(RC3)SENSOR&=~0b00000010;
			else   SENSOR|= 0b00000010;
			RC4 = 1;
		}else if(frame==30){
			if(RC3)SENSOR&=~0b00000100;
			else   SENSOR|= 0b00000100;
			RC4 = 1;
		}else if(frame==45){
			if(RC3)SENSOR&=~0b00001000;
			else   SENSOR|= 0b00001000;
			RC4 = 1;
		}else if(frame==60){
			if(RC3)SENSOR&=~0b00010000;
			else   SENSOR|= 0b00010000;
			RC4 = 1;
		}else if(frame==75){
			if(RC3)SENSOR&=~0b00100000;
			else   SENSOR|= 0b00100000;
			RC4 = 1;
		}else if(frame==90){
			if(RC3)SENSOR&=~0b01000000;
			else   SENSOR|= 0b01000000;
			RC4 = 1;
		}else if(frame==105){
			if(RC3)SENSOR&=~0b10000000;
			else   SENSOR|= 0b10000000;
			RC4 = 1;
		}else RC4 = 0;


		frame++;
		if(frame==120){
			TMR0IE = 0;
		}
	}
	//Por final, vem a interrupcao do RB0, que significa que
	//o corpo/braco esta passando pela posicao inicial.
	//Ele vai atualizar com o primeiro quadro e dizer qual vai ser
	//o tempo entre cada "bit" do desenho.
	if(INTF){
		INTF= 0;
		if(!INTEDG){
			TMR0 = 0;
			TMR0IE= 0;
			PORTD = telaHF[0];
			PORTE = telaL[0];
			PORTA = telaL[0]>>2;
			frame = 1;
			INTEDG = 1;
			RC4 = 1;
			if(RC3)SENSOR = 0b00000000;
			else   SENSOR = 0b00000001;
		}else{
			buf = CALIBRACAO - TMR0;
			if(delay<buf-1 || delay>buf+1)
			  delay = buf;
			TMR0 = delay;
			TMR0IF = 0;
			TMR0IE = 1;
			PORTD = telaHF[1];
			frame = 2;
			INTEDG = 0;
		}
		/*	
		PORTD = telaHF[0];
		PORTE = telaL[0];
		PORTA = telaL[0]>>2;
		if(frame<119)delay++;
		frame = 1;
	   TMR0 = delay;
	   TMR0IE = 1;*/
	}
}