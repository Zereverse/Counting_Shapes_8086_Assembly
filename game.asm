.model small
.stack 100h

.data
; ===== Messages =====
game_title  db "SHAPE GAME ARENA", "$"
msg         db "COUNT THE SHAPES", "$"
m3          db "CIRCLE >", "$"
m4          db "SQUARE >", "$"
m5          db "TRIANGLE >", "$"
deadmsg     db "YOU DIED", "$"
statsmsg    db "ROUND CLEAR", "$"
time_label  db "TIME: ", "$"
wall_fail_msg db "ERROR PUT THE BITMAP TO IMAGE DIRECTORY", "$"
menu_start  db "START", "$"
menu_quit   db "QUIT", "$"
menu_retry  db "PLAY AGAIN?", "$"
retry_yes   db "YES", "$"

; ===== Scoreboard =====
scb2  db "SCR > ", "$"
scb3  db "MIS > ", "$"
score_text db "SCORE: ", "$"
name_text  db "NAME: ", "$"
diff_text  db "DIFFICULTY: ", "$"
mistake db "MISTAKES: ", "$"

; ===== Values =====
correctC    db ?
correctS    db ?
correctT    db ?
totalShapes db ?

score       dw 0
mistakes    db 0
difficulty    db 0 ; 1=easy, 2=medium, 3=hard
diff1  db "EASY", 0
diff2  db "MEDIUM", 0
diff3  db "HARD", 0
circle_color db 11h
square_color db 12h
triangle_color db 13h
round_start_cs dw 0
round_elapsed_cs dw 0
current_time_limit dw ?
current_max_seconds db ?
current_time_left  db ?

; Array to hold up to 6 shapes (0=empty, 1=Circle, 2=Square, 3=Triangle)
shape_list  db 6 dup(0)

; ===== BIT MAPS ======
wallpaper_name db "./image/wall.bmp", 0
login_bg       db "./image/login.bmp", 0
difficulty_bg  db "./image/diff.bmp", 0 
home_bg        db "./image/home.bmp", 0 
game_bg        db "./image/game.bmp", 0
default_bg     db "./image/default.bmp", 0

; ===== Menu strings =====
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
scoreboard_file db "scrboard.txt",0

bytes_read dw ?

current_user db 11 dup(0), '$'
user_exists db 0

; [0] = max chars (10)
; [1] = chars entered
; [2...] = text (null terminated)
input_buffer db 10
             db 0
             db 10 dup(0)

file_buffer db 1024 dup(0)
write_buf   db 0        ; scratch byte for write_char (must be in DS)
div10       dw 10       ; constant divisor for score conversion
digit_count dw 0        ; digit counter for score conversion

enter_text db "PRESS ENTER", "$"
limit_text db "10 CHARS MAX.", "$"
welcome_text db "WELCOME ", "$"

.code

init_scoreboard proc

    ; Try to open existing file (read-only)
    mov ah, 3Dh
    mov al, 0
    mov dx, offset scoreboard_file
    int 21h
    jc  isb_create          ; file not found -> create it

    ; File exists: close it and return
    mov bx, ax
    mov ah, 3Eh
    int 21h
    ret

isb_create:
    ; Create new empty file
    mov ah, 3Ch
    mov cx, 0               ; normal attributes
    mov dx, offset scoreboard_file
    int 21h
    jc  isb_done            ; creation failed (e.g. disk full) - just continue

    ; Close the newly created file
    mov bx, ax
    mov ah, 3Eh
    int 21h

isb_done:
    ret

init_scoreboard endp

; ==========================================
; LOGIN SCREEN
; ==========================================

show_login_screen proc

    call set_video_mode
    call cls

    mov dx, offset login_bg
    call draw_bitmap

    ; TITLE
    mov dh, 19
    mov dl, 14
    call setcur
    mov dx, offset enter_text
    call print

    ; LIMIT TEXT
    mov dh, 10
    mov dl, 14
    call setcur
    mov dx, offset limit_text
    call print

    jmp login_proceed

login_proceed:
    ; INPUT FIELD - position cursor and read
    mov dh, 14
    mov dl, 13
    call setcur

    call read_username

    call copy_username

    call check_user_exists

    cmp user_exists, 1
    je login_done

login_done:
    call set_video_mode
    call cls
    
    mov dx, offset default_bg
    call draw_bitmap

    mov dh, 12
    mov dl, 13
    call setcur
    mov dx, offset welcome_text
    call print

    mov si, offset current_user
login_welcome_loop:
    mov al, [si]
    cmp al, 0
    je login_welcome_done
    call draw_ui_char
    inc si
    jmp login_welcome_loop
login_welcome_done:

    ; pause ~1 second so player can read welcome
    call get_time_cs
    mov bx, ax
login_pause:
    call get_time_cs
    cmp ax, bx
    jae login_pause_nowrap
    add ax, 6000
login_pause_nowrap:
    sub ax, bx
    cmp ax, 100
    jb  login_pause

    ret
show_login_screen endp

; ==========================================
; READ USERNAME
; Reads up to 10 printable chars via BIOS
; int 16h, echoes each with draw_ui_char
; Backspace erases last char
; Enter confirms
; Result stored in input_buffer
; ==========================================
read_username proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    ; clear input_buffer count and text
    mov byte ptr input_buffer+1, 0
    mov cx, 10
    mov si, offset input_buffer+2
ru_clear:
    mov byte ptr [si], 0
    inc si
    loop ru_clear

ru_key_loop:
    mov ah, 00h
    int 16h                     ; wait for keypress -> AL=char, AH=scan

    cmp al, 0Dh                 ; Enter
    jne skip_ru_done
    jmp ru_done
skip_ru_done:

    cmp al, 08h                 
    jne skip_ru_backspace
    jmp ru_backspace
skip_ru_backspace:

    ; only accept A-Z, a-z, 0-9
    cmp al, '0'
    jb  ru_key_loop
    cmp al, '9'
    jbe ru_accept
    cmp al, 'A'
    jb  ru_key_loop
    cmp al, 'Z'
    jbe ru_accept
    cmp al, 'a'
    jb  ru_key_loop
    cmp al, 'z'
    ja  ru_key_loop

ru_accept:
    ; enforce max 10 chars
    mov bl, input_buffer+1
    xor bh, bh
    cmp bx, 10
    jae ru_key_loop

    ; uppercase if lowercase
    cmp al, 'a'
    jb  ru_no_upper
    sub al, 20h
ru_no_upper:

    ; store char
    mov si, offset input_buffer+2
    add si, bx
    mov [si], al

    ; echo char via pixel renderer
    call draw_ui_char

    ; increment count
    inc byte ptr input_buffer+1
    jmp ru_key_loop

ru_backspace:
    mov bl, input_buffer+1
    cmp bl, 0
    je  ru_key_loop             ; nothing to erase

    dec byte ptr input_buffer+1
    mov bl, input_buffer+1
    xor bh, bh

    ; clear char in buffer
    mov si, offset input_buffer+2
    add si, bx
    mov byte ptr [si], 0

    ; erase pixel glyph: move cursor back one col, fill rect to clear
    dec ui_col
    
    ; Calculate pixel position from ui_col and ui_row
    xor ax, ax
    mov al, ui_col
    shl ax, 3
    mov cx, ax      ; CX = pixel column
    
    xor ax, ax
    mov al, ui_row
    shl ax, 3
    mov dx, ax      ; DX = pixel row
    
    mov si, 8       ; width = 8 pixels
    mov di, 8       ; height = 8 pixels
    mov al, 14h     ; cream background color
    call fill_rect
    
    jmp ru_key_loop

ru_done:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

read_username endp

; ==========================================
; COPY INPUT TO current_user
; ==========================================
copy_username proc

    push si
    push di
    push cx

    mov cl,input_buffer+1
    xor ch,ch

    mov si,offset input_buffer+2
    mov di,offset current_user

copy_loop:

    cmp cx,0
    je copy_done

    mov al,[si]
    mov [di],al

    inc si
    inc di

    dec cx
    jmp copy_loop

copy_done:

    mov byte ptr [di],0

    pop cx
    pop di
    pop si

    ret

copy_username endp

; ==========================================
; CHECK IF USER EXISTS
; ==========================================
check_user_exists proc

    mov user_exists,0

    ; open file
    mov ah,3Dh
    mov al,0
    mov dx,offset scoreboard_file
    int 21h
    jc done_check

    mov bx,ax

    ; read file
    mov ah,3Fh
    mov cx,1024
    mov dx,offset file_buffer
    int 21h

    mov bytes_read,ax

    ; close file
    mov ah,3Eh
    int 21h

    ; search username
    mov si,offset file_buffer
    mov di,offset current_user

search_loop:

    mov al,[si]

    cmp al,0
    je done_check

    cmp al,[di]
    jne next_char

    push si
    push di

compare_loop:

    mov al,[si]
    mov bl,[di]

    cmp bl,0
    je found_user

    cmp al,bl
    jne not_match

    inc si
    inc di
    jmp compare_loop

found_user:

    mov user_exists,1

not_match:

    pop di
    pop si

next_char:

    inc si
    jmp search_loop

done_check:

    ret

check_user_exists endp

; ==========================================
; APPEND SCORE ENTRY TO SCOREBOARD FILE
; Writes: current_user, difficulty, score\r\n
; ==========================================
append_score proc
    push ax
    push bx
    push cx
    push dx
    push si

    ; Open file for writing (mode 1 = write-only)
    mov ah, 3Dh
    mov al, 1
    mov dx, offset scoreboard_file
    int 21h
    jnc append_score_opened
    jmp append_score_done
append_score_opened:

    mov bx, ax              ; BX = file handle

    ; Seek to end of file
    mov ah, 42h
    mov al, 2               ; from EOF
    xor cx, cx
    xor dx, dx
    int 21h

    ; Write username chars (up to null terminator)
    mov si, offset current_user
as_name_loop:
    mov dl, [si]
    cmp dl, 0
    je  as_write_comma1
    call write_char
    inc si
    jmp as_name_loop

as_write_comma1:
    ; Write ", "
    mov dl, ','
    call write_char
    mov dl, ' '
    call write_char

    ; Write difficulty as word (EASY / MEDIUM / HARD)
    mov al, difficulty
    cmp al, 1
    je  as_diff_easy
    cmp al, 2
    je  as_diff_medium
    mov si, offset diff3    ; default to HARD
    jmp as_diff_write
as_diff_easy:
    mov si, offset diff1
    jmp as_diff_write
as_diff_medium:
    mov si, offset diff2
as_diff_write:
    mov dl, [si]
    cmp dl, 0
    je  as_diff_done
    call write_char
    inc si
    jmp as_diff_write
as_diff_done:

    ; Write ", "
    mov dl, ','
    call write_char
    mov dl, ' '
    call write_char

    ; Write score as decimal digits
    ; Score is a word - convert to decimal string and write
    mov ax, score
    xor cx, cx              ; digit counter

as_score_div:
    xor dx, dx
    mov si, 10
    div si                  ; AX=quotient, DX=remainder
    push dx                 ; push digit (0-9)
    inc cx
    cmp ax, 0
    jne as_score_div

    ; Handle score = 0 edge case
    cmp cx, 0
    jne as_score_pop
    push 0
    inc cx

as_score_pop:
    pop dx
    add dl, '0'
    call write_char
    dec cx
    cmp cx, 0
    jne as_score_pop

    ; Write CRLF
    mov dl, 13
    call write_char
    mov dl, 10
    call write_char

    ; Close file
    mov ah, 3Eh
    int 21h

append_score_done:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

append_score endp

; ==========================================
; WRITE SINGLE CHAR TO FILE
; BX = file handle, DL = char to write
; ==========================================
write_char proc
    push ax
    push cx
    push dx

    mov  write_buf, dl      ; store char in DS variable (DS:DX must be valid)
    mov  ah, 40h
    mov  cx, 1
    mov  dx, offset write_buf
    int  21h

    pop  dx
    pop  cx
    pop  ax
    ret
write_char endp

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
; print number in AX (0-65535)
; ======================
print_num proc
    push ax
    push bx
    push cx
    push dx
    push di
    
    mov bx, 10          ; divisor
    xor cx, cx          ; digit count
    xor di, di          ; leading zero flag
    
    ; Special case for 0
    cmp ax, 0
    jne not_zero_pn
    mov al, '0'
    call draw_ui_char
    jmp done_print_num
    
not_zero_pn:
    ; Extract and push digits onto stack
digit_push_loop:
    xor dx, dx
    div bx              ; AX / 10 -> AX=quotient, DX=remainder
    push dx             ; Push digit (0-9)
    inc cx              ; Count digits
    cmp ax, 0
    jne digit_push_loop
    
    ; Pop and print digits (from stack = most significant first)
digit_pop_loop:
    pop ax
    add al, '0'
    call draw_ui_char
    dec cx
    cmp cx, 0
    jne digit_pop_loop
    
done_print_num:
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_num endp

; ===========================
;   SCOREBOARD screen
;   Reads scrboard.txt and displays each line.
;   Waits for Enter before returning.
; ===========================
show_scoreboard proc
    push ax
    push bx
    push cx
    push dx
    push si

    call set_video_mode
    call cls

    mov dx, offset default_bg
    call draw_bitmap
    
    mov dh, 01h
    mov dl, 02h
    call setcur
    mov dx, offset name_text
    call print
    
    mov dh, 01h
    mov dl, 08h
    call setcur
    mov dx, offset diff_text
    call print

    mov dh, 01h
    mov dl, 15h
    call setcur
    mov dx, offset score_text
    call print

    ; Open scoreboard file for reading
    mov ah, 3Dh
    mov al, 0
    mov dx, offset scoreboard_file
    int 21h
    jc  scb_no_file

    mov bx, ax

    ; Read up to 1024 bytes
    mov ah, 3Fh
    mov cx, 1024
    mov dx, offset file_buffer
    int 21h
    mov bytes_read, ax

    ; Close file
    push ax
    mov ah, 3Eh
    int 21h
    pop ax

    ; Null-terminate the buffer
    mov si, offset file_buffer
    add si, bytes_read
    mov byte ptr [si], 0

    ; Walk the buffer and display each line
    mov dh, 03h
    mov dl, 02h
    call setcur

    mov si, offset file_buffer

scb_print_loop:
    mov al, [si]
    cmp al, 0
    je  scb_print_done      ; end of buffer
    
    ; newline
    cmp al, 10              
    je  scb_newline
    cmp al, 13              
    je  scb_skip_cr

    ; Print the character
    call draw_ui_char
    inc si
    jmp scb_print_loop

scb_newline:
    inc si
    inc ui_row              ; next row
    mov ui_col, 02h         ; reset column
    jmp scb_print_loop

scb_skip_cr:
    inc si
    jmp scb_print_loop

scb_print_done:
    jmp scb_wait_enter

scb_no_file:
    ; Nothing to show - fall through to wait

scb_wait_enter:
    mov dh, 17h
    mov dl, 0Fh
    call setcur
    mov dx, offset enter_text
    call print

scb_enter_loop:
    mov ah, 00h
    int 16h
    cmp al, 0Dh             ; Enter key
    jne scb_enter_loop

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

show_scoreboard endp

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
    mov  dx, 24   ; rows
    mov  si, 30   ; width
    mov  di, 8    ; height
    mov  al, 14h  ; color
    call fill_rect

    ; Draw timer
    mov  dh, 03h
    mov  dl, 1Ch
    call setcur
    mov  dx, offset time_label
    call print
    mov  al, current_time_left
    xor  ah, ah         ; Clear AH to zero-extend AL for print_num
    call print_num

    ;REFRESH SCORE AND MISTAKES VALUE
    mov  cx, 255
    mov  dx, 160
    mov  si, 30          
    mov  di, 16
    mov  al, 14h
    call fill_rect

    mov  dh, 14h        
    mov  dl, 1Bh        
    call setcur
    mov  dx, offset scb2 ; SCORE
    call print
    mov  ax, score
    call print_num
    
    mov  dh, 15h        
    mov  dl, 1Bh        
    call setcur
    mov  dx, offset scb3 ; MISTAKES
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
; Round Timer is now dynamic based on difficulty
; , but now we need to initialize it at the start of each round
; ======================
start_round_timer proc
    call get_time_cs

    mov round_start_cs, ax
    mov round_elapsed_cs, 0

    mov al, current_max_seconds
    mov current_time_left, al

    call draw_timer

    ret
start_round_timer endp

; ======================
; refresh timer and detect timeout
; CF=1 if timer expired
; ======================
check_round_timer proc
    push ax
    push bx
    push dx

    call update_round_elapsed

    ; AX = elapsed ticks
    cmp ax, current_time_limit
    jae timer_expired

    ; elapsed / 100
    xor dx, dx
    mov bx, 100
    div bx

    ; remaining = max_seconds - elapsed_seconds
    mov bl, current_max_seconds
    sub bl, al

    mov current_time_left, bl

    call draw_timer

    clc
    jmp timer_done

timer_expired:
    mov current_time_left, 0
    call draw_timer
    stc

timer_done:
    pop dx
    pop bx
    pop ax
    ret
check_round_timer endp

set_easy_timer proc
    mov current_time_limit, 1000
    mov current_max_seconds, 10
    ret
set_easy_timer endp

set_medium_timer proc
    mov current_time_limit, 500
    mov current_max_seconds, 5
    ret
set_medium_timer endp

set_hard_timer proc
    mov current_time_limit, 300
    mov current_max_seconds, 3
    ret
set_hard_timer endp

; ======================
; timed single-digit input
; result AL=digit, CF=0 on success
; CF=1 on timeout
; Supports backspace to delete and re-input
; Requires Enter to confirm digit
; ======================
input_digit_timed proc
digit_input_loop:
    call check_round_timer
    jc  timed_out

    mov ah, 01h
    int 16h
    jz  digit_input_loop

    mov ah, 00h
    int 16h

    ; Ignore Enter and Backspace at digit input phase
    cmp al, 0Dh
    je  digit_input_loop
    cmp al, 08h
    je  digit_input_loop

    ; Check if it's a digit
    cmp al, '0'
    jb  digit_input_loop
    cmp al, '9'
    ja  digit_input_loop

    ; Draw the digit
    push ax
    call draw_ui_char
    pop ax

    ; Store digit in BL
    mov bl, al

    ; Wait for Enter to confirm or Backspace to retry
confirm_or_retry:
    ; IMPORTANT: check_round_timer is necessary otherwise it freezes the game well stuck in a loop to be precise
    call check_round_timer
    jc  timed_out

    mov ah, 01h
    int 16h
    jz  confirm_or_retry

    mov ah, 00h
    int 16h

    cmp al, 0Dh
    je  digit_confirmed
    cmp al, 08h
    je  digit_retry

    ; Any other key = ignore
    jmp confirm_or_retry

digit_confirmed:
    mov al, bl
    sub al, '0'
    clc
    ret

digit_retry:
    ; Clear the digit from screen
    dec ui_col

    ; Calculate pixel position from ui_col and ui_row
    xor ax, ax
    mov al, ui_col
    shl ax, 3
    mov cx, ax      ; CX = pixel column

    xor ax, ax
    mov al, ui_row
    shl ax, 3
    mov dx, ax      ; DX = pixel row

    mov si, 8       
    mov di, 8       
    mov al, 14h     
    call fill_rect

    jmp digit_input_loop

timed_out:
    stc
    ret
input_digit_timed endp

; ======================
; show inter-round stats
; Waits for Enter key to proceed
; ======================
show_round_stats proc
    push ax
    push dx
    push bx

    call cls
    mov ax, offset default_bg
    call draw_bitmap

    ; ROUND CLEAR
    mov  dh, 05h
    mov  dl, 0Eh
    call setcur
    mov  dx, offset statsmsg      
    call print

    ; Pres Enter to continue
    mov  dh, 14h
    mov  dl, 0Eh
    call setcur
    mov  dx, offset enter_text      
    call print

    ; SCORE N 
    mov  dh, 0Bh
    mov  dl, 10h
    call setcur
    mov  dx, offset score_text          
    call print
    mov  ax, score
    call print_num

    ; MISTAKES N 
    mov  dh, 0Eh
    mov  dl, 0Eh
    call setcur
    mov  dx, offset mistake         
    call print
    mov  al, mistakes
    call print_num

    ; Wait for Enter key to proceed
stats_wait:
    mov ah, 00h
    int 16h
    cmp al, 0Dh                 ; Enter key
    jne stats_wait

    pop  bx
    pop  dx
    pop  ax
    ret
show_round_stats endp

; ======================
; long death beep -- let's put the sounds here nothing for now
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
; draw_bitmap - draws any 8-bit 320x200 BMP to screen
; Input - DX = offset to null-terminated bitmap filename string
; Output - CF=1 on failure, CF=0 on success
; Modifies - all general purpose registers (AX, BX, CX, DX)
; ======================
draw_bitmap proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp
    push es

    mov wallpaper_handle, 0

    ; ==== Open file ====
    mov ah, 3Dh
    mov al, 00h
    int 21h
    jnc bitmap_open_ok
    jmp bitmap_fail

bitmap_open_ok:
    mov wallpaper_handle, ax
    mov bx, ax

    ; ==== Read BMP header (54 bytes) ====
    mov ah, 3Fh
    mov cx, 54
    mov dx, offset bmp_header
    int 21h
    jnc bitmap_header_read_ok
    jmp bitmap_fail_close

bitmap_header_read_ok:
    cmp ax, 54
    je  bitmap_validate_sig
    jmp bitmap_fail_close

    ; ==== Validate BMP signature ====
bitmap_validate_sig:
    cmp word ptr bmp_header, 4D42h
    je  bitmap_validate_width
    jmp bitmap_fail_close

    ; ==== Validate width = 320 ====
bitmap_validate_width:
    cmp word ptr bmp_header+18, 320
    je  bitmap_validate_width_hi
    jmp bitmap_fail_close

bitmap_validate_width_hi:
    cmp word ptr bmp_header+20, 0
    je  bitmap_validate_height
    jmp bitmap_fail_close

    ; ==== Validate height = 200 ====
bitmap_validate_height:
    cmp word ptr bmp_header+22, 200
    je  bitmap_validate_height_hi
    jmp bitmap_fail_close

bitmap_validate_height_hi:
    cmp word ptr bmp_header+24, 0
    je  bitmap_validate_bpp
    jmp bitmap_fail_close

    ; ==== Validate bits per pixel = 8 ====
bitmap_validate_bpp:
    cmp word ptr bmp_header+28, 8
    je  bitmap_validate_palette_offset
    jmp bitmap_fail_close

    ; ==== Validate palette offset and size ====
bitmap_validate_palette_offset:
    mov si, word ptr bmp_header+10
    cmp si, 54
    jae bitmap_calc_palette_size
    jmp bitmap_fail_close

bitmap_calc_palette_size:
    sub si, 54
    cmp si, 0
    jne bitmap_palette_size_ok
    jmp bitmap_fail_close

bitmap_palette_size_ok:
    cmp si, 1024
    jbe bitmap_read_palette
    jmp bitmap_fail_close

    ; ==== Read palette from file ====
bitmap_read_palette:
    mov ah, 3Fh
    mov cx, si
    mov dx, offset bmp_palette
    int 21h
    jnc bitmap_palette_read_ok
    jmp bitmap_fail_close

bitmap_palette_read_ok:
    cmp ax, si
    je  bitmap_load_palette
    jmp bitmap_fail_close

    ; ==== Load palette to VGA DAC ====
bitmap_load_palette:
    mov dx, 03C8h
    xor al, al
    out dx, al
    inc dx

    mov bp, si
    shr bp, 1
    shr bp, 1
    mov cx, word ptr bmp_header+46
    cmp cx, 0
    jne bitmap_palette_count_ok
    mov cx, bp

bitmap_palette_count_ok:
    cmp cx, bp
    jbe bitmap_palette_count_clamped
    mov cx, bp

bitmap_palette_count_clamped:
    mov si, offset bmp_palette

bitmap_palette_transfer:
    cmp cx, 0
    je  bitmap_palette_done
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
    jmp bitmap_palette_transfer

bitmap_palette_done:
    ; ==== Apply custom game colors (indices 16-20) ====
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

    ; ==== Draw bitmap data to video memory ====
    mov ax, 0A000h
    mov es, ax
    mov di, 63680
    mov bp, 200
    mov bx, wallpaper_handle

bitmap_row_loop:
    mov ah, 3Fh
    mov cx, 320
    mov dx, offset bmp_row_buffer
    int 21h
    jc  bitmap_fail_close
    cmp ax, 320
    jne bitmap_fail_close

    mov si, offset bmp_row_buffer
    mov cx, 320
    cld
    rep movsb
    sub di, 640
    dec bp
    jnz bitmap_row_loop

    ; ==== Close file and return success ====
    mov bx, wallpaper_handle
    mov ah, 3Eh
    int 21h
    mov wallpaper_handle, 0
    clc
    jmp bitmap_done

bitmap_fail_close:
    mov bx, wallpaper_handle
    cmp bx, 0
    je  bitmap_fail
    mov ah, 3Eh
    int 21h
    mov wallpaper_handle, 0

bitmap_fail:
    stc

bitmap_done:
    pop es
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
draw_bitmap endp

; ======================
; draw_wallpaper - wrapper for draw_bitmap with default wallpaper
; ======================
draw_wallpaper proc
    push dx
    mov dx, offset wallpaper_name
    call draw_bitmap
    pop dx
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
    mov al, 14h  
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


; ======================
; show main menu
; returns AL=1 start, AL=0 quit 
; ======================
show_menu proc
    call set_video_mode
    call cls

    mov dx , offset home_bg
    call draw_bitmap
    
    ; for checking
    mov dh, 01h
    mov dl, 01h
    call setcur
    mov dx, offset current_user
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
; show difficulty selection menu
; ======================
show_difficulty_menu proc
    call set_video_mode
    call cls

    mov dx, offset difficulty_bg
    call draw_bitmap

show_difficulty_menu_wait:
    mov ah, 00h
    int 16h
    cmp al, '1'
    je diff_easy
    cmp al, '2'
    je diff_medium
    cmp al, '3'
    je diff_hard
    jmp show_difficulty_menu_wait
diff_easy:
    mov al, 1
    ret
diff_medium:
    mov al, 2
    ret
diff_hard:
    mov al, 3
    ret
show_difficulty_menu endp

; ======================
; show retry menu
; returns AL=1 retry, AL=0 quit
; ======================
show_retry proc
    call set_video_mode
    call cls

    mov dx, offset default_bg
    call draw_bitmap
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
    mov  dx, offset score_text        ; "SCORE "
    call print
    mov  ax, score
    call print_num

    mov  dh, 07h
    mov  dl, 18h
    call setcur
    mov  dx, offset mistake        ; "MISTAKES "
    call print
    mov  al, mistakes
    call print_num

    ; PLAY AGAIN? 
    mov  dh, 05h
    mov  dl, 0fh
    call setcur
    mov  dx, offset menu_retry
    call print

    ; 1 YES
    mov  dh, 0Dh
    mov  dl, 12h
    call setcur
    mov  dx, offset retry_yes
    call print

    ; 2 QUIT
    mov  dh, 11h
    mov  dl, 12h
    call setcur
    mov  dx, offset menu_quit
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

; ========================================
; generate shapes and populate shape_list
; ========================================
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
    mov dx, y_positions + 2
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

    call init_scoreboard
    call show_login_screen

    call show_menu
    cmp  al, 0
    jne  skip1
    jmp  exit
skip1:
    call show_difficulty_menu
    cmp al, 1
    je  easy_mode
    cmp al, 2
    je  medium_mode
    cmp al, 3
    je  hard_mode

easy_mode:
    mov byte ptr [difficulty], 1
    call set_easy_timer
    jmp  restart_game
medium_mode:
    mov byte ptr [difficulty], 2
    call set_medium_timer
    jmp  restart_game
hard_mode:
    mov byte ptr [difficulty], 3
    call set_hard_timer
    jmp  restart_game

restart_game:
    mov byte ptr score, 0
    mov byte ptr mistakes, 0

game_loop:
    call start_round_timer
    
    call gen_shapes

    call set_video_mode
    call cls

    mov dx, offset game_bg
    call draw_bitmap

    ; --- Subtitle (row 1) ---
    mov  dh, 03h
    mov  dl, 07h
    call setcur
    mov  dx, offset msg ; COUNT THE SHAPES
    call print

    ; --- Draw shapes (rows 3-15) ---
    call draw_shapes
    call check_round_timer

    ; Circles
    mov  dh, 13h
    mov  dl, 03h
    call setcur
    mov  dx, offset m3
    call print
    call input_digit_timed
    jnc  circle_ok
    jmp  round_timeout
circle_ok:
    cmp  al, correctC         
    jne  w1
    inc  score
    jmp  n1
w1:
    inc  mistakes
n1:
    
    ; Squares
    mov  dh, 14h        
    mov  dl, 03h
    call setcur
    mov  dx, offset m4
    call print
    call input_digit_timed
    jnc  square_ok
    jmp  round_timeout
square_ok:
    cmp  al, correctS         
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
    call input_digit_timed
    jnc  triangle_ok
    jmp  round_timeout
triangle_ok:
    mov  cl, correctT   
    cmp  al, cl
    jne  w3
    inc  score
    jmp  after_input
w3:
    inc  mistakes

after_input:
    cmp  mistakes, 3
    jnb  game_over          ; mistakes >= 3 -> game over
    jmp  next_round
round_timeout:
    mov  mistakes, 3
    jmp  game_over

game_over:
    call append_score
    call show_scoreboard

skip2:
    call show_retry
    cmp  al, 1
    jne  skip_retry
    jmp  skip1
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