.model small
.stack 100h

.data
; ===== Messages =====
game_title  db "SHAPE GAME ARENA", "$"
msg         db "COUNT THE SHAPES", "$"
m3          db "CIRCLE >", "$"
m4          db "SQUARE >", "$"
m5          db "TRIANGLE >", "$"
inp_prompt  db "", "$"
deadmsg     db "YOU DIED", "$"
statsmsg    db "ROUND CLEAR", "$"
time_label  db "TIME ", "$"
wall_fail_msg db "COPY WALL BMP NEXT TO EXE", "$"

; ===== Scoreboard =====
scb2 db "SCORE ", "$"
scb3 db "MISTAKES ", "$"

; ===== Values =====
correctC    db ?
correctS    db ?
correctT    db ?
totalShapes db ?

score       db 0
mistakes    db 0
circle_color db 11h
square_color db 12h
triangle_color db 13h
round_start_cs dw 0
round_elapsed_cs dw 0
time_left db 5

; Array to hold up to 6 shapes (0=empty, 1=Circle, 2=Square, 3=Triangle)
shape_list  db 6 dup(0)

; ===== BIT MAPS ======
wallpaper_name db "./image/wall.bmp", 0
login_page db "./image/Login_page.bmp", 0
difficulty_page db "./image/Difficulty.bmp", 0

; ===== Menu strings =====
menu_title  db "SHAPE GAME ARENA", "$"
menu_start  db "START", "$"
menu_quit   db "QUIT", "$"
menu_retry  db "PLAY AGAIN?", "$"
retry_yes   db "YES", "$"
crlf        db 0Dh, 0Ah, "$"
x_positions dw 34, 124, 214
y_positions dw 46, 92
wallpaper_handle dw 0
bmp_header db 54 dup(0)
bmp_palette db 1024 dup(0)
bmp_row_buffer db 320 dup(0)
ui_row db 0
ui_col db 0
glyph_space db 00h,00h,00h,00h,00h,00h,00h
glyph_gt    db 10h,08h,04h,02h,04h,08h,10h
glyph_0     db 0Eh,11h,13h,15h,19h,11h,0Eh
glyph_1     db 04h,0Ch,04h,04h,04h,04h,0Eh
glyph_2     db 0Eh,11h,01h,02h,04h,08h,1Fh
glyph_3     db 1Eh,01h,01h,0Eh,01h,01h,1Eh
glyph_4     db 02h,06h,0Ah,12h,1Fh,02h,02h
glyph_5     db 1Fh,10h,10h,1Eh,01h,01h,1Eh
glyph_6     db 0Eh,10h,10h,1Eh,11h,11h,0Eh
glyph_7     db 1Fh,01h,02h,04h,08h,08h,08h
glyph_8     db 0Eh,11h,11h,0Eh,11h,11h,0Eh
glyph_9     db 0Eh,11h,11h,0Fh,01h,01h,0Eh
glyph_A     db 0Eh,11h,11h,1Fh,11h,11h,11h
glyph_B     db 1Eh,11h,11h,1Eh,11h,11h,1Eh
glyph_C     db 0Eh,11h,10h,10h,10h,11h,0Eh
glyph_D     db 1Eh,11h,11h,11h,11h,11h,1Eh
glyph_E     db 1Fh,10h,10h,1Eh,10h,10h,1Fh
glyph_F     db 1Fh,10h,10h,1Eh,10h,10h,10h
glyph_G     db 0Eh,11h,10h,17h,11h,11h,0Fh
glyph_H     db 11h,11h,11h,1Fh,11h,11h,11h
glyph_I     db 0Eh,04h,04h,04h,04h,04h,0Eh
glyph_J     db 01h,01h,01h,01h,11h,11h,0Eh
glyph_K     db 11h,12h,14h,18h,14h,12h,11h
glyph_L     db 10h,10h,10h,10h,10h,10h,1Fh
glyph_M     db 11h,1Bh,15h,15h,11h,11h,11h
glyph_N     db 11h,19h,15h,13h,11h,11h,11h
glyph_O     db 0Eh,11h,11h,11h,11h,11h,0Eh
glyph_P     db 1Eh,11h,11h,1Eh,10h,10h,10h
glyph_Q     db 0Eh,11h,11h,11h,15h,12h,0Dh
glyph_R     db 1Eh,11h,11h,1Eh,14h,12h,11h
glyph_S     db 0Fh,10h,10h,0Eh,01h,01h,1Eh
glyph_T     db 1Fh,04h,04h,04h,04h,04h,04h
glyph_U     db 11h,11h,11h,11h,11h,11h,0Eh
glyph_V     db 11h,11h,11h,11h,11h,0Ah,04h
glyph_W     db 11h,11h,11h,15h,15h,15h,0Ah
glyph_X     db 11h,11h,0Ah,04h,0Ah,11h,11h
glyph_Y     db 11h,11h,0Ah,04h,04h,04h,04h
glyph_Z     db 1Fh,01h,02h,04h,08h,10h,1Fh
digit_ptrs dw glyph_0,glyph_1,glyph_2,glyph_3,glyph_4,glyph_5,glyph_6,glyph_7,glyph_8,glyph_9
letter_ptrs dw glyph_A,glyph_B,glyph_C,glyph_D,glyph_E,glyph_F,glyph_G,glyph_H,glyph_I,glyph_J,glyph_K,glyph_L,glyph_M,glyph_N,glyph_O,glyph_P,glyph_Q,glyph_R,glyph_S,glyph_T,glyph_U,glyph_V,glyph_W,glyph_X,glyph_Y,glyph_Z

; ===== AUTHENTICATION =====
credentials_file db "credentials.txt",0
scoreboard_file  db "scoreboard.txt",0

cred_handle dw ?
score_handle dw ?

username db 21 dup(0)
password db 21 dup(0)
confirm_password db 20 dup(0)

file_buffer db 512 dup(0)
bytes_read dw 0


input_buffer db 21,0,21 dup(0)

login_msg db "=== LOGIN ===$"
signup_msg db "=== SIGNUP ===$"

user_prompt db "USERNAME: $"
pass_prompt db "PASSWORD: $"
confirm_prompt db "CONFIRM PASSWORD: $"

user_not_found db "USER NOT FOUND$"
pass_mismatch db "PASSWORDS DO NOT MATCH$"

login_success db "LOGIN SUCCESS$"
signup_success db "SIGNUP SUCCESS$"

default_admin db "admin,admin",13,10

admin_user db "admin",0
admin_pass db "admin",0

.code
; ===== TEMPORARY =====
dos_print proc

    mov ah, 09h
    int 21h
    ret

dos_print endp
; =====================

; ======================
; print string (DX = offset of string)
; ======================
print proc
    push ax
    push bx
    push si

    mov si, dx
print_loop:
    mov al, [si]
    cmp al, '$'
    je  print_done
    call draw_ui_char
    inc si
    jmp print_loop
print_done:
    pop si
    pop bx
    pop ax
    ret
print endp

; ======================
; print number in AL
; ======================
print_num proc
    push ax
    push dx
    aam
    add ax, 3030h
    push ax
    cmp ah, '0'
    je skip_tens
    mov al, ah
    call draw_ui_char
skip_tens:
    pop ax
    call draw_ui_char
    pop dx
    pop ax
    ret
print_num endp

;=========================
; FILE CREATION
;=========================
init_files proc

    ; CHECK credentials.txt
    mov ah, 3Dh
    mov al, 00h
    mov dx, offset credentials_file
    int 21h
    jc create_credentials

    mov bx, ax
    mov ah, 3Eh
    int 21h
    jmp check_scoreboard

create_credentials:
    mov ah, 3Ch
    mov cx, 0
    mov dx, offset credentials_file
    int 21h

    mov bx, ax
    mov ah, 40h
    mov dx, offset default_admin
    mov cx, 13
    int 21h

    mov ah, 3Eh
    int 21h

check_scoreboard:

    mov ah, 3Dh
    mov al, 00h
    mov dx, offset scoreboard_file
    int 21h
    jc create_scoreboard

    mov bx, ax
    mov ah, 3Eh
    int 21h
    ret

create_scoreboard:

    mov ah, 3Ch
    mov cx, 0
    mov dx, offset scoreboard_file
    int 21h

    mov bx, ax
    mov ah, 3Eh
    int 21h

    ret

init_files endp

; =========================
;  LOGIN AND SIGNUP SCREEN
; =========================
login_screen proc

login_retry:

    call set_text_mode

    ; clear screen
    mov ax, 0003h
    int 10h

    ; LOGIN TITLE
    mov dx, offset login_msg
    call dos_print

    ; newline
    mov dl, 10
    mov ah, 02h
    int 21h

    ; USERNAME
    mov dx, offset user_prompt
    call dos_print

    call read_string

    mov si, offset username
    call copy_input

    ; newline
    mov dl, 10
    mov ah, 02h
    int 21h

    ; PASSWORD
    mov dx, offset pass_prompt
    call dos_print

    call read_string

    mov si, offset password
    call copy_input

    ; CHECK CREDENTIALS
    call check_credentials

    cmp al, 1
    je login_ok

    ; FAILED
    mov dl, 10
    mov ah, 02h
    int 21h

    mov dx, offset user_not_found
    call dos_print

    mov dl, 10
    mov ah, 02h
    int 21h

    jmp login_retry

login_ok:

    mov dl, 10
    mov ah, 02h
    int 21h

    mov dx, offset login_success
    call dos_print

    ret

login_screen endp

check_credentials proc

    ; open credentials.txt

    mov ah, 3Dh
    mov al, 00h
    mov dx, offset credentials_file
    int 21h
    jc cred_fail

    mov bx, ax

    ; read file

    mov ah, 3Fh
    mov cx, 512
    mov dx, offset file_buffer
    int 21h

    mov bytes_read, ax

    ; close file

    mov ah, 3Eh
    int 21h

    ; TEMPORARY:
    ; only checks admin/admin

    mov si, offset username
    mov di, offset admin_user
    call strcmp

    cmp al, 1
    jne cred_fail

    mov si, offset password
    mov di, offset admin_pass
    call strcmp

    cmp al, 1
    jne cred_fail

    mov al, 1
    ret

cred_fail:
    mov al, 0
    ret

check_credentials endp

read_string proc

    mov ah, 0Ah
    mov dx, offset input_buffer
    int 21h

    ret

read_string endp

copy_input proc
    ; SI = destination

    push ax
    push bx
    push di

    mov di, si

    mov bl, input_buffer+1
    xor bh, bh

    mov si, offset input_buffer+2

copy_loop:
    cmp bx, 0
    je copy_done

    mov al, [si]
    mov [di], al

    inc si
    inc di

    dec bx
    jmp copy_loop

copy_done:
    mov byte ptr [di], 0

    pop di
    pop bx
    pop ax
    ret

copy_input endp

strcmp proc
    ; SI = string1
    ; DI = string2
    ; AL = 1 equal
    ; AL = 0 not equal

strcmp_loop:

    mov ah, [si]
    mov bl, [di]

    cmp ah, bl
    jne not_equal

    cmp ah, 0
    je equal

    inc si
    inc di
    jmp strcmp_loop

equal:
    mov al, 1
    ret

not_equal:
    mov al, 0
    ret

strcmp endp

; ======================
; random number 0-5 (result in AL)
; ======================
rand_0_5 proc
    mov ah, 2Ch
    int 21h
    mov al, dl
    xor ah, ah
    mov bl, 6
    div bl
    mov al, ah
    ret
rand_0_5 endp

; ======================
; randomize shape colors
; ======================
shuffle_shape_colors proc
    call rand_0_5

    cmp al, 0
    je  colors_0
    cmp al, 1
    je  colors_1
    cmp al, 2
    je  colors_2
    cmp al, 3
    je  colors_3
    cmp al, 4
    je  colors_4

colors_5:
    mov circle_color, 13h
    mov square_color, 12h
    mov triangle_color, 11h
    ret

colors_0:
    mov circle_color, 11h
    mov square_color, 12h
    mov triangle_color, 13h
    ret

colors_1:
    mov circle_color, 11h
    mov square_color, 13h
    mov triangle_color, 12h
    ret

colors_2:
    mov circle_color, 12h
    mov square_color, 11h
    mov triangle_color, 13h
    ret

colors_3:
    mov circle_color, 12h
    mov square_color, 13h
    mov triangle_color, 11h
    ret

colors_4:
    mov circle_color, 13h
    mov square_color, 11h
    mov triangle_color, 12h
    ret
shuffle_shape_colors endp

; ======================
; get current centiseconds within minute
; result AX = sec*100 + hundredths
; ======================
get_time_cs proc
    push bx
    push dx

    mov ah, 2Ch
    int 21h

    mov al, dh
    xor ah, ah
    mov bl, 100
    mul bl
    xor bx, bx
    mov bl, dl
    add ax, bx

    pop dx
    pop bx
    ret
get_time_cs endp

; ======================
; update elapsed time from round start
; result AX = elapsed centiseconds
; ======================
update_round_elapsed proc
    call get_time_cs
    mov bx, round_start_cs
    cmp ax, bx
    jae elapsed_ok
    add ax, 6000
elapsed_ok:
    sub ax, bx
    mov round_elapsed_cs, ax
    ret
update_round_elapsed endp

; ======================
; draw round timer
; ======================
draw_timer proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov  al, ui_row
    push ax
    mov  al, ui_col
    push ax

    ; Erase old timer digit
    mov  cx, 255  ; column
    mov  dx, 16   ; rows
    mov  si, 48   ; right
    mov  di, 8    ; bottom
    mov  al, 14h
    call fill_rect

    ; Draw timer
    mov  dh, 02h
    mov  dl, 1Ch
    call setcur
    mov  dx, offset time_label
    call print
    mov  al, time_left
    call print_num
    
    ;REFRESH SCORE NUMBER ONLY
    mov  cx, 255
    mov  dx, 152
    mov  si, 8          
    mov  di, 8
    mov  al, 14h
    call fill_rect

    ;REFRESH MISTAKES NUMBER ONLY  
    mov  cx, 255
    mov  dx, 168
    mov  si, 8          
    mov  di, 8
    mov  al, 14h
    call fill_rect

    mov  dh, 13h        
    mov  dl, 1Ch        
    call setcur
    mov  dx, offset scb2
    call print
    mov  al, score
    call print_num

    mov  dh, 15h        
    mov  dl, 19h        
    call setcur
    mov  dx, offset scb3
    call print
    mov  al, mistakes
    call print_num

    pop  ax
    mov  ui_col, al
    pop  ax
    mov  ui_row, al

    pop  di
    pop  si
    pop  dx
    pop  cx
    pop  bx
    pop  ax
    ret
draw_timer endp

; ======================
; start 5-second round timer
; ======================
start_round_timer proc
    call get_time_cs
    mov round_start_cs, ax
    mov round_elapsed_cs, 0
    mov time_left, 5
    call draw_timer
    ret
start_round_timer endp

; ======================
; refresh timer and detect timeout
; CF=1 if timer expired
; ======================
check_round_timer proc
    push bx
    push dx

    call update_round_elapsed
    cmp ax, 500
    jae timer_expired

    xor dx, dx
    mov bx, 100
    div bx
    mov bl, 5
    sub bl, al
    mov time_left, bl
    call draw_timer
    clc
    jmp timer_done

timer_expired:
    mov time_left, 0
    call draw_timer
    stc

timer_done:
    pop dx
    pop bx
    ret
check_round_timer endp

; ======================
; timed single-digit input
; result AL=digit, CF=0 on success
; CF=1 on timeout
; ======================
input_digit_timed proc
timed_wait:
    call check_round_timer
    jc  timed_out

    mov ah, 01h
    int 16h
    jz  timed_wait

    mov ah, 00h
    int 16h
    cmp al, '0'
    jb  timed_wait
    cmp al, '9'
    ja  timed_wait

    push ax
    call draw_ui_char
    pop ax

    sub al, '0'
    clc
    ret

timed_out:
    stc
    ret
input_digit_timed endp

; ======================
; show inter-round stats for one second
; ======================
show_round_stats proc
    push ax
    push dx
    push bx

    call cls
    call draw_menu_background

    ; ROUND CLEAR ? centered in black box
    mov  dh, 05h
    mov  dl, 0Eh
    call setcur
    mov  dx, offset statsmsg      ; "ROUND CLEAR"
    call print

    ; SCORE N ? centered in red box
    mov  dh, 0Dh
    mov  dl, 10h
    call setcur
    mov  dx, offset scb2          ; "SCORE "
    call print
    mov  al, score
    call print_num

    ; MISTAKES N ? centered in blue box
    mov  dh, 11h
    mov  dl, 0Eh
    call setcur
    mov  dx, offset scb3          ; "MISTAKES "
    call print
    mov  al, mistakes
    call print_num

    call get_time_cs
    mov  bx, ax
stats_wait:
    call get_time_cs
    cmp  ax, bx
    jae  stats_nowrap
    add  ax, 6000
stats_nowrap:
    sub  ax, bx
    cmp  ax, 100
    jb   stats_wait

    pop  bx
    pop  dx
    pop  ax
    ret
show_round_stats endp

; ======================
; long death beep
; ======================
long_beep proc
    push ax
    push bx
    push dx

    mov al, 0B6h
    out 43h, al

    mov ax, 1193
    out 42h, al
    mov al, ah
    out 42h, al

    in  al, 61h
    mov dl, al
    or  al, 03h
    out 61h, al

    call get_time_cs
    mov bx, ax
beep_wait:
    call get_time_cs
    cmp ax, bx
    jae beep_nowrap
    add ax, 6000
beep_nowrap:
    sub ax, bx
    cmp ax, 70
    jb  beep_wait

    mov al, dl
    and al, 0FCh
    out 61h, al

    pop dx
    pop bx
    pop ax
    ret
long_beep endp

; ======================
; draw wallpaper.bmp in mode 13h
; CF=1 on failure
; ======================
draw_wallpaper proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp
    push es

    mov wallpaper_handle, 0

    mov ah, 3Dh
    mov al, 00h
    mov dx, offset wallpaper_name
    int 21h
    jnc wallpaper_open_ok
    jmp wallpaper_fail
wallpaper_open_ok:

    mov wallpaper_handle, ax
    mov bx, ax

    mov ah, 3Fh
    mov cx, 54
    mov dx, offset bmp_header
    int 21h
    jnc wallpaper_read_ok
    jmp wallpaper_fail_close
wallpaper_read_ok:
    cmp ax, 54
    je  wallpaper_size_ok
    jmp wallpaper_fail_close
wallpaper_size_ok:

    cmp word ptr bmp_header, 4D42h
    je  wallpaper_sig_ok
    jmp wallpaper_fail_close
wallpaper_sig_ok:
    cmp word ptr bmp_header+18, 320
    je  wallpaper_w_ok
    jmp wallpaper_fail_close
wallpaper_w_ok:
    cmp word ptr bmp_header+20, 0
    je  wallpaper_w_hi_ok
    jmp wallpaper_fail_close
wallpaper_w_hi_ok:
    cmp word ptr bmp_header+22, 200
    je  wallpaper_h_ok
    jmp wallpaper_fail_close
wallpaper_h_ok:
    cmp word ptr bmp_header+24, 0
    je  wallpaper_h_hi_ok
    jmp wallpaper_fail_close
wallpaper_h_hi_ok:
    cmp word ptr bmp_header+28, 8
    je  wallpaper_bpp_ok
    jmp wallpaper_fail_close
wallpaper_bpp_ok:

    mov si, word ptr bmp_header+10
    cmp si, 54
    jae wallpaper_offset_ok
    jmp wallpaper_fail_close
wallpaper_offset_ok:
    sub si, 54
    cmp si, 0
    jne wallpaper_palette_nonzero
    jmp wallpaper_fail_close
wallpaper_palette_nonzero:
    cmp si, 1024
    jbe wallpaper_palette_ok
    jmp wallpaper_fail_close
wallpaper_palette_ok:

    mov ah, 3Fh
    mov cx, si
    mov dx, offset bmp_palette
    int 21h
    jnc wallpaper_palette_read_ok
    jmp wallpaper_fail_close
wallpaper_palette_read_ok:
    cmp ax, si
    je  palette_ready
    jmp wallpaper_fail_close

palette_ready:
    mov dx, 03C8h
    xor al, al
    out dx, al
    inc dx

    mov bp, si
    shr bp, 1
    shr bp, 1
    mov cx, word ptr bmp_header+46
    cmp cx, 0
    jne palette_count_ok
    mov cx, bp
palette_count_ok:
    cmp cx, bp
    jbe palette_count_clamped
    mov cx, bp
palette_count_clamped:
    mov si, offset bmp_palette

palette_loop:
    cmp cx, 0
    je  palette_done
    mov al, [si+2]
    shr al, 1
    shr al, 1
    out dx, al
    mov al, [si+1]
    shr al, 1
    shr al, 1
    out dx, al
    mov al, [si]
    shr al, 1
    shr al, 1
    out dx, al
    add si, 4
    dec cx
    jmp palette_loop

palette_done:
    ; ---- Restore standard CGA palette for indices 0-15 ----
    mov  dx, 03C8h
    xor  al, al
    out  dx, al
    inc  dx

    ; 0: Black
    mov al, 00h
    out dx, al
    mov al, 00h
    out dx, al
    mov al, 00h
    out dx, al
    ; 1: Dark Blue
    mov al, 00h
    out dx, al
    mov al, 00h
    out dx, al
    mov al, 2Ah
    out dx, al
    ; 2: Dark Green
    mov al, 00h
    out dx, al
    mov al, 2Ah
    out dx, al
    mov al, 00h
    out dx, al
    ; 3: Dark Cyan
    mov al, 00h
    out dx, al
    mov al, 2Ah
    out dx, al
    mov al, 2Ah
    out dx, al
    ; 4: Dark Red
    mov al, 2Ah
    out dx, al
    mov al, 00h
    out dx, al
    mov al, 00h
    out dx, al
    ; 5: Dark Magenta
    mov al, 2Ah
    out dx, al
    mov al, 00h
    out dx, al
    mov al, 2Ah
    out dx, al
    ; 6: Brown
    mov al, 2Ah
    out dx, al
    mov al, 15h
    out dx, al
    mov al, 00h
    out dx, al
    ; 7: Light Grey
    mov al, 2Ah
    out dx, al
    mov al, 2Ah
    out dx, al
    mov al, 2Ah
    out dx, al
    ; 8: Dark Grey
    mov al, 15h
    out dx, al
    mov al, 15h
    out dx, al
    mov al, 15h
    out dx, al
    ; 9: Bright Blue
    mov al, 15h
    out dx, al
    mov al, 15h
    out dx, al
    mov al, 3Fh
    out dx, al
    ; 10: Bright Green
    mov al, 15h
    out dx, al
    mov al, 3Fh
    out dx, al
    mov al, 15h
    out dx, al
    ; 11: Bright Cyan
    mov al, 15h
    out dx, al
    mov al, 3Fh
    out dx, al
    mov al, 3Fh
    out dx, al
    ; 12: Bright Red
    mov al, 3Fh
    out dx, al
    mov al, 15h
    out dx, al
    mov al, 15h
    out dx, al
    ; 13: Bright Magenta
    mov al, 3Fh
    out dx, al
    mov al, 15h
    out dx, al
    mov al, 3Fh
    out dx, al
    ; 14: Yellow
    mov al, 3Fh
    out dx, al
    mov al, 3Fh
    out dx, al
    mov al, 15h
    out dx, al
    ; 15: White
    mov al, 3Fh
    out dx, al
    mov al, 3Fh
    out dx, al
    mov al, 3Fh
    out dx, al
    ; ---- End palette restore ----

    ; ---- Custom game colors (indices 16-20) ----
    ; Index 16 (10h): Pink border  #F472A0 -> R=3Dh G=1Ch B=28h
    mov dx, 03C8h
    mov al, 10h
    out dx, al
    inc dx
    mov al, 3Dh
    out dx, al
    mov al, 1Ch
    out dx, al
    mov al, 28h
    out dx, al
    ; Index 17 (11h): Blue circle  #6BB8E8 -> R=1Ah G=2Eh B=3Ah
    mov al, 1Ah
    out dx, al
    mov al, 2Eh
    out dx, al
    mov al, 3Ah
    out dx, al
    ; Index 18 (12h): Pink square  #F07AAA -> R=3Ch G=1Eh B=2Ah
    mov al, 3Ch
    out dx, al
    mov al, 1Eh
    out dx, al
    mov al, 2Ah
    out dx, al
    ; Index 19 (13h): Yellow triangle  #E8C96A -> R=3Ah G=32h B=1Ah
    mov al, 3Ah
    out dx, al
    mov al, 32h
    out dx, al
    mov al, 1Ah
    out dx, al
    ; Index 20 (14h): Cream background  #FAF0DC -> R=3Eh G=3Ch B=37h
    mov al, 3Eh
    out dx, al
    mov al, 3Ch
    out dx, al
    mov al, 37h
    out dx, al
    ; ---- End custom colors ----

    mov ax, 0A000h
    mov es, ax
    mov di, 63680
    mov bp, 200
    mov bx, wallpaper_handle

row_loop:
    mov ah, 3Fh
    mov cx, 320
    mov dx, offset bmp_row_buffer
    int 21h
    jc  wallpaper_fail_close
    cmp ax, 320
    jne wallpaper_fail_close

    mov si, offset bmp_row_buffer
    mov cx, 320
    cld
    rep movsb
    sub di, 640
    dec bp
    jnz row_loop

    mov bx, wallpaper_handle
    mov ah, 3Eh
    int 21h
    mov wallpaper_handle, 0
    clc
    jmp wallpaper_done

wallpaper_fail_close:
    mov bx, wallpaper_handle
    cmp bx, 0
    je  wallpaper_fail
    mov ah, 3Eh
    int 21h
    mov wallpaper_handle, 0

wallpaper_fail:
    stc

wallpaper_done:
    pop es
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
draw_wallpaper endp

; ======================
; cls - clears the screen
; ======================
cls proc
    push ax
    push cx
    push dx
    push si
    push di

    mov cx, 0
    mov dx, 0
    mov si, 320
    mov di, 200
    mov al, 14h  ; cream background
    call fill_rect

    mov ah, 02h
    mov bh, 00h
    mov dx, 0000h
    int 10h

    pop di
    pop si
    pop dx
    pop cx
    pop ax
    ret
cls endp

; ======================
; setcur - set cursor position
; DH = row, DL = col
; ======================
setcur proc
    mov ui_row, dh
    mov ui_col, dl
    ret
setcur endp

get_ui_glyph proc
    push ax
    push bx

    cmp al, ' '
    je  glyph_space_sel
    cmp al, '>'
    je  glyph_gt_sel
    cmp al, '0'
    jb  glyph_letter_check
    cmp al, '9'
    ja  glyph_letter_check
    sub al, '0'
    xor ah, ah
    shl ax, 1
    mov bx, ax
    mov si, digit_ptrs[bx]
    jmp glyph_done

glyph_letter_check:
    cmp al, 'A'
    jb  glyph_space_sel
    cmp al, 'Z'
    ja  glyph_space_sel
    sub al, 'A'
    xor ah, ah
    shl ax, 1
    mov bx, ax
    mov si, letter_ptrs[bx]
    jmp glyph_done

glyph_gt_sel:
    mov si, offset glyph_gt
    jmp glyph_done

glyph_space_sel:
    mov si, offset glyph_space

glyph_done:
    pop bx
    pop ax
    ret
get_ui_glyph endp

draw_ui_char proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp

    call get_ui_glyph

    xor ax, ax
    mov al, ui_col
    shl ax, 1
    shl ax, 1
    shl ax, 1
    mov bp, ax

    xor ax, ax
    mov al, ui_row
    shl ax, 1
    shl ax, 1
    shl ax, 1
    mov di, ax

    mov bx, si
ui_row_loop:
    mov cx, bp
    mov dx, di
    mov ah, [bx]
    test ah, 10h
    jz   ui_skip_0
    mov  al, 10h  ; pink text
    call put_pixel
ui_skip_0:
    inc cx
    test ah, 08h
    jz   ui_skip_1
    mov  al, 10h  ; pink text
    call put_pixel
ui_skip_1:
    inc cx
    test ah, 04h
    jz   ui_skip_2
    mov  al, 10h  ; pink text
    call put_pixel
ui_skip_2:
    inc cx
    test ah, 02h
    jz   ui_skip_3
    mov  al, 10h  ; pink text
    call put_pixel
ui_skip_3:
    inc cx
    test ah, 01h
    jz   ui_skip_4
    mov  al, 10h  ; pink text
    call put_pixel
ui_skip_4:
    inc bx
    inc di
    mov ax, bx
    sub ax, si
    cmp ax, 7
    jb  ui_row_loop

    inc ui_col

    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
draw_ui_char endp

set_video_mode proc
    mov ax, 0013h
    int 10h
    ret
set_video_mode endp

set_text_mode proc
    mov ax, 0003h
    int 10h
    ret
set_text_mode endp

put_pixel proc
    push ax
    push bx
    mov ah, 0Ch
    mov bh, 00h
    int 10h
    pop bx
    pop ax
    ret
put_pixel endp

draw_hline proc
    push ax
    push bx
    push cx
    push dx
    push si

    mov bx, cx
    mov ah, 0Ch
    mov bh, 00h
hline_loop:
    cmp si, 0
    je  hline_done
    mov cx, bx
    int 10h
    inc bx
    dec si
    jmp hline_loop
hline_done:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
draw_hline endp

draw_vline proc
    push ax
    push bx
    push cx
    push dx
    push si

    mov bx, dx
    mov ah, 0Ch
    mov bh, 00h
vline_loop:
    cmp si, 0
    je  vline_done
    mov dx, bx
    int 10h
    inc bx
    dec si
    jmp vline_loop
vline_done:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
draw_vline endp

fill_rect proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov bx, dx
fill_row_loop:
    cmp di, 0
    je  fill_done
    push di
    mov dx, bx
    call draw_hline
    pop di
    inc bx
    dec di
    jmp fill_row_loop
fill_done:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
fill_rect endp

draw_rect proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    call draw_hline
    mov bx, dx
    add bx, di
    dec bx
    push dx
    mov dx, bx
    call draw_hline
    pop dx
    push si
    mov si, di
    call draw_vline
    mov bx, cx
    pop si
    add bx, si
    dec bx
    push cx
    push si
    mov si, di
    mov cx, bx
    call draw_vline
    pop cx
    pop si

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
draw_rect endp

draw_diag_down_right proc
    push ax
    push bx
    push bp
    push cx
    push dx
    push si

    mov bx, cx
    mov bp, dx
diag_r_loop:
    cmp si, 0
    je  diag_r_done
    mov cx, bx
    mov dx, bp
    call put_pixel
    inc bx
    inc bp
    dec si
    jmp diag_r_loop
diag_r_done:
    pop si
    pop dx
    pop cx
    pop bp
    pop bx
    pop ax
    ret
draw_diag_down_right endp

draw_diag_down_left proc
    push ax
    push bx
    push bp
    push cx
    push dx
    push si

    mov bx, cx
    mov bp, dx
diag_l_loop:
    cmp si, 0
    je  diag_l_done
    mov cx, bx
    mov dx, bp
    call put_pixel
    dec bx
    inc bp
    dec si
    jmp diag_l_loop
diag_l_done:
    pop si
    pop dx
    pop cx
    pop bp
    pop bx
    pop ax
    ret
draw_diag_down_left endp

draw_circle_shape proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp

    mov bp, cx
    add bp, 20
    mov di, dx
    add di, 20
    mov bx, -18

circle_y_loop:
    cmp bx, 19
    jge circle_done
    mov si, -18
circle_x_loop:
    cmp si, 19
    jge circle_next_row
    mov ax, si
    imul ax
    mov cx, ax
    mov ax, bx
    imul ax
    add ax, cx
    cmp ax, 324
    ja  circle_skip_fill
    mov cx, bp
    add cx, si
    mov dx, di
    add dx, bx
    mov al, circle_color
    call put_pixel
circle_skip_fill:
    mov ax, si
    imul ax
    mov cx, ax
    mov ax, bx
    imul ax
    add ax, cx
    cmp ax, 289
    jb  circle_next_x
    cmp ax, 361
    ja  circle_next_x
    mov cx, bp
    add cx, si
    mov dx, di
    add dx, bx
    mov al, circle_color
    call put_pixel
circle_next_x:
    inc si
    jmp circle_x_loop
circle_next_row:
    inc bx
    jmp circle_y_loop
circle_done:
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
draw_circle_shape endp

draw_square_shape proc
    push ax
    push cx
    push dx
    push si
    push di

    mov si, 42
    mov di, 42
    mov al, square_color
    call fill_rect
    mov si, 42
    mov di, 42
    mov al, square_color
    call draw_rect

    pop di
    pop si
    pop dx
    pop cx
    pop ax
    ret
draw_square_shape endp

draw_triangle_shape proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp

    mov bp, cx
    add bp, 18
    mov di, dx
    xor bx, bx

tri_fill_loop:
    cmp bx, 19
    jge tri_outline
    mov cx, bp
    sub cx, bx
    mov dx, di
    add dx, bx
    mov si, bx
    shl si, 1
    inc si
    mov al, triangle_color
    call draw_hline
    inc bx
    jmp tri_fill_loop

tri_outline:
    mov cx, bp
    mov dx, di
    mov si, 19
    mov al, triangle_color
    call draw_diag_down_left
    mov cx, bp
    mov dx, di
    mov si, 19
    mov al, triangle_color
    call draw_diag_down_right
    mov cx, bp
    sub cx, 18
    mov dx, di
    add dx, 18
    mov si, 37
    mov al, triangle_color
    call draw_hline

    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
draw_triangle_shape endp

draw_panel proc
    push ax
    push cx
    push dx
    push si
    push di

    push ax
    push cx
    push dx
    push si
    push di
    call fill_rect
    pop di
    pop si
    pop dx
    pop cx
    pop ax

    mov al, 10h  ; pink border
    call draw_rect

    pop di
    pop si
    pop dx
    pop cx
    pop ax
    ret
draw_panel endp

draw_menu_background proc
    push ax
    push cx
    push dx
    push si
    push di

    call draw_wallpaper
    jc  menu_bg_fallback

    mov cx, 18
    mov dx, 18
    mov si, 284
    mov di, 50
    mov al, 14h  ; cream
    call draw_panel

    mov cx, 58
    mov dx, 96
    mov si, 204
    mov di, 26
    mov al, 14h  ; cream
    call draw_panel

    mov cx, 58
    mov dx, 128
    mov si, 204
    mov di, 26
    mov al, 14h  ; cream
    call draw_panel
    jmp menu_bg_done

menu_bg_fallback:
    mov cx, 18
    mov dx, 18
    mov si, 284
    mov di, 50
    mov al, 14h  ; cream
    call draw_panel

    mov cx, 48
    mov dx, 86
    mov si, 224
    mov di, 72
    mov al, 14h  ; cream
    call draw_panel

    mov dh, 01h
    mov dl, 03h
    call setcur
    mov dx, offset wall_fail_msg
    call print

menu_bg_done:
    pop di
    pop si
    pop dx
    pop cx
    pop ax
    ret
draw_menu_background endp

draw_game_background proc
    push ax
    push cx
    push dx
    push si
    push di

    call draw_wallpaper
    jc  game_bg_fallback

    mov cx, 8
    mov dx, 8
    mov si, 304
    mov di, 22
    mov al, 14h  ; cream
    call draw_panel

    mov cx, 18
    mov dx, 38
    mov si, 284
    mov di, 100
    mov al, 14h  ; cream
    call draw_panel

    mov cx, 18
    mov dx, 146
    mov si, 170
    mov di, 46
    mov al, 14h  ; cream
    call draw_panel

    mov cx, 196
    mov dx, 146
    mov si, 106
    mov di, 46
    mov al, 14h  ; cream
    call draw_panel
    jmp game_bg_done

game_bg_fallback:
    mov cx, 8
    mov dx, 8
    mov si, 304
    mov di, 22
    mov al, 14h  ; cream
    call draw_panel

    mov cx, 18
    mov dx, 38
    mov si, 284
    mov di, 100
    mov al, 14h  ; cream
    call draw_panel

    mov cx, 18
    mov dx, 146
    mov si, 170
    mov di, 46
    mov al, 14h  ; cream
    call draw_panel

    mov cx, 196
    mov dx, 146
    mov si, 106
    mov di, 46
    mov al, 14h  ; cream
    call draw_panel

    mov dh, 01h
    mov dl, 03h
    call setcur
    mov dx, offset wall_fail_msg
    call print

game_bg_done:
    pop di
    pop si
    pop dx
    pop cx
    pop ax
    ret
draw_game_background endp

; ======================
; show main menu
; returns AL=1 start, AL=0 quit 
; ======================
show_menu proc
    call set_video_mode
    call cls
    call draw_menu_background

    mov dh, 05h
    mov dl, 0Ch
    call setcur
    mov dx, offset menu_title
    call print

    mov dh, 0Dh
    mov dl, 11h
    call setcur
    mov dx, offset menu_start
    call print

    mov dh, 11h
    mov dl, 11h
    call setcur
    mov dx, offset menu_quit
    call print

menu_wait:
    mov ah, 00h
    int 16h
    cmp al, '1'
    je menu_s
    cmp al, '2'
    je menu_q
    jmp menu_wait
menu_s:
    mov al, 1
    ret
menu_q:
    mov al, 0
    ret
show_menu endp

; ======================
; show retry menu
; returns AL=1 retry, AL=0 quit
; ======================
show_retry proc
    call set_video_mode
    call cls
    call draw_menu_background
    call long_beep

    ; YOU DIED 
    mov  dh, 03h
    mov  dl, 10h
    call setcur
    mov  dx, offset deadmsg
    call print

    ; SCORE: N   MISTAKES: N  
    mov  dh, 07h
    mov  dl, 05h
    call setcur
    mov  dx, offset scb2        ; "SCORE "
    call print
    mov  al, score
    call print_num

    mov  dh, 07h
    mov  dl, 18h
    call setcur
    mov  dx, offset scb3        ; "MISTAKES "
    call print
    mov  al, mistakes
    call print_num

    ; PLAY AGAIN? 
    mov  dh, 05h
    mov  dl, 0fh
    call setcur
    mov  dx, offset menu_retry  ; "PLAY AGAIN"
    call print

    ; 1 YES on red panel  
    mov  dh, 0Dh
    mov  dl, 12h
    call setcur
    mov  dx, offset retry_yes   ; "1 YES"
    call print

    ; 2 QUIT on blue panel 
    mov  dh, 11h
    mov  dl, 12h
    call setcur
    mov  dx, offset menu_quit   ; "2 QUIT"
    call print

retry_wait:
    mov  ah, 00h
    int  16h
    cmp  al, '1'
    je   do_retry
    cmp  al, '2'
    je   do_quit_r
    jmp  retry_wait
do_retry:
    mov  al, 1
    ret
do_quit_r:
    mov  al, 0
    ret
show_retry endp

; ======================
; generate shapes and populate shape_list
; ======================
gen_shapes proc
    mov totalShapes, 6

    call rand_0_5
    mov bl, totalShapes
    cmp al, bl
    jbe ok1
    mov al, bl
ok1:
    mov correctC, al

    call rand_0_5
    mov bl, totalShapes
    sub bl, correctC
    cmp al, bl
    jbe ok2
    mov al, bl
ok2:
    mov correctS, al

    mov al, totalShapes
    sub al, correctC
    sub al, correctS
    mov correctT, al

    mov cx, 6
    mov si, offset shape_list
clear_loop:
    mov byte ptr [si], 0
    inc si
    loop clear_loop

    mov si, offset shape_list

    mov cl, correctC
    cmp cl, 0
    je check_s
fill_c:
    mov byte ptr [si], 1
    inc si
    dec cl
    jnz fill_c

check_s:
    mov cl, correctS
    cmp cl, 0
    je check_t
fill_s:
    mov byte ptr [si], 2
    inc si
    dec cl
    jnz fill_s

check_t:
    mov cl, correctT
    cmp cl, 0
    je done_fill
fill_t:
    mov byte ptr [si], 3
    inc si
    dec cl
    jnz fill_t

done_fill:
    ret
gen_shapes endp

; ======================
; draw_shapes
; ======================
draw_shapes proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    xor bx, bx
shape_loop:
    cmp bx, 6
    jge done_draw

    mov al, shape_list[bx]
    cmp al, 0
    je  next_shape

    push ax

    mov ax, bx
    cmp ax, 3
    jb  top_row
    sub ax, 3
    mov dx, y_positions[2]  ; byte offset 2 = word index 1 (second y position = 92)
    jmp shape_pos_ready
top_row:
    mov dx, y_positions[0]
shape_pos_ready:
    shl ax, 1
    mov si, ax
    mov cx, x_positions[si]

    pop ax

    cmp al, 1
    je  pixel_circle
    cmp al, 2
    je  pixel_square
    cmp al, 3
    je  pixel_triangle
    jmp next_shape

pixel_circle:
    call draw_circle_shape
    jmp next_shape
pixel_square:
    call draw_square_shape
    jmp next_shape
pixel_triangle:
    call draw_triangle_shape

next_shape:
    inc bx
    jmp shape_loop

done_draw:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
draw_shapes endp

; ======================
; MAIN
; ======================
start:
    mov ax, @data
    mov ds, ax

    call init_files
    call login_screen

    call show_menu
    cmp  al, 0
    jne  skip1
    jmp  exit
skip1:

restart_game:
    mov byte ptr score, 0
    mov byte ptr mistakes, 0

game_loop:
    call gen_shapes
    call shuffle_shape_colors

    call set_video_mode
    call cls
    call draw_game_background

    ; --- Title (row 0) ---
    mov  dh, 01h
    mov  dl, 0Ah
    call setcur
    mov  dx, offset game_title
    call print

    ; --- Subtitle (row 1) ---
    mov  dh, 03h
    mov  dl, 08h
    call setcur
    mov  dx, offset msg
    call print

    ; --- Draw shapes (rows 3-15) ---
    call draw_shapes
    call start_round_timer

    ; Circles
    mov  dh, 13h
    mov  dl, 03h
    call setcur
    mov  dx, offset m3
    call print
    mov  dx, offset inp_prompt
    call print
    call input_digit_timed
    jnc  circle_ok
    jmp  round_timeout
circle_ok:
    cmp  al, correctC         ; bl = correctC
    jne  w1
    inc  score
    jmp  n1
w1:
    inc  mistakes
n1:
    
    ; Squares
    mov  dh, 14h        ; row 20
    mov  dl, 03h
    call setcur
    mov  dx, offset m4
    call print
    mov  dx, offset inp_prompt
    call print
    call input_digit_timed
    jnc  square_ok
    jmp  round_timeout
square_ok:
    cmp  al, correctS         ; bh = correctS
    jne  w2
    inc  score
    jmp  n2
w2:
    inc  mistakes
n2:

    ; Triangles
    mov  dh, 15h
    mov  dl, 03h
    call setcur
    mov  dx, offset m5
    call print
    mov  dx, offset inp_prompt
    call print
    call input_digit_timed
    jnc  triangle_ok
    jmp  round_timeout
triangle_ok:
    mov  cl, correctT   ; cl = correctT
    cmp  al, cl
    jne  w3
    inc  score
    jmp  after_input
w3:
    inc  mistakes

after_input:
    cmp  mistakes, 3
    jnb  skip2          ; mistakes >= 3 -> game over
    jmp  next_round
round_timeout:
    mov  mistakes, 3
    jmp  skip2
skip2:
    call show_retry
    cmp  al, 1
    jne  skip_retry
    jmp  restart_game
skip_retry:
    jmp  exit

next_round:
    call show_round_stats
    jmp  game_loop

exit:
    call set_text_mode
    mov  ah, 4Ch
    int  21h

end start



; =======================
;  If it works it works.
;
;  DON'T TOUCH IT
;
;  THANK YOU
; =======================