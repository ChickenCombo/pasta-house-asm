JUMPS

.model small
.code

org 100h

s:  jmp main

    ; String variables for the menu
    m db "Menu: $"
    a db "[1] - Programmers' Name$"
    b db "[2] - ASCII Characters$"
    c db "[3] - Sum of a two-digit number$"
    d db "[4] - Store Program$"
    e db "[Q] - Quit$"
    f db "Enter choice: $"

    ; String variable for new line
    nl db 10, 13, "$"

    ; String variables for the names
    lc db 10, 13, "Lester Cuadra", 10, 13, "$"
    gg db "Gab Galguerra", 10, 13, "$"
    kr db "Kirby Revilla", 10, 13, "$"
    cn db "Charles Nobleza", 10, 13, "$"

    ; String variable for the invalid message
    iv db 10, 13, "!Invalid Input!", 10, 13, "$"

    ; String variable for "Continue"
    ct db 10, 13, "Please enter any key to continue! $"

    ; String variables for Sum of 2-digits
    inp1 db "Input a two-digit number: $"
    inp2 db "Input another two-digit number: $"
    answer db 10, 13, "The sum is: $"
    try db "Try again? [y/n]: $"

    uia db "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออป", 10, 13, "$"
    uib db "บ                       Pasta House                      บ", 10, 13, "$"
    uic db "บ     ษอออออป      ษอออออป      ษอออออป      ษอออออป     บ", 10, 13, "$"
    uid db "บ     บ  9  บ      บ  9  บ      บ  9  บ      บ  9  บ     บ", 10, 13, "$"
    uie db "บ     ศอออออผ      ศอออออผ      ศอออออผ      ศอออออผ     บ", 10, 13, "$"
    uif db "บ  [c]carbonara   [f]farro    [t]fetuccini  [l]lasagna   บ", 10, 13, "$"
    uig db "ฬออออออออออออออออออออออออออออออออออออออออออออออออออออออออน", 10, 13, "$"
    uih db "บ                                                        บ", 10, 13, "$"
    uii db "ฬออออออออออออออออออออออออออออออออออออออออออออออออออออออออน", 10, 13, "$"
    uij db "บ       what? [ ]    qty? [ ]    buy again? y/n [ ]      บ", 10, 13, "$"
    uik db "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ", 10, 13, "$"

    uiinvalid db "บ                       Invalid                          บ$"
    uicarbonara db "บ                   Buying carbonara                     บ$"
    uifarro db "บ                     Buying farro                       บ$"
    uifetuccini db "บ                   Buying fetuccini                     บ$"
    uilasagna db "บ                    Buying lasagna                      บ$"
    uioos db "บ               Sorry, the store is closed!              บ$"
    uiinsufficient db "บ                 Insufficient Product                   บ$"
    uicontinue db "บ                       Continue?                        บ$"
    zero db "Zero!$"

    ; Variables for product items
    w db ?
    x db ?
    y db ?
    z db ?

    ; Start of the program
    main proc
        ; Clear Screen
        mov ax, 03
        int 10h

        ; Prints the main menu
        call menu

        ; Gets the input from the user then transfer it to cl
        call input
        mov cl, al
        call compare

        ; Prompts the user to enter any key to continue
        lea dx, ct
        call print
        call input

        ; Loops through the program
        jmp main
    main endp

    ; Prints the main menu
    menu proc
        lea dx, m
        call print
        lea dx, nl
        call print

        lea dx, a
        call print
        lea dx, nl
        call print

        lea dx, b
        call print
        lea dx, nl
        call print

        lea dx, c
        call print
        lea dx, nl
        call print

        lea dx, d
        call print
        lea dx, nl
        call print

        lea dx, e
        call print
        lea dx, nl
        call print

        lea dx, f
        call print

        ret
    menu endp

    ; Uses mov ah, 9 to output string
    print proc
        mov ah, 9
        int 21h
        ret
    print endp

    ; Uses mov ah, 1 to get a character input from the user
    input proc
        mov ah, 1
        int 21h
        ret
    input endp

    ; Compares the user input and jumps to the corresponding option
    compare proc
        cmp cl, '1'
        je one

        cmp cl, '2'
        je two

        cmp cl, '3'
        je three

        cmp cl, '4'
        je four

        cmp cl, 'Q'
        je quit

        cmp cl, 'q'
        je quit

        jmp inv

        ; [1] Programmers' Names
        one:    lea dx, nl
                call print

                lea dx, lc
                call print

                lea dx, gg
                call print

                lea dx, kr
                call print

                lea dx, cn
                call print

                ret

        ; [2] Display ASCII Characters
        two:    lea dx, nl
                call print

                lea dx, nl
                call print

                ; Initiates CX to 256 because there are 256 ASCII characters
                mov cx, 256
                mov ah, 2
                mov dl, 0

                ; Print current ASCII character, increment by one, then loop until it reaches 256
                ascii:
                    int 21h
                    inc dl
                loop ascii

                lea dx, nl
                call print

                ret

        ; [3] Sum of 2-digit no.
        three:  call sum

                lea dx, try
                call print

                call input

                cmp al, 'Y'
                je three

                cmp al, 'y'
                je three

                cmp al, 'N'
                je main

                cmp al, 'n'
                je main

                jmp inv

                ret

        ; [4] Store Program  
        four:   mov ax, 03
                int 10h

                mov w, 39h
                mov x, 39h
                mov y, 39h
                mov z, 39h

                call ui

                validate: mov dl, 15
                          mov dh, 9
                          call cursor 
                          call input

                          cmp al, 'C'
                          je carbonara

                          cmp al, 'c'
                          je carbonara

                          cmp al, 'F'
                          je farro

                          cmp al, 'f'
                          je farro

                          cmp al, 'T'
                          je fetuccini

                          cmp al, 't'
                          je fetuccini

                          cmp al, 'L'
                          je lasagna

                          cmp al, 'l'
                          je lasagna

                          cmp al, 'Q'
                          je main

                          cmp al, 'q'
                          je main

                          mov dl, 0
                          mov dh, 7
                          call cursor

                          lea dx, uiinvalid
                          call print
                          jmp validate

               carbonara: cmp w, '0'
                          je oos

                          mov dl, 0
                          mov dh, 7
                          call cursor

                          lea dx, uicarbonara
                          call print

                          cval:     mov dl, 27
                                    mov dh, 9
                                    call cursor
                                    call input
                                    cmp w, al
                                    jl inw
                                            
                          cmp al, '0'
                          je subc

                          cmp al, '1'
                          je subc

                          cmp al, '2'
                          je subc

                          cmp al, '3'
                          je subc

                          cmp al, '4'
                          je subc

                          cmp al, '5'
                          je subc

                          cmp al, '6'
                          je subc

                          cmp al, '7'
                          je subc

                          cmp al, '8'
                          je subc

                          cmp al, '9'
                          je subc
                        
                          loop carbonara

                subc:     cmp w, al
                          jl oos

                          sub w, al
                          add w, 30h

                          mov dl, 9
                          mov dh, 3
                          call cursor

                          mov dl, w
                          mov ah, 2
                          int 21h

                          cmp w, '0'
                          je zrw

                          jmp yn

                farro:    cmp x, '0'
                          je oos

                          mov dl, 0
                          mov dh, 7
                          call cursor

                          lea dx, uifarro
                          call print

                          xval:    mov dl, 27
                                   mov dh, 9
                                   call cursor
                                   call input
                                   cmp x, al
                                   jl inx

                          cmp al, '0'
                          je subx

                          cmp al, '1'
                          je subx

                          cmp al, '2'
                          je subx

                          cmp al, '3'
                          je subx

                          cmp al, '4'
                          je subx

                          cmp al, '5'
                          je subx

                          cmp al, '6'
                          je subx

                          cmp al, '7'
                          je subx

                          cmp al, '8'
                          je subx

                          cmp al, '9'
                          je subx

                          loop farro

                 subx:    cmp x, al
                          jl oos

                          sub x, al
                          add x, 30h

                          mov dl, 22
                          mov dh, 3
                          call cursor

                          mov dl, x
                          mov ah, 2
                          int 21h

                          cmp x, '0'
                          je zrx

                          jmp yn


            fetuccini:    cmp y, '0'
                          je oos

                          mov dl, 0
                          mov dh, 7
                          call cursor

                          lea dx, uifetuccini
                          call print

                          yval:    mov dl, 27
                                   mov dh, 9
                                   call cursor
                                   call input
                                   cmp y, al
                                   jl iny

                          cmp al, '0'
                          je suby

                          cmp al, '1'
                          je suby

                          cmp al, '2'
                          je suby

                          cmp al, '3'
                          je suby

                          cmp al, '4'
                          je suby

                          cmp al, '5'
                          je suby

                          cmp al, '6'
                          je suby

                          cmp al, '7'
                          je suby

                          cmp al, '8'
                          je suby

                          cmp al, '9'
                          je suby

                          loop fetuccini

                 suby:    cmp y, al
                          jl oos

                          sub y, al
                          add y, 30h

                          mov dl, 35
                          mov dh, 3
                          call cursor

                          mov dl, y
                          mov ah, 2
                          int 21h

                          cmp y, '0'
                          je zry

                          jmp yn

               lasagna:   cmp z, '0'
                          je oos

                          mov dl, 0
                          mov dh, 7
                          call cursor

                          lea dx, uilasagna
                          call print

                          zval:    mov dl, 27
                                   mov dh, 9
                                   call cursor
                                   call input
                                   cmp z, al
                                   jl inz

                          cmp al, '0'
                          je subz

                          cmp al, '1'
                          je subz

                          cmp al, '2'
                          je subz

                          cmp al, '3'
                          je subz

                          cmp al, '4'
                          je subz

                          cmp al, '5'
                          je subz

                          cmp al, '6'
                          je subz

                          cmp al, '7'
                          je subz

                          cmp al, '8'
                          je subz

                          cmp al, '9'
                          je subz

                          loop lasagna

                subz:     cmp z, al
                          jl oos

                          sub z, al
                          add z, 30h

                          mov dl, 48
                          mov dh, 3
                          call cursor

                          mov dl, z
                          mov ah, 2
                          int 21h
                          
                          cmp z, '0'
                          je zrz
                          jmp yn

                         inw:      mov dl, 0
                                   mov dh, 7
                                   call cursor

                                   lea dx, uiinsufficient
                                   call print
                                   jmp cval

                         inx:      mov dl, 0
                                   mov dh, 7
                                   call cursor

                                   lea dx, uiinsufficient
                                   jmp xval

                         iny:      mov dl, 0
                                   mov dh, 7
                                   call cursor

                                   lea dx, uiinsufficient
                                   jmp yval

                         inz:      mov dl, 0
                                   mov dh, 7
                                   call cursor

                                   lea dx, uiinsufficient
                                   jmp zval

                          yn:      mov dl, 0
                                   mov dh, 7
                                   call cursor

                                   lea dx, uicontinue
                                   call print

                                   mov dl, 49
                                   mov dh, 9
                                   call cursor

                                   call input
                                   cmp al, 'Y'
                                   je validate

                                   cmp al, 'y'
                                   je validate

                                   cmp al, 'N'
                                   je main

                                   cmp al, 'n'
                                   je main

                                   loop yn

                          oos:     mov dl, 0
                                   mov dh, 7
                                   call cursor

                                   lea dx, uioos
                                   call print
                                   jmp validate

                          zrw:     mov dl, 7
                                   mov dh, 3
                                   call cursor

                                   lea dx, zero
                                   call print
                                   jmp yn

                          zrx:     mov dl, 20
                                   mov dh, 3
                                   call cursor

                                   lea dx, zero
                                   call print
                                   jmp yn

                          zry:     mov dl, 33
                                   mov dh, 3
                                   call cursor

                                   lea dx, zero
                                   call print
                                   jmp yn

                          zrz:     mov dl, 46
                                   mov dh, 3
                                   call cursor

                                   lea dx, zero
                                   call print
                                   jmp yn
                ret


        ; Quit the program if input is equal to 'Q' or 'q'
        quit:   int 20h

        ; Print '!Invalid Input!'
        inv:    lea dx, nl
                call print

                lea dx, iv
                call print

                ret
    compare endp

    sum proc
            ; Print new line
            lea dx, nl
            call print

            lea dx, nl
            call print

            ; Print prompt message from inp1
            lea dx, inp1
            call print

            ; Get inp1 from user (Tenths value)
            call input

            ; Subtracts 48 to the input to get the actual value (ex. 50 ASCII = 2, 50 - 48 = 2 (Decimal value))
            sub al, 48
            mov bh, al

            ; Get inp1 from user (Ones value)
            call input

            ; Subtracts 48 to the input to get the actual value (ex. 50 ASCII = 2, 50 - 48 = 2 (Decimal value))
            sub al, 48
            mov bl, al

            ; Print new line
            lea dx, nl
            call print

            ; Print prompt message from inp2
            lea dx, inp2
            call print

            ; Get inp2 from user (Tenths value)
            call input

            ; Subtracts 48 to the input to get the actual value (ex. 50 ASCII = 2, 50 - 48 = 2 (Decimal value))
            sub al, 48
            mov ch, al

            ; Get inp2 from user (Ones value)
            call input

            ; Subtracts 48 to the input to get the actual value (ex. 50 ASCII = 2, 50 - 48 = 2 (Decimal value))
            sub al, 48
            mov cl, al

            ; Add the two values together
            add bl, cl

            mov al, bl
            mov ah, 0
            aaa

            mov cl, al
            mov bl, ah

            add bl, bh
            add bl, ch

            mov al, bl
            mov ah, 0
            aaa

            mov bx, ax

            mov dx, offset answer
            mov ah, 9
            int 21h

            mov dl, bh
            add dl, 48
            mov ah, 2
            int 21h

            mov dl, bl
            add dl, 48
            mov ah, 2
            int 21h

            mov dl, cl
            add dl, 48
            mov ah, 2
            int 21h

            ; Print new line
            lea dx, nl
            call print

            ret
    sum endp

    cursor proc
            mov ah, 2
            mov bh, 0
            int 10h

            ret
    cursor endp

    ui proc
            lea dx, uia
            call print

            lea dx, uib
            call print

            lea dx, uic
            call print

            lea dx, uid
            call print
                
            lea dx, uie
            call print

            lea dx, uif
            call print

            lea dx, uig
            call print

            lea dx, uih
            call print

            lea dx, uii
            call print

            lea dx, uij
            call print

            lea dx, uik
            call print

            ret
    ui endp
end s
