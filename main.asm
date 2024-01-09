 [org 0x0100]

 jmp start


 
 btmlefty : dw 22
 btmleftx : dw 6
 
 btmleftyy : dw 22
 btmleftxx : dw 6

 temp : dw 0
 startx : dw 20
 starty : dw 5
 baseline : dw 18
 baseright : dw 40
 baseleft : dw 6
 message1: db ' '
 message2: db '|'
 message3: db ' '
 length:dw 1
 initialx : dw 20
 initialy : dw 5
 nextx : dw 64
 nexty : dw 11
 rotate : dw 0
 n : dw 0
 temp2 : dw 0
 n2 : dw 0
 n3 : dw 0
 temp3 : dw 0

 temp4: dw 0

 count: dw 8

 title : db 'TETRIS'
 length3: dw 6

 ;welcome screen
 wel:db 'WELCOME TO TETRIX'
 lw : dw 17
 name1: db'Hassan Adil  22L6543'
 name2: db'Arsal Manan  22L6610'
 name3: db'Rana Masab   22L6709'
 ln: dw 20

; score printing at the end

 sc:db 'YOUR TOTAL SCORE: '
 ls : dw 18

 press:db 'Press any key to start TETRIX'
 lpress : dw 29

 ;score
 scorestr: db ' SCORE : '
 length2 : dw 9
 num: dw 0
 oldisr: dd 0
 gameend: dw 0

 ;time
 timestr: db ' TIME :     s'
 length4 : dw 13
 time:dw 300 ; five minutes 
 tickcount: dw 0 

 

 statsstr:db ' STATS : '
 length5 :dw 9

 nextstr:db '  NEXT : '
 length6 :dw 9

clrscr: 
    push es
	push ax
	push di
	mov ax,0xb800
	mov es,ax
	mov di,0
	nextloc:
	mov word[es:di],0x0020
	add di,2
	cmp di,4000
	jne nextloc
	pop di
	pop ax
	pop es
	ret

clrscr2: 
    push es
	push ax
	push di
	mov ax,0xb800
	mov es,ax
	mov di,0
	nextloc1:
	mov word[es:di],0x0020
	add di,2
	cmp di,4000
    jne nextloc1
	pop di
	pop ax
	pop es
	ret
clrscr3: 
    push es
	push ax
	push di
	mov ax,0xb800
	mov es,ax
	mov di,0
	nextloc111:
	mov word[es:di],0x0020
	call sec_32
	add di,2
	cmp di,4000
    jne nextloc111
	pop di
	pop ax
	pop es
	ret

printstr: 
		  push bp
          mov bp,sp
          push es
          push ax
          push cx
          push si
          push di

	mov ax,0xb800
	mov es,ax
	mov al,80
	mul byte[bp+10]
	add ax,[bp+12]
	shl ax,1
	mov di,ax
	mov si,[bp+6]
	mov cx,[bp+4]
	mov ah,[bp+8]

 nextchar:  
 		   mov al,[si]
           mov [es:di],ax
           add di,2
           add si,1
           loop nextchar

           pop di
           pop si
           pop cx
           pop ax
           pop es
           pop bp
           ret 10

printnum:

 push bp
 mov bp, sp
 push es
 push ax
 push bx
 push cx
 push dx
 push di
 mov ax, 0xb800
 mov es, ax; es -> base

 mov ax, [bp+4] ; num
 mov bx, 10
 mov cx, 0

 nextdigit:
 mov dx, 0 
 div bx  
 add dl, 0x30  
 push dx 
 inc cx  
 cmp ax, 0  
 jnz nextdigit
 
 ;desired location
 mov al, 80 
 mul byte[bp+6]
 add ax, [bp+8]
 shl ax, 1
 mov di,ax


 
 

 ;print all digits
 nextpos: 

 pop dx  
 mov dh, 0x07 
 mov [es:di], dx 
 add di, 2  
 loop nextpos 


 pop di 
 pop dx 
 pop cx 
 pop bx 
 pop ax 
 pop es 
 pop bp 
 ret 6


shape1:

	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di
	
	mov ax, [bp+4] ;ypos
	add ax,3
	mov word [temp],ax
	mov dx, [bp+4] ;ypos
	
	l30:
		mov cx, 5
		mov bx,[bp+6] ;xpos
		l31:
			mov ax, bx ;xpos
			push ax
			mov ax, dx ;ypos
			push ax
			add bx,1
			mov ax, 0xC9
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz l31		

		add dx,1
		cmp word dx, [temp]
		jnz l30

	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4

shape2:
    push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di

		mov cx, 3
		;mov bx, 18 ; ypos
		mov bx, [bp+4]
		l34:
			mov ax, [bp+6] ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x99
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz l34

		mov cx, 3
		;mov bx, 18 ; ypos
		mov bx, [bp+4]
		lll34:
			mov ax, [bp+6] ;xpos
			add ax,1
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x99
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz lll34


	mov cx, 6
	mov bx,[bp+6] ;XPOS
	sub bx,2
		lll46:
			mov ax, bx
			push ax
			mov ax, [bp+4] ;YPOS
			add ax,1
			push ax
			add bx,1
			mov ax, 0x99
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			sub cx, 1
			
			cmp cx, 0
			jnz lll46

	
    pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4

shape3:
	
	;L
	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di
	


		mov cx, 3
		;mov bx, 18 ; ypos
		mov bx, [bp+4]
		l44:
			mov ax, [bp+6] ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0xB9
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz l44

		mov cx, 3
		;mov bx, 18 ; ypos
		mov bx, [bp+4]
		l45:
			mov ax, [bp+6] ;xpos
			add ax,1
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0xB9
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz l45
		


		mov cx, 5
		mov bx,[bp+6] ;XPOS
		l46:
			mov ax, bx
			push ax
			mov ax, [bp+4] ;YPOS
			add ax,2
			push ax
			add bx,1
			mov ax, 0xB9
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			sub cx, 1
			
			cmp cx, 0
			jnz l46

	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4
shape4:
    push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di

	


		mov cx, 3
		mov bx,[bp+6] ;XPOS
		l48:
			mov ax, bx
			push ax
			mov ax, [bp+4] ;YPOS
			push ax
			add bx,1
			mov ax, 0xD9
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz l48

		mov cx, 3
		mov bx,[bp+6] ;XPOS
        add bx,2
		l49:
			mov ax, bx
			push ax
			mov ax, [bp+4] ;YPOS
            sub ax,1
			push ax
			add bx,1
			mov ax, 0xD9
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz l49
		
		pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4


	


makeboard:
  ;MAIN WINDOw;background
    push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di
    call clrscr

	mov dx, 1
	l1:
	
		mov cx, 44
		mov bx,4
		l2:
			mov ax, bx
			push ax
			mov ax, dx
			push ax
			add bx,1
			mov ax, 0x28
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l2
		add dx,1
		cmp dx,24
		jnz l1

	;foreground
	mov dx, 2
	ll1:
	
		mov cx, 40
		mov bx,6
		ll2:
			mov ax, bx
			push ax
			mov ax, dx
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz ll2
		add dx,1
		cmp dx,23
		jnz ll1



 ; NEXT WINDOW
	mov dx, 8 ;ypos
	l3:
	
		mov cx, 25
		mov bx,53 ;xpos
		l4:
			mov ax, bx
			push ax
			mov ax, dx
			push ax
			add bx,1
			mov ax, 0x2A
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l4
		add dx,1
		cmp dx,17
		jnz l3

	mov dx, 9 ;ypos
	ll3:
	
		mov cx, 23
		mov bx, 54 ;xpos
		ll4:
			mov ax, bx
			push ax
			mov ax, dx
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz ll4
		add dx,1
		cmp dx,16
		jnz ll3


	; SCORE AND TIMMER WINDOW
	mov dx, 18 ;ypos
	l03:
	
		mov cx, 25
		mov bx,53 ;xpos
		l04:
			mov ax, bx
			push ax
			mov ax, dx
			push ax
			add bx,1
			mov ax, 0x2A
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l04
		add dx,1
		cmp dx,24
		jnz l03

	mov dx, 19 ;ypos
	ll03:
	
		mov cx, 23
		mov bx, 54 ;xpos
		ll04:
			mov ax, bx
			push ax
			mov ax, dx
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz ll04
		add dx,1
		cmp dx,23
		jnz ll03
	
    pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret


tetris:
    push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di

	;T
		mov cx, 5
		mov bx,50 ;XPOS
		l52:
			mov ax, bx
			push ax
			mov ax, 2 ;YPOS
			push ax
			add bx,1
			mov ax, 0x10
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_3
			sub cx, 1
			
			cmp cx, 0
			jnz l52

		mov cx, 4
		mov bx, 3 ; ypos
		l50:
			mov ax, 53 ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x10
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_3
			sub cx, 1
			cmp cx, 0
			jnz l50





		;E

		mov cx, 4
		mov bx, 56 ;XPOS
		l53:
			mov ax, bx
			push ax
			mov ax, 2 ;YPOS
			push ax
			add bx,1
			mov ax, 0x50
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_3
			sub cx, 1
			cmp cx, 0
			jnz l53


		mov cx, 4
		mov bx,3 ; ypos
		l54:
			mov ax, 56 ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x50
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_3
			sub cx, 1
			cmp cx, 0
			jnz l54
		
		
		mov cx, 4
		mov bx, 56 ;XPOS
		l55:
			mov ax, bx
			push ax
			mov ax, 4 ;YPOS
			push ax
			add bx,1
			mov ax, 0x50
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_3
			sub cx, 1
			cmp cx, 0
			jnz l55

		mov cx, 4
		mov bx, 56 ;XPOS
		l56:
			mov ax, bx
			push ax
			mov ax, 6 ;YPOS
			push ax
			add bx,1
			mov ax, 0x50
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_3
			sub cx, 1
			cmp cx, 0
			jnz l56
		



		;T

		mov cx, 5
		mov bx,61 ;XPOS
		l57:
			mov ax, bx
			push ax
			mov ax, 2 ;YPOS
			push ax
			add bx,1
			mov ax, 0x40
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_3
			sub cx, 1
			
			cmp cx, 0
			jnz l57

		mov cx, 4
		mov bx, 3 ; ypos
		l58:
			mov ax, 63 ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x40
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_3
			sub cx, 1
			cmp cx, 0
			jnz l58



		;R

		mov cx, 5
		mov bx, 2 ; ypos
		l59:
			mov ax, 67 ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0xB9
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_3
			sub cx, 1
			cmp cx, 0
			jnz l59

			mov ax, 68 ;xpos
			push ax
			mov ax, 2
			push ax
			add bx,1
			mov ax, 0xB9
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr

			mov ax, 69 ;xpos
			push ax
			mov ax, 3
			push ax
			add bx,1
			mov ax, 0xB9
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr


		mov cx,3
		mov bx,67 ; ypos
		l60:
			mov ax, bx ;xpos
			push ax
			mov ax, 4
			push ax
			add bx,1
			mov ax, 0xB9
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_3
			sub cx, 1
			cmp cx, 0
			jnz l60

		mov cx,5
		mov bx,68 ; ypos
		l61:
			mov ax, bx ;xpos
			push ax
			mov ax, cx
			push ax
			add bx,1
			mov ax, 0xB9
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_3
			add cx, 1
			cmp cx, 7
			jnz l61




		;I

		mov cx, 5
		mov bx, 2 ; ypos
		l62:
			mov ax, 71 ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x60
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_3
			sub cx, 1
			cmp cx, 0
			jnz l62






		;X

		mov cx, 2
		mov bx,73 ; ypos
		l63:
			mov ax, bx ;xpos
			push ax
			mov ax, cx
			push ax
			add bx,1
			mov ax, 0x77
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_3
			add cx, 1
			cmp cx, 7
			jnz l63

		
		mov cx, 6
		mov bx,73 ; ypos
		l64:
			mov ax, bx ;xpos
			push ax
			mov ax, cx
			push ax
			add bx,1
			mov ax, 0x77
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_3
			sub cx, 1
			cmp cx, 1
			jnz l64


		


    pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp


	ret

printing:
    push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di

 mov ax, 60
 push ax
 mov ax, 8
 push ax
 mov ax, 0x0A
 push ax
 mov ax, nextstr
 push ax
 push word [length6]
 call printstr

 mov ax, 60
 push ax
 mov ax, 18
 push ax
 mov ax, 0x0A
 push ax
 mov ax, statsstr
 push ax
 push word [length5]
 call printstr

 mov ax, 60
 push ax
 mov ax, 20
 push ax
 mov ax, 0x0A
 push ax
 mov ax, scorestr
 push ax
 push word [length2]
 call printstr

 mov ax, 69
 push ax ; x pos
 mov ax, 20
 push ax; y pos
 mov ax, [num]
 push ax
 call printnum

 ;printing time
 mov ax, 60
 push ax
 mov ax, 21
 push ax
 mov ax, 0x0A
 push ax
 mov ax, timestr
 push ax
 push word [length4]
 call printstr

 mov ax, 68
 push ax ; x pos
 mov ax, 21
 push ax; y pos
 mov ax, [time]
 push ax
 call printnum

    pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp


	ret

desshape1:

	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di
	
	mov ax, [bp+4] ;ypos
	add ax,3
	mov word [temp],ax
	mov dx, [bp+4] ;ypos
	
	ll30:
		mov cx, 5
		mov bx,[bp+6] ;xpos
		ll31:
			mov ax, bx ;xpos
			push ax
			mov ax, dx ;ypos
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz ll31		

		add dx,1
		cmp word dx, [temp]
		jnz ll30

	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4

desshape4:
    push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di

		mov cx, 3
		mov bx,[bp+6] ;XPOS
		ll48:
			mov ax, bx
			push ax
			mov ax, [bp+4] ;YPOS
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz ll48

		mov cx, 3
		mov bx,[bp+6] ;XPOS
        add bx,2
		ll49:
			mov ax, bx
			push ax
			mov ax, [bp+4] ;YPOS
            sub ax,1
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz ll49

	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4

desshape3:
	
	;L
	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di
	


		mov cx, 3
		;mov bx, 18 ; ypos
		mov bx, [bp+4]
		ll44:
			mov ax, [bp+6] ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz ll44

		mov cx, 3
		;mov bx, 18 ; ypos
		mov bx, [bp+4]
		ll45:
			mov ax, [bp+6] ;xpos
			add ax,1
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz ll45


		mov cx, 5
		mov bx,[bp+6] ;XPOS
		ll46:
			mov ax, bx
			push ax
			mov ax, [bp+4] ;YPOS
			add ax,2
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			sub cx, 1
			
			cmp cx, 0
			jnz ll46

	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4


desshape2:
    push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di

		mov cx, 3
		;mov bx, 18 ; ypos
		mov bx, [bp+4]
		ll34:
			mov ax, [bp+6] ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz ll34

		mov cx, 3
		;mov bx, 18 ; ypos
		mov bx, [bp+4]
		llll34:
			mov ax, [bp+6] ;xpos
			add ax,1
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz llll34

	mov cx, 6
	mov bx,[bp+6] ;XPOS
	sub bx,2
		llll46:
			mov ax, bx
			push ax
			mov ax, [bp+4] ;YPOS
			add ax,1
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			sub cx, 1
			
			cmp cx, 0
			jnz llll46

	
    pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4


shape4r1:
    push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di

		mov cx, 2 ; inner loop
		mov dx,3; outer loop
		mov bx,[bp+4] ;YPOS
			lr1:
				mov ax, [bp+6]
				push ax
				mov ax, bx ;YPOS
				push ax
				mov ax, 0xD9
				push ax
				mov ax, message2
				push ax
				push word [length]
				call printstr

                add word [bp+6], 1
				mov ax, [bp+6]
				push ax
				mov ax, bx ;YPOS
				push ax
				mov ax, 0xD9
				push ax
				mov ax, message2
				push ax
				push word [length]
				call printstr

                sub word [bp+6], 1
				add bx, 1
				mov ax, [bp+6]
				push ax
				mov ax, bx ;YPOS
				push ax
				mov ax, 0xD9
				push ax
				mov ax, message2
				push ax
				push word [length]
				call printstr

                add word [bp+6], 1
				mov ax, [bp+6]
				push ax
				mov ax, bx ;YPOS
				push ax
				mov ax, 0xD9
				push ax
				mov ax, message2
				push ax
				push word [length]
				call printstr


				

                ;add bx, 1
				add word [bp+6], 1 
				sub cx, 1
				cmp cx, 0
				jnz lr1


	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4

desshape4r1:
    push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di

		mov cx, 2 ; inner loop
		mov dx,3; outer loop
		mov bx,[bp+4] ;YPOS
			lr2:
				mov ax, [bp+6]
				push ax
				mov ax, bx ;YPOS
				push ax
				
				mov ax, 0x00
				push ax
				mov ax, message1
				push ax
				push word [length]
				call printstr

                add word [bp+6], 1
				mov ax, [bp+6]
				push ax
				mov ax, bx ;YPOS
				push ax
				mov ax, 0x00
				push ax
				mov ax, message1
				push ax
				push word [length]
				call printstr

                sub word [bp+6], 1
				add bx, 1
				mov ax, [bp+6]
				push ax
				mov ax, bx ;YPOS
				push ax
				mov ax, 0x00
				push ax
				mov ax, message1
				push ax
				push word [length]
				call printstr

                add word [bp+6], 1
				mov ax, [bp+6]
				push ax
				mov ax, bx ;YPOS
				push ax
				mov ax, 0x00
				push ax
				mov ax, message1
				push ax
				push word [length]
				call printstr


				

                ;add bx, 1
				add word [bp+6], 1 
				sub cx, 1
				cmp cx, 0
				jnz lr2


	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4

shape3r2:
	
	;L
	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di
	

        mov cx, 5
		mov bx,[bp+6] ;XPOS
		lllr47:
			mov ax, bx
			push ax
			mov ax, [bp+4] ;YPOS
			;add ax,2
			push ax
			add bx,1
			mov ax, 0xB9
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			sub cx, 1
			
			cmp cx, 0
			jnz lllr47

		mov cx, 3
		;mov bx, 18 ; ypos
		mov bx, [bp+4]
		llllr45:
			mov ax, [bp+6] ;xpos
			add ax,3
			push ax
			mov ax, bx
			push ax
			;add bx,1
			mov ax, 0xB9
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			;add word [bp+6], 1

			mov ax, [bp+6] ;xpos
			add ax,4
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0xB9
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz llllr45
		


		

	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4

desshape3r2:
	
	;L
	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di
	

        mov cx, 5
		mov bx,[bp+6] ;XPOS
		llllr47:
			mov ax, bx
			push ax
			mov ax, [bp+4] ;YPOS
			;add ax,2
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			sub cx, 1
			
			cmp cx, 0
			jnz llllr47

		mov cx, 3
		;mov bx, 18 ; ypos
		add word [bp+6], 3
		mov bx, [bp+4]
		lllllr45:
			mov ax, [bp+6] ;xpos
			push ax
			mov ax, bx
			push ax
			;add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			;add word [bp+6], 1

			mov ax, [bp+6] ;xpos
			add ax,1
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz lllllr45
		


		

	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4

shape3r1:
	
	;L
	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di
	


		mov cx, 3
		mov bx, [bp+4] ;ypos
		lll45:
			mov ax, [bp+6] ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0xB9
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz lll45

		mov cx, 3
		;mov bx, 18 ; ypos
		mov bx, [bp+4]
		lllo46:
			mov ax, [bp+6] ;xpos
			add ax,1
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0xB9
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz lllo46
		


		mov cx, 5
		mov bx,[bp+6] ;XPOS
		lll47:
			mov ax, bx
			push ax
			mov ax, [bp+4] ;YPOS
			;add ax,2
			push ax
			add bx,1
			mov ax, 0xB9
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			sub cx, 1
			
			cmp cx, 0
			jnz lll47

	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4

desshape3r1:
	
	;L
	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di
	


		mov cx, 3
		;mov bx, 18 ; ypos
		mov bx, [bp+4]
		llllo45:
			mov ax, [bp+6] ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz llllo45

		mov cx, 3
		;mov bx, 18 ; ypos
		mov bx, [bp+4]
		llllo46:
			mov ax, [bp+6] ;xpos
			add ax,1
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz llllo46
		


		mov cx, 5
		mov bx,[bp+6] ;XPOS
		lllo47:
			mov ax, bx
			push ax
			mov ax, [bp+4] ;YPOS
			;add ax,2
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			sub cx, 1
			
			cmp cx, 0
			jnz lllo47

	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4

checkcoordinate:
	push bp
	mov bp,sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di

	jmp mainlo

	d2: add word [n],1
		jmp endll1


	mainlo:

	mov cx,0
	lo1:
	mov ax,[bp+6]
	mov word [temp2],ax
	add word [temp2],cx
	mov ax,0
	mov al,80
	mul byte[bp+4] ;ypos
	add ax,[temp2]
	shl ax,1
	mov di,ax
	mov ax,0xb800
	mov es,ax
	cmp word [es:di],0x0020
	jnz d2
	add cx,1
	cmp cx,5
	jnz lo1
	
 endll1:
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4

checkcoordinate2:
	push bp
	mov bp,sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di

	jmp mainlo1

	d22: add word [n2],1
		jmp endll11


	mainlo1:

	mov cx,0
	lo11:
	mov ax,[bp+4] ;ypos
	mov word [temp2],ax
	add word [temp2],cx
	mov ax,0
	mov al,80
	mul byte[temp2] ;ypos
	add ax,[bp+6] ;xpos
	shl ax,1
	mov di,ax
	mov ax,0xb800
	mov es,ax
	cmp word [es:di],0x0020
	jnz d22
	add cx,1
	cmp cx,3
	jnz lo11
	
 endll11:
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4


checkcoordinate3:
	push bp
	mov bp,sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di

	jmp mainlo11

	d222: add word [n3],1
		jmp endll111


	
	mainlo11:
	mov ax,[bp+4] ;ypos
	mov word [temp3],ax
	mov ax,0
	mov al,80
	mul byte[temp3] ;ypos
	add ax,[bp+6] ;xpos
	shl ax,1
	mov di,ax
	mov ax,0xb800
	mov es,ax
	cmp word [es:di],0x0020
	jnz d222
	
 endll111:
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4
checkcoordinate4:
	push bp
	mov bp,sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di

	jmp mainlo2

	d21: add word [n],1
		jmp endll12


	mainlo2:

	mov cx,0
	lo12:
	mov ax,[bp+6] ;xpos
	mov word [temp2],ax
	add word [temp2],cx
	mov ax,0
	mov al,80
	mul byte[bp+4] ;ypos
	add ax,[temp2] ;xpos
	shl ax,1
	mov di,ax
	mov ax,0xb800
	mov es,ax
	cmp word [es:di],0x0020
	jnz d21
	add cx,1
	cmp cx,2
	jnz lo12
	
 endll12:
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4

printnum1:
 push bp 
 mov bp, sp 
 push es 
 push ax 
 push bx 
 push cx 
 push dx 
 push di 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov ax, [bp+4] ; load number in ax 
 mov bx, 10 ; use base 10 for division 
 mov cx, 0 ; initialize count of digits 
nextdigit1: 
 mov dx, 0 ; zero upper half of dividend 
 div bx ; divide by 10 
 add dl, 0x30 ; convert digit into ascii value 
 push dx ; save ascii value on stack 
 inc cx ; increment count of values 
 cmp ax, 0 ; is the quotient zero 
 jnz nextdigit1 ; if no divide it again 
 mov di, 3496 ; point di to 70th column 
 nextpos1: pop dx ; remove a digit from the stack 
 mov dh, 0x07 ; use normal attribute 
 mov [es:di], dx ; print char on screen 

 add di, 2 ; move to next screen location 
 loop nextpos1 ; repeat for all digits on stack 
 pop di 
 pop dx 
 pop cx 
 pop bx 
 pop ax
 pop es 
 pop bp 
 ret 2 




timer:
 push ax 
 cmp word [time], 0
 jne go
 call delayingloop1
 call endgame
 call delayingloop11
 call endgame
 call clrscr3
 call delayingloop11
 call endgame
 call delayingloop11
 call clrscr
 call delayingloop11
 call endgame
 call delayingloop11
 call clrscr
 call delayingloop11
 call endgame
 call delayingloop11
 call clrscr2
 call delayingloop11

 call endgame
 call sec_3
 call clrscr

 mov ax, 26
 push ax
 mov ax, 8
 push ax
 mov ax, 0x0A
 push ax
 mov ax, sc
 push ax
 push word [ls]
 call printstr

 mov ax, 46
 push ax ; x pos
 mov ax, 8
 push ax; y pos
 mov ax, [num]
 push ax
 call printnum


 mov ax,[oldisr]
    mov bx,[oldisr+2]
    cli
    mov [es:8*4],ax
    mov [es:8*4+2],bx
    sti
 mov ax, 0x4c00
 int 21h

 go:
 inc word [cs:tickcount]; increment tick count 
 cmp word [cs:tickcount], 18
 je lt1
 jne lt2

 lt1:
 dec word [cs:time]
 cmp word[cs:time], 0
 jz end
 mov word[cs:tickcount],0
 lt2:
 push word [cs:time] 
 call printnum1 ; print tick count 
 mov word [gameend], 1
 end:

 mov al, 0x20 
 out 0x20, al ; end of interrupt 
 pop ax 
 iret ; return from interrupt 



delayingloop1:
    push cx
    mov cx, 0x0100  ; Adjust the count as needed for your desired delay
	delayingloop2:
    	dec cx
    	jnz delayingloop2
    	pop cx
    	dec cx
    	jnz delayingloop1
	ret

delayingloop11:
    push cx
    mov cx, 0x000A  ; Adjust the count as needed for your desired delay
	delayingloop22:
    	dec cx
    	jnz delayingloop22
    	pop cx
    	dec cx
    	jnz delayingloop11
	ret
 
endgame:
	
	;G
		mov cx, 8
		mov bx,9
		l5:
			mov ax, bx
			push ax
			mov ax, 8
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l5

		mov cx, 8
		mov bx,9
		l6:
			mov ax, bx
			push ax
			mov ax, 12
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l6

		mov cx, 3
		mov bx,9
		l7:
			mov ax, 9
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l7


		mov cx, 3
		mov bx,11
		l8:
			mov ax, 17 ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l8
	
	;A

		mov cx, 8
		mov bx,19
		l9:
			mov ax, bx
			push ax
			mov ax, 8
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l9

		mov cx, 4
		mov bx,9 ; ypos
		l10:
			mov ax, 19 ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l10
		
		mov cx, 8
		mov bx,19 ;xpos
		l11:
			mov ax, bx 
			push ax
			mov ax, 11 ;ypos
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l11

		mov cx, 4
		mov bx,9 ; ypos
		l12:
			mov ax, 26 ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l12
	;M
		mov cx, 5
		mov bx,8 ; ypos
		l13:
			mov ax, 28 ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l13

		mov ax, 29 ;xpos
		push ax
		mov ax, 8 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 30 ;xpos
		push ax
		mov ax, 8 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 31 ;xpos
		push ax
		mov ax, 9 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 32 ;xpos
		push ax
		mov ax, 9 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 33 ;xpos
		push ax
		mov ax, 8 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 34 ;xpos
		push ax
		mov ax, 8 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov cx, 5
		mov bx,8 ; ypos
		l14:
			mov ax, 35 ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l14

	;E

		mov cx, 8
		mov bx, 37 ;XPOS
		l15:
			mov ax, bx
			push ax
			mov ax, 8 ;YPOS
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l15


		mov cx, 4
		mov bx,9 ; ypos
		l16:
			mov ax, 37 ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l16
		
		
		mov cx, 8
		mov bx, 37 ;XPOS
		l17:
			mov ax, bx
			push ax
			mov ax, 10 ;YPOS
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l17

		mov cx, 8
		mov bx, 37 ;XPOS
		l18:
			mov ax, bx
			push ax
			mov ax, 12 ;YPOS
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l18

	;E

		mov cx, 8
		mov bx, 28 ;XPOS
		l19:
			mov ax, bx
			push ax
			mov ax, 15 ;YPOS
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l19


		mov cx, 4
		mov bx, 15 ; ypos
		l20:
			mov ax, 28 ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l20
		
		
		mov cx, 8
		mov bx, 28 ;XPOS
		l21:
			mov ax, bx
			push ax
			mov ax, 17 ;YPOS
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l21

		mov cx, 8
		mov bx, 28 ;XPOS
		l22:
			mov ax, bx
			push ax
			mov ax, 19 ;YPOS
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l22

	;N
		mov cx, 5
		mov bx, 15 ; ypos
		l23:
			mov ax, 37 ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l23

		mov ax, 38 ;xpos
		push ax
		mov ax, 15 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 39 ;xpos
		push ax
		mov ax, 16 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 40 ;xpos
		push ax
		mov ax, 17 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 41 ;xpos
		push ax
		mov ax, 18 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 42 ;xpos
		push ax
		mov ax, 19 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr


		mov cx, 5
		mov bx, 15 ; ypos
		l24:
			mov ax, 43 ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l24

	;D
		mov cx, 5
		mov bx, 15 ; ypos
		l25:
			mov ax, 49 ;xpos
			push ax
			mov ax, bx
			push ax
			add bx,1
			mov ax, 0x4C
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
            call sec_32
			sub cx, 1
			cmp cx, 0
			jnz l25

		mov ax, 50 ;xpos
		push ax
		mov ax, 15 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 51 ;xpos
		push ax
		mov ax, 15 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 52 ;xpos
		push ax
		mov ax, 16 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 53 ;xpos
		push ax
		mov ax, 16 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 52 ;xpos
		push ax
		mov ax, 17 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 53 ;xpos
		push ax
		mov ax, 17 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 52 ;xpos
		push ax
		mov ax, 18 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 53 ;xpos
		push ax
		mov ax, 18 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 50 ;xpos
		push ax
		mov ax, 19 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr

		mov ax, 51 ;xpos
		push ax
		mov ax, 19 ;ypos
		push ax
		add bx,1
		mov ax, 0x4C
		push ax
		mov ax, message1
		push ax
		push word [length]
		call printstr
		
	ret





rowdes:

 	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di

	
	
		mov cx, 40
		mov bx,[bp+6] ;xpos
		mov dx, [bp+4] ;ypos
		l031:
			mov ax, bx ;xpos
			push ax
			mov ax, dx ;ypos
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message1
			push ax
			push word [length]
			call printstr
			call sec_3
			sub cx, 1
			cmp cx, 0
		jnz l031		

		
    
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4

DeleteRow:
    push bp             
    mov bp, sp          
    push ax             
    push bx
    push cx
    push dx
    push es
    push di
    push si
    push ds
    mov ax, 80          
    mul byte [bp+4]    
    mov di, ax         
    add di, 6           
    shl di, 1           
    mov si, di          
    sub si, 160         
    mov ax, 0xb800      
    mov es, ax
    mov ds, ax
	mms:
    mov ax, si          
    push ax             
    mov cx, 40          
    cld                
    rep movsw           
    pop di              
    mov si, di          
    sub si, 160         
    dec dx             
    jnz mms              
    mov ax, 0x0020      
    mov cx, 40          
    mov di, 328         
    cld                
    rep stosw           
    pop ds              
    pop si              
    pop di
    pop es
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp              
    ret 2
destructrow:
	push bp 
 	mov bp, sp 
 	push es 
 	push ax 
 	push si 
 	push di 
 	push ds 
 	pop es 
	push cx
	push bx
	mov ax, 0xb800 
	mov es, ax ; point es to video base

 checking:
	mov al, 80 ; load al with columns per row 
	mul byte [btmlefty] ; multiply with y position 
	add ax, [btmleftx] ; add x position 
	shl ax, 1 ; turn into byte offset 
 	mov di,ax ; point di to required location 
	mov ax,0x0020

 	cld ; auto increment mode 
	mov cx,40
	repne scasw
	cmp cx,0
	jz destruct
	jmp nodestruct

 destruct: 

	; call rowdes

    mov ax, [btmleftx] ;x_left right 
    push ax
    mov ax, [btmlefty]
    push ax
    call rowdes
	call sec_3
    mov ax, [btmlefty]
    push ax
	call DeleteRow

	add word [num] , 10
	mov ax, 69
    push ax ; x pos
    mov ax, 20
    push ax; y pos
    mov ax, [num]
    push ax
    call printnum
    



 nodestruct:
	sub word [btmlefty],1	
	cmp word[btmlefty],3		
	jne checking


	pop bx
	pop cx
	pop di 
 	pop si  
 	pop ax 
 	pop es 
 	pop bp

	ret

sec_3:
 push bp
 mov bp,sp
 push cx
 push cx
 push dx
 mov cx, 00ffh
 mov dx, 00ffh
 lop1:
 dec dx
 jnz lop1
 mov dx, cx
 loop lop1 ; loops till cx

 pop dx
 pop cx
 mov sp,bp
 pop bp
 ret

sec_32:
 push bp
 mov bp,sp
 push cx
 push cx
 push dx
 mov cx, 003fh
 mov dx, 003fh
 lop11:
 dec dx
 jnz lop11
 mov dx, cx
 loop lop11 ; loops till cx

 pop dx
 pop cx
 mov sp,bp
 pop bp
 ret


shape5:

	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di
	
	
	
	
		mov cx, 5
		mov bx,[bp+6] ;xpos
		l315:
			mov ax, bx ;xpos
			push ax
			mov ax, [bp+4] ;ypos
			push ax
			add bx,1
			mov ax, 0xC9
			push ax
			mov ax, message2
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz l315	

	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4

desshape5:

	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di
	
	
	
	
		mov cx, 5
		mov bx,[bp+6] ;xpos
		l3150:
			mov ax, bx ;xpos
			push ax
			mov ax, [bp+4] ;ypos
			push ax
			add bx,1
			mov ax, 0x00
			push ax
			mov ax, message3
			push ax
			push word [length]
			call printstr
			sub cx, 1
			cmp cx, 0
			jnz l3150	

	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop es
	pop bp
	ret 4
welcome:

 mov ax, 26
 push ax
 mov ax, 8
 push ax
 mov ax, 0x0C
 push ax
 mov ax, wel
 push ax
 push word [lw]
 call printstr

 mov ax, 26
 push ax
 mov ax, 10
 push ax
 mov ax, 0x0C
 push ax
 mov ax, name1
 push ax
 push word [ln]
 call printstr

 
 mov ax, 26
 push ax
 mov ax, 11
 push ax
 mov ax, 0x0C
 push ax
 mov ax, name2
 push ax
 push word [ln]
 call printstr


 mov ax, 26
 push ax
 mov ax, 12
 push ax
 mov ax, 0x0C
 push ax
 mov ax, name3
 push ax
 push word [ln]
 call printstr

 mov ax, 26
 push ax
 mov ax, 15
 push ax
 mov ax, 0x0C
 push ax
 mov ax, press
 push ax
 push word [lpress]
 call printstr

 ret
start: 
 call clrscr

 call welcome
 mov ah, 0
 int 16h

 ;For timer
    xor ax, ax
    mov es, ax ; point es to IVT base 
    mov ax,[es:8*4]
    mov [oldisr],ax
    mov ax,[es:8*4+2]
    mov [oldisr+2],ax
    cli ; disable interrupts
    mov word [es:8*4], timer ; store offset at n*4
	mov [es:8*4+2], cs ; store segment at n*4+2
    sti ; enable interrupts



 call clrscr
 call makeboard
 call tetris


 mov ax, 60
 push ax
 mov ax, 8
 push ax
 mov ax, 0x0A
 push ax
 mov ax, nextstr
 push ax
 push word [length6]
 call printstr

 mov ax, 60
 push ax
 mov ax, 18
 push ax
 mov ax, 0x0A
 push ax
 mov ax, statsstr
 push ax
 push word [length5]
 call printstr

 mov ax, 60
 push ax
 mov ax, 20
 push ax
 mov ax, 0x0A
 push ax
 mov ax, scorestr
 push ax
 push word [length2]
 call printstr

 mov ax, 69
 push ax ; x pos
 mov ax, 20
 push ax; y pos
 mov ax, [num]
 push ax
 call printnum

 ;printing time
 mov ax, 60
 push ax
 mov ax, 21
 push ax
 mov ax, 0x0A
 push ax
 mov ax, timestr
 push ax
 push word [length4]
 call printstr

 mov ax, 68
 push ax ; x pos
 mov ax, 21
 push ax; y pos
 mov ax, [time]
 push ax
 call printnum


 mainloop:

 lm: 
 cmp word[gameend], 1
 jne lm
 

 mov word [n], 0 
 mov word [n2],0
 mov word [n3],0
 ;FOR SHAPE 3
 push word [nextx]
 push word [nexty]
 call shape2

 mov bx, [starty] 
 mov [initialy],bx
 
 mov bx, [startx] ;x_left right
 mov [initialx],bx
 
 mov dx,0 ;y_inc
 mov bx, [startx] ;x_left right
 lll2:

	mov word [n3] , 0
	mov word [n2] , 0

	jmp r1
	enterkey1: 
 	add word [rotate],1
	push word [initialx]
	push word [initialy]
	call desshape3
    jmp endl1
	r1:
	cmp word [rotate],1
	jne no1

	push word [initialx]
	push word [initialy]
	call desshape1
    mov ax, bx
    push ax 
	mov [initialx],ax
    mov ax, [starty]
    add ax,dx
    push ax
	mov [initialy],ax
    call shape3r1
    mov ah,0
    int 16h
	cmp ah,0x48
	jz enterkey1
    cmp ah,0x4B
    jnz right322
	mov word [temp],ax
	mov word [temp4],bx
	sub word [temp4],1
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
    push ax ;ypos
	call checkcoordinate2
	cmp word [n2],0
    jnz right322
    sub bx,1
	jmp endl1

	no1 : jmp norotate

    right322: 
    cmp ah,0x4D
    jnz down322
    mov word [temp],ax
	mov word [temp4],bx
	add word [temp4],5
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
    push ax
	call checkcoordinate3
	mov word [temp4],bx
	add word [temp4],2
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,1
    push ax
	call checkcoordinate3
	mov word [temp4],bx
	add word [temp4],2
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,2
    push ax
	call checkcoordinate3
	mov word ax, [temp]
	cmp word [n3],0
    jnz down322
    add bx,1
    down322:
    cmp ah, 0x50 
    jnz lll2
	mov word [temp],ax
	mov word [temp4], bx
	add word [temp4],2
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,1
    push ax
	call checkcoordinate4
	mov word [temp4], bx
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,3
    push ax
	call checkcoordinate4
	mov word ax, [temp]
    add dx,1
	jmp endl1
	
 norotate: 
	cmp word [rotate],2
	je intee2

	push word [initialx]
	push word [initialy]
    call desshape3
    push bx 
	mov [initialx],bx
    mov ax, [starty]
    add ax,dx
    push ax
	mov [initialy],ax
    call shape3

    mov ah,0
    int 16h
	tem1:  cmp ah,0x48
	jz enterkey1

    cmp ah,0x4B
    jnz right311
	mov word [temp],ax
	mov word [temp4],bx
	sub word [temp4],1
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
    push ax ;ypos
	call checkcoordinate2
	cmp word [n2],0
	jnz intee3
    sub bx,1
	jmp right311
	intee2: jmp r2

    right311: 
    cmp ah,0x4D
    jnz down311
	mov word [temp],ax
	mov word [temp4],bx
	add word [temp4],2
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
    push ax
	call checkcoordinate3
	mov word [temp4],bx
	add word [temp4],2
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,1
    push ax
	call checkcoordinate3
	mov word [temp4],bx
	add word [temp4],5
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,2
    push ax
	call checkcoordinate3
	mov word ax, [temp]
	cmp word [n3],0
    jnz down311
    add bx,1
	intee3: jmp intee

    down311:
    cmp ah, 0x50 
    jnz lll2
	mov word [temp],ax
	push bx
    mov ax, [starty]
	add ax,dx
	add ax,3
    push ax
	call checkcoordinate
	mov word ax, [temp]
    add dx,1
	intee:jmp endl1

	r2: 
    push word [initialx]
	push word [initialy]
	call desshape3r2
    mov ax, bx
    push ax 
	mov [initialx],ax
    mov ax, [starty]
    add ax,dx
    push ax
	mov [initialy],ax
    call shape3r2
    mov ah,0
    int 16h
	cmp ah,0x48 ; up
	jz inteee
    cmp ah,0x4B ; left
    jnz right321
	mov word [temp],ax
	mov word [temp4],bx
	sub word [temp4],1
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
    push ax
	call checkcoordinate3
	mov word [temp4],bx
	add word [temp4],2
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,1
    push ax
	call checkcoordinate3
	mov word [temp4],bx
	add word [temp4],2
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,2
    push ax
	call checkcoordinate3
	mov word ax, [temp]
	cmp word [n3],0
    jnz right321
    sub bx,1
	jmp endl1
	inteee: jmp enterkey2

    right321: 
    cmp ah,0x4D ; right
    jnz down321
    mov word [temp],ax
	mov word [temp4],bx
	add word [temp4],5
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
    push ax ;ypos
	call checkcoordinate2
	cmp word [n2],0
    jnz down321
    add bx,1

    down321:
    cmp ah, 0x50 ;down
    jnz lll2
	mov word [temp],ax
	mov word [temp4], bx
	;sub word [temp4],1
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,1
    push ax
	call checkcoordinate4
	mov word [temp4], bx
	add word [temp4],3
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,3
    push ax
	call checkcoordinate4
	mov word ax, [temp]
    add dx,1
	jmp endl1

	
	
 
 enterkey2: 
 	add word [rotate],1
	push word [initialx]
	push word [initialy]
	call desshape3r2
 ;add dx,1
 endl1: 
	cmp word [n],1
    jnz lll2
    call destructrow
    mov word [btmlefty], 22

 ;FOR SHAPE 2
 mov word [n],0
 push word [nextx]
 push word [nexty]
 call desshape1
 push word [nextx]
 push word [nexty]
 call shape4

 mov dx,0 ;y_inc
 mov bx, [starty] 
 mov [initialy],bx
 
 mov bx, [startx] ;x_left right
 mov [initialx],bx
 lll22:
	mov word[n3],0
	push word [initialx]
	push word [initialy]
	call desshape2
    mov ax, bx
    push ax 
	mov [initialx],ax
    mov ax, [starty]
    add ax,dx
    push ax
	mov [initialy],ax
    call shape2
    mov ah,0
    int 16h

    cmp ah,0x4B
    jnz right2
	mov word [temp],ax
	mov word [temp4],bx
	sub word [temp4],1
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,2
    push ax
	call checkcoordinate3
	mov word [temp4],bx
	sub word [temp4],3
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,2
    push ax
	call checkcoordinate3
	mov word ax, [temp]
	cmp word [n3],0
	jnz inte
	sub bx,1
	jmp endl2
    
    right2: 
    cmp ah,0x4D
    jnz down2
	mov word [temp],ax
	mov word [temp4],bx
	add word [temp4],2
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,2
    push ax
	call checkcoordinate3
	mov word [temp4],bx
	add word [temp4],4
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,2
    push ax
	call checkcoordinate3
	mov word [temp],ax
	mov word [temp4],bx
	sub word [temp4],1
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,2
    push ax
	call checkcoordinate3
	mov word ax, [temp]
	cmp word [n3],0
	jnz endl2
	add bx,1
	inte: jmp endl2
   
    down2:
    cmp ah, 0x50 
    jnz lll22
	mov word [temp],ax
	push bx
    mov ax, [starty]
	add ax,dx
	add ax,3
    push ax
	call checkcoordinate3
	mov word [temp4],bx
	add word [temp4],1
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,3
    push ax
	call checkcoordinate3
	mov word [temp],ax
	mov word [temp4],bx
	add word [temp4],2
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,2
    push ax
	call checkcoordinate3
	mov word ax, [temp]
	cmp word [n3],0
	jnz check
	add dx,1
	jmp endl2
    
	check: mov word [n],1


 endl2:
 cmp word [n],1
 jnz lll22
 call destructrow
 mov word [btmlefty], 22



 ;FOR SHAPE 4
 push word [nextx]
 push word [nexty]
 call desshape2
 push word [nextx]
 push word [nexty]
 call shape1
 mov dx,0 ;y_inc
 mov [rotate],dx
 mov [n],dx
 mov bx, [starty] 
 mov [initialy],bx
 
 mov bx, [startx] ;x_left right
 mov [initialx],bx
 lll3:

	mov word [n3],0
	mov ax, [rotate]
	cmp ax,0
	jnz rot
	jmp simple
	upkey: 
 	add word [rotate],1
	push word [initialx]
	push word [initialy]
	call desshape4
	rot:
	push word [initialx]
	push word [initialy]
	call desshape4r1
    mov ax, bx
    push ax 
	mov [initialx],ax
    mov ax, [starty]
    add ax,dx
    push ax
	mov [initialy],ax
    call shape4r1
    mov ah,0
    int 16h

    cmp ah,0x4B
    jnz right3
	mov word [temp],ax 
	mov word [temp4],bx
	sub word [temp4],1
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
    push ax ;ypos
	call checkcoordinate3
	mov word [temp4],bx
	sub word [temp4],1
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,1 ;ypos
    push ax
	call checkcoordinate3
	mov word [temp4],bx
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,2 ;ypos
    push ax
	call checkcoordinate3
	mov word [temp4],bx
	add word [temp4],1
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,2 ;ypos
    push ax
	call checkcoordinate3
	mov word ax, [temp]
	cmp word [n3] , 0
	jnz inter4
	sub bx,1
	jmp inter2
	inter4: jmp inter3
    right3: 
    cmp ah,0x4D
    jnz down3
	mov word [temp],ax 
	mov word [temp4],bx
	add word [temp4],2
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
    push ax ;ypos
	call checkcoordinate3
	mov word ax, [temp]
	mov word [temp],ax 
	mov word [temp4],bx
	add word [temp4],4
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,1 ;ypos
    push ax
	call checkcoordinate3
	mov word ax, [temp]
	mov word [temp],ax 
	mov word [temp4],bx
	add word [temp4],4
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,2 ;ypos
    push ax
	call checkcoordinate3
	mov word ax, [temp]
	cmp word [n3] , 0
	jnz inter3
	add bx,1
	jmp inter2
    
    down3:
    cmp ah, 0x50 
    jnz lll3
	mov word [temp],ax
	push bx
    mov ax, [starty]
	add ax,dx
	add ax,2
    push ax
	call checkcoordinate4
	mov word [temp4],bx
	add word [temp4],1
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	add ax,3
    push ax
	call checkcoordinate4
	mov word ax, [temp]
	cmp word [n] , 0
	jnz inter3
	add dx,1
    jmp inter2
	inter3: jmp inter2
	
	simple: 	
	push word [initialx]
	push word [initialy]
	call desshape4
    mov ax, bx
    push ax 
	mov [initialx],ax
    mov ax, [starty]
    add ax,dx
    push ax
	mov [initialy],ax
    call shape4
    mov ah,0
    int 16h
	cmp ah,0x48
	jz upkey
	;leftkey
    cmp ah,0x4B
    jnz right33
	mov word [temp],ax 
	mov word [temp4],bx
	sub word [temp4],1
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
    push ax ;ypos
	call checkcoordinate3
	mov word ax, [temp]
	mov word [temp],ax 
	mov word [temp],ax 
	mov word [temp4],bx
	add word [temp4],1
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	sub ax,1 ;ypos
    push ax
	call checkcoordinate3
	mov word ax, [temp]
	cmp word [n3] , 0
	jnz inter
	sub bx,1
	inter2: jmp inter

    right33: 
    cmp ah,0x4D
    jnz down33
	mov word [temp],ax 
	mov word [temp4],bx
	add word [temp4],3
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
    push ax ;ypos
	call checkcoordinate3
	mov word ax, [temp]
	mov word [temp],ax 
	mov word [temp],ax 
	mov word [temp4],bx
	add word [temp4],5
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
	sub ax,1 ;ypos
    push ax
	call checkcoordinate3
	mov word ax, [temp]
	cmp word [n3] , 0
	jnz endl
	add bx,1
	inter: jmp endl

    down33:
    cmp ah, 0x50
    jnz lll3
	check12:
	mov word [temp],ax
	push bx
    mov ax, [starty]
	add ax,dx
	add ax,1
    push ax
	call checkcoordinate4
	mov word ax, [temp]
	cmp word [n] , 0
	jnz endl
	add dx,1
 endl: 
	cmp word [n],1
 	jnz lll3
    call destructrow
    mov word [btmlefty], 22



 ;FOR SHAPE 1
 push word [nextx]
 push word [nexty]
 call desshape1
 push word [nextx]
 push word [nexty]
 call shape5
 
 mov dx,0 ;y_inc
 mov [rotate],dx
 mov [n],dx
 mov bx, [starty] 
 mov [initialy],bx
 
 mov bx, [startx] ;x_left right
 mov [initialx],bx

 lll4:
	mov word [n2],0
	push word [initialx]
	push word [initialy]
	call desshape1
    mov ax, bx
    push ax 
	mov [initialx],ax
    mov ax, [starty]
    add ax,dx
    push ax
	mov [initialy],ax
    call shape1
    mov ah,0
    int 16h

	;left
    cmp ah,0x4B
    jnz right4
    mov word [temp],ax
	mov word [temp4],bx
	sub word [temp4],1
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
    push ax ; ypos
	call checkcoordinate2
	mov word ax, [temp]
    cmp word [n2],0
	jnz endl3
    sub bx,1
	jmp endl3
    

    right4: 
    cmp ah,0x4D
    jnz down4
    mov word [temp],ax
	mov word [temp4],bx
	add word [temp4],5
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
    push ax ;ypos
	call checkcoordinate2
	mov word ax, [temp]
    cmp word [n2],0
	jnz endl3
    add bx,1
	jmp endl3
    
    down4:
    cmp ah, 0x50 
    jnz lll4
    add dx,1
	jmp check11

	check11:
	mov word [temp],ax
	push bx
    mov ax, [starty]
	add ax,dx
	add ax,2
    push ax
	call checkcoordinate
	mov word ax, [temp]



 endl3:


 cmp word [n],1
 jnz lll4
 call destructrow
 mov word [btmlefty], 22

 ;shape5
 push word [nextx]
 push word [nexty]
 call desshape1
 push word [nextx]
 push word [nexty]
 call shape3
 
 mov dx,0 ;y_inc
 mov [rotate],dx
 mov [n],dx
 mov bx, [starty] 
 mov [initialy],bx
 
 mov bx, [startx] ;x_left right
 mov [initialx],bx

 lll455:
	mov word [n2],0
	push word [initialx]
	push word [initialy]
	call desshape5
    mov ax, bx
    push ax 
	mov [initialx],ax
    mov ax, [starty]
    add ax,dx
    push ax
	mov [initialy],ax
    call shape5
    mov ah,0
    int 16h

	;left
    cmp ah,0x4B
    jnz right55
    mov word [temp],ax
	mov word [temp4],bx
	sub word [temp4],1
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
    push ax ; ypos
	call checkcoordinate3
	mov word ax, [temp]
    cmp word [n3],0
	jnz endl355
    sub bx,1
	jmp endl355
    

    right55: 
    cmp ah,0x4D
    jnz down45
    mov word [temp],ax
	mov word [temp4],bx
	add word [temp4],5
	push word [temp4] ;xpos
    mov ax, [starty]
	add ax,dx
    push ax ;ypos
	call checkcoordinate3
	mov word ax, [temp]
    cmp word [n3],0
	jnz endl355
    add bx,1
	jmp endl355
    
    down45:
    cmp ah, 0x50 
    jnz lll455
    add dx,1
	jmp check1155

	check1155:
	mov word [temp],ax
	push bx
    mov ax, [starty]
	add ax,dx
	;add ax,1
    push ax
	call checkcoordinate
	mov word ax, [temp]



 endl355:

 cmp word [n],1
 jnz lll455
 call destructrow
 mov word [btmlefty], 22


 sub word [count], 1
 cmp word[count],0
 jnz mainloop
 
 
 	


 endscr:

 call delayingloop1
 call endgame
 call delayingloop11
 call endgame
 call clrscr3
 call delayingloop11
 call endgame
 call delayingloop11
 call clrscr
 call delayingloop11
 call endgame
 call delayingloop11
 call clrscr
 call delayingloop11
 call endgame
 call delayingloop11
 call clrscr2
 call delayingloop11
 call endgame
 call sec_3
 call clrscr

 mov ax, 26
 push ax
 mov ax, 8
 push ax
 mov ax, 0x0A
 push ax
 mov ax, sc
 push ax
 push word [ls]
 call printstr

 mov ax, 46
 push ax ; x pos
 mov ax, 8
 push ax; y pos
 mov ax, [num]
 push ax
 call printnum


    mov ax,[oldisr]
    mov bx,[oldisr+2]
    cli
    mov [es:8*4],ax
    mov [es:8*4+2],bx
    sti



 

	mov ax, 4c00h
	int 21h
