.data
.equ buttons, 0x2050
.equ esp, 0x2030

.equ button0, 0x1 #r3
.equ button1, 0x2 #r13
.equ button2, 0x4 #r14
.equ button3, 0x8 #r16
.equ button4, 0x16 #r17
.equ button5, 0x32 #r18
.equ button6, 0x64 #r19
.equ button7, 0x128 #r20
.equ button8, 0x254 #r21
.equ button9, 0x508 #r22
.equ button10, 0x1024 #r23

#Macro usado para instrucoes do lcd, facilita a chamada
.macro instr databits
	movi r1, 0 # Adiciona 0 ao registrador r1 para o Modulo LCD (Custom Instruction) reconhecer que será dados para instruções 
	custom 0, r0, r1, \databits  # custom index, result, dataA, dataB   custom index, data result, data instr or write, databyte chain 
.endm
#Macro usado para dados no lcd, facilita a chamada
.macro data databits
	movi r1, 1 # Adiciona 1 ao registrador r1 para o Modulo LCD (Custom Instruction) reconhecer que será dados para escrita 
	custom 0, r0, r1, \databits
.endm

.text
.global main

/*IP local:192.168.43.11 , End MAC: 18:FE:34:DA:55:E0*/

main:
	call initialize
	br menu

# Espera entrada de buttons para enviar comandos
menu:
	ldbio r10, 0(r12)
	mov r11, r10
	bne r10, r0, comands
	br menu

comands:
	ldbio r10, 0(r12)
	bne r10, r0, comands
	beq r11, r3, echoMod
	beq r11, r13, tcpPingBroker
	beq r11, r14, chooseMod
	beq r11, r16, connectAP


# Retorna versao atual do firmware
versionFirm:
	movi r5,65 #A
	call sendChar
	#call delay
	movi r5,84 #T
	call sendChar
	#call delay
	movi r5,43 #+
	call sendChar
	#call delay
	movi r5,71 #G
	call sendChar
	#call delay
	movi r5,77 #M
	call sendChar
	#call delay
	movi r5,82 #R
	call sendChar
	#call delay
	movi r5,13 #\r
	call sendChar
	#call delay
	movi r5,10 #\n
	call sendChar
	#call delay

	addi r9,r9,4
	#call print
	jmp r9


# Resertar Modulo ESP8266
reset:
	movi r5,65 #A
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,43 #+
	call sendChar
	call delay
	movi r5,82 #R
	call sendChar
	call delay
	movi r5,83 #S
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,13 #\r
	call sendChar
	call delay
	movi r5,10 #\n
	call sendChar
	call delay

	br menu

# Modo que retorna comando at enviado
echoMod:
	movi r5,65 #A
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,69 #E
	call sendChar
	call delay
	movi r5,48 #0
	call sendChar
	call delay
	movi r5,13 #\r
	call sendChar
	call delay
	movi r5,10 #\n
	call sendChar
	call delay
	nextpc r9
	br print
	br menu

# Printa os caracteres recebidos do ESP
print:
	instr r3 #Limpa buffer do LCD
	call getChar
	data r2
	call getChar
	data r2	
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	call getChar
	data r2
	addi r9, r9, 4
	#movi r15, 0xc0 # move para 2 linha
	#instr r15
	jmp r9	
	#br menu

/*
AT+chooseMod_CUR=3
Existem três modos de funcionamento WiFi: Modo Estação, modo softAP e a coexistência do modo Estação e do modo softAP. Este comando é usado para adquirir o modo Wi-Fi existente 
ou para definir um modo WiFi personalizado.
*/
chooseMod:
	movi r5,65 #A
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,43 #+
	call sendChar
	call delay
	movi r5,67 #C
	call sendChar
	call delay
	movi r5,87 #W
	call sendChar
	call delay
	movi r5,77 #M
	call sendChar
	call delay
	movi r5,79 #O
	call sendChar
	call delay
	movi r5,68 #D
	call sendChar
	call delay
	movi r5,69 #E
	call sendChar
	call delay
	movi r5,95 #_
	call sendChar
	call delay
	movi r5,67 #C
	call sendChar
	call delay
	movi r5,85 #U
	call sendChar
	call delay
	movi r5,82 #R
	call sendChar
	call delay
	movi r5,61 #=
	call sendChar
	call delay
	movi r5,49 #1
	call sendChar
	call delay
	movi r5,13 #\r
	call sendChar
	call delay
	movi r5,10 #\n
	call sendChar
	call delay

	nextpc r9
	br print
	br menu


/*
AT + CWJAP_CUR - Conecte-se ao AP, não salve no Flash
*/
connectAP:
	movi r5,65 #A
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,43 #+
	call sendChar
	call delay
	movi r5,67 #C
	call sendChar
	call delay
	movi r5,87 #W
	call sendChar
	call delay
	movi r5,74 #J
	call sendChar
	call delay
	movi r5,65 #A
	call sendChar
	call delay
	movi r5,80 #P
	call sendChar
	call delay
	/*
	movi r5,95 #_
	call sendChar
	call delay
	movi r5,67 #C
	call sendChar
	call delay
	movi r5,85 #U
	call sendChar
	call delay
	movi r5,82 #R
	call sendChar
	call delay
	*/
	movi r5,61 #=
	call sendChar
	call delay
	movi r5,34 #"
	call sendChar
	call delay
	movi r5,87 #W
	call sendChar
	call delay
	movi r5,76 #L
	call sendChar
	call delay
	movi r5,101 #e
	call sendChar
	call delay
	movi r5,115 #s
	call sendChar
	call delay
	movi r5,115 #s
	call sendChar
	call delay
	movi r5,76 #L
	call sendChar
	call delay
	movi r5,69 #E
	call sendChar
	call delay
	movi r5,68 #D
	call sendChar
	call delay
	movi r5,83 #S
	call sendChar
	call delay
	movi r5,34 #"
	call sendChar
	call delay
	movi r5,44 #,
	call sendChar
	call delay
	movi r5,34 #"
	call sendChar
	call delay
	movi r5,72 #H
	call sendChar
	call delay
	movi r5,101 #e
	call sendChar
	call delay
	movi r5,108 #l
	call sendChar
	call delay
	movi r5,108 #l
	call sendChar
	call delay
	movi r5,111 #o
	call sendChar
	call delay
	movi r5,87 #W
	call sendChar
	call delay
	movi r5,111 #o
	call sendChar
	call delay
	movi r5,114 #r
	call sendChar
	call delay
	movi r5,108 #l
	call sendChar
	call delay
	movi r5,100 #d
	call sendChar
	call delay
	movi r5,77 #M
	call sendChar
	call delay
	movi r5,80 #P
	call sendChar
	call delay
	movi r5,51 #3
	call sendChar
	call delay
	movi r5,49 #1
	call sendChar
	call delay
	movi r5,34 #"
	call sendChar
	call delay
	movi r5,13 #\r
	call sendChar
	call delay
	movi r5,10 #\n
	call sendChar
	call delay

	
	nextpc r9
	br print
	br menu


/*
AT + CIPMUX - Habilita múltiplas conexões ou não
1. "AT + CIPMUX = 1" só pode ser definido quando a transmissão transparente estiver desativada
("AT + CIPMODE = 0")
2. Este modo só pode ser alterado após todas as conexões serem desconectadas.
3. Se o servidor TCP for iniciado, tem que apagar o servidor TCP primeiro, então a mudança para conexão única é permitida.
*/
enableConnect:
	movi r5,65 #A
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,43 #+
	call sendChar
	call delay
	movi r5,67 #C
	call sendChar
	call delay
	movi r5,73 #I
	call sendChar
	call delay
	movi r5,80 #P
	call sendChar
	call delay
	movi r5,77 #M
	call sendChar
	call delay
	movi r5,85 #U
	call sendChar
	call delay
	movi r5,88 #X
	call sendChar
	call delay
	movi r5,61 #=
	call sendChar
	call delay
	movi r5,48 #0 se colocar 0 é 48 se 1 é 49
	call sendChar
	call delay
	movi r5,13 #\r
	call sendChar
	call delay
	movi r5,10 #\n
	call sendChar
	call delay

	addi r9,r9,4
	jmp r9

/*
O monitor do servidor será criado automaticamente quando o servidor for criado. Quando um cliente está conectado ao servidor, ele recebe uma conexão e recebe um ID.
*/
tcpConfig:
	movi r5,65 #A
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,43 #+
	call sendChar
	call delay
	movi r5,67 #C
	call sendChar
	call delay
	movi r5,73 #I
	call sendChar
	call delay
	movi r5,80 #P
	call sendChar
	call delay
	movi r5,83 #S
	call sendChar
	call delay
	movi r5,69 #E
	call sendChar
	call delay
	movi r5,82 #R
	call sendChar
	call delay
	movi r5,86 #V
	call sendChar
	call delay
	movi r5,69 #E
	call sendChar
	call delay
	movi r5,82 #R
	call sendChar
	call delay
	movi r5,61 #=
	call sendChar
	call delay
	movi r5,49 #1
	call sendChar
	call delay
	movi r5,44 #,
	call sendChar
	call delay
	movi r5,56 #8
	call sendChar
	call delay
	movi r5,48 #0
	call sendChar
	call delay
	movi r5,13 #\r
	call sendChar
	call delay
	movi r5,10 #\n
	call sendChar
	call delay

	addi r9,r9,4
	jmp r9

tcpPingBroker:
	movi r5,65 #A
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,43 #+
	call sendChar
	call delay
	movi r5,80 #P
	call sendChar
	call delay
	movi r5,73 #I
	call sendChar
	call delay
	movi r5,78 #N
	call sendChar
	call delay
	movi r5,71 #G
	call sendChar
	call delay
	movi r5,61 #=
	call sendChar
	call delay
	movi r5,34 #"
	call sendChar
	call delay
	movi r5,49 #1
	call sendChar
	call delay
	movi r5,57 #9
	call sendChar
	call delay
	movi r5,50 #2
	call sendChar
	call delay
	movi r5,46 #.
	call sendChar
	call delay
	movi r5,49 #1
	call sendChar
	call delay
	movi r5,54 #6
	call sendChar
	call delay
	movi r5,56 #8
	call sendChar
	call delay
	movi r5,46 #.
	call sendChar
	call delay
	movi r5,49 #1
	call sendChar
	call delay
	movi r5,46 #.
	call sendChar
	call delay
	movi r5,50 #2
	call sendChar
	call delay
	movi r5,48 #0
	call sendChar
	call delay
	movi r5,48 #0
	call sendChar
	call delay
	movi r5,34 #"
	call sendChar
	call delay
	# ----- End block ----- $
	movi r5,13 #\r
	call sendChar
	call delay
	movi r5,10 #\n
	call sendChar
	call delay
	br print
	nextpc r9
	a:
	br a
	
	addi r9,r9,4
	jmp r9


tcpConfigBroker:
	movi r5,65 #A
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,43 #+
	call sendChar
	call delay
	movi r5,67 #C
	call sendChar
	call delay
	movi r5,73 #I
	call sendChar
	call delay
	movi r5,80 #P
	call sendChar
	call delay
	movi r5,83 #S
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,65 #A
	call sendChar
	call delay
	movi r5,82 #R
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,61 #=
	call sendChar
	call delay
	movi r5,34 #"
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,67 #C
	call sendChar
	call delay
	movi r5,80 #P
	call sendChar
	call delay
	movi r5,34 #"
	call sendChar
	call delay
	movi r5,44 #,
	call sendChar
	call delay
	movi r5,34 #"
	call sendChar
	call delay
	movi r5,49 #1
	call sendChar
	call delay
	movi r5,57 #9
	call sendChar
	call delay
	movi r5,50 #2
	call sendChar
	call delay
	movi r5,46 #.
	call sendChar
	call delay
	movi r5,49 #1
	call sendChar
	call delay
	movi r5,54 #6
	call sendChar
	call delay
	movi r5,56 #8
	call sendChar
	call delay
	movi r5,46 #.
	call sendChar
	call delay
	movi r5,49 #1
	call sendChar
	call delay
	movi r5,46 #.
	call sendChar
	call delay
	movi r5,50 #2
	call sendChar
	call delay
	movi r5,48 #0
	call sendChar
	call delay
	movi r5,48 #0
	call sendChar
	call delay
	movi r5,34 #"
	call sendChar
	call delay
	movi r5,44 #,
	call sendChar
	call delay
	movi r5,49 #1
	call sendChar
	call delay
	movi r5,56 #8
	call sendChar
	call delay
	movi r5,56 #8
	call sendChar
	call delay
	movi r5,51 #3
	call sendChar
	call delay
	movi r5,13 #\r
	call sendChar
	call delay
	movi r5,10 #\n
	call sendChar
	call delay

	c:
	br c
	addi r9,r9,4
	jmp r9

exitConnect:
	movi r5,65 #A
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,43 #+
	call sendChar
	call delay
	movi r5,67 #C
	call sendChar
	call delay
	movi r5,73 #I
	call sendChar
	call delay
	movi r5,80 #P
	call sendChar
	call delay
	movi r5,67 #C
	call sendChar
	call delay
	movi r5,76 #L
	call sendChar
	call delay
	movi r5,79 #O
	call sendChar
	call delay
	movi r5,83 #S
	call sendChar
	call delay
	movi r5,69 #E
	call sendChar
	call delay
	movi r5,13 #\r
	call sendChar
	call delay
	movi r5,10 #\n
	call sendChar
	call delay

	addi r9,r9,4
	jmp r9

# AT+CWQAP - Desconecta Access Point
disconnectAP:
	movi r5,65 #A
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,43 #+
	call sendChar
	call delay
	movi r5,67 #C
	call sendChar
	call delay
	movi r5,87 #W
	call sendChar
	call delay
	movi r5,87 #Q
	call sendChar
	call delay
	movi r5,65 #A
	call sendChar
	call delay
	movi r5,80 #P
	call sendChar
	call delay
	movi r5,13 #\r
	call sendChar
	call delay
	movi r5,10 #\n
	call sendChar
	call delay
	
	addi r9,r9,4
	jmp r9

delay:
	movi r8,16000
	movi r1,0

loop:
	bgt r1,r8,endDelay
	addi r1,r1,1
	br loop

endDelay:
	ret

/*
A sub-rotina sendChar tenta criar um caractere para a RS232UART. Ela é bem sucedida na fila TX FIFO da UART RS232, que determina pela leitura dos bits 23 a 16 do
registrador Control. Se não houver espaço, a sub-rotina pula a instrução stwio, não escrevendo o caractere para o RS232 UART.
*/
sendChar:
	/* save any modified registers */
	subi sp, sp, 4 												/* reserve space on the stack */
	stw r6, 0(sp) 												/* save register */
	ldwio r6, 4(r4) 											/* read the RS232 UART Control register */
	andhi r6, r6, 0x00ff 										/* check for write space */
	beq r6, r0, endPut 										/* if no space, ignore the character */
	stwio r5, 0(r4) 											/* send the character */

endPut:
	/* restore registers */
	ldw r6, 0(sp)
	addi sp, sp, 4
	
	ret
/**
As sub-rotinas getChar são características do UR232UART,e retornam esse caractere no registro2. Se a fila RX FIFO da UART RS232 estiver vazia, ela retornará o caractere nulo "\ 0".
**/
getChar: 
	/* save any modified registers */
	subi sp, sp, 8 												/* reserve space on the stack */
	stw r5, 0(sp) 												/* save register */
	ldwio r2, 0(r4) 											/* read the RS232 UART Data register */
	andi r5, r2, 0x8000 										/* check if there is new data */
	bne r5, r0, returnChar
	mov r2, r0 													/* if no new data, return ‘\0’ */

returnChar:
	andi r5, r2, 0x00ff 										/* the data is in the least significant byte */
	mov r2, r5 													/* set r2 with the return value */

	/* restore registers */
	ldw r5, 0(sp)
	addi sp, sp, 8
	ret




# Inicializa o LCD com suas instruções de fucionamento e adiciona aos registradores os endereços dos botoes,leds
initialize:
	movi r15, 0x30 #Seleciona função
	instr r15
	movi r15, 0x39 #Seleciona função
	instr r15
	movi r15, 0x14 #Ajuste de clock interno
	instr r15
	movi r15, 0x56 #Power/ICON/Contrast
	instr r15
	movi r15, 0x6d #Folower control
	instr r15
	movi r15, 0x0c #Liga o Display
	instr r15
	movi r15, 0x06 #Entra em modo de cursor
	instr r15
	movi r15, 0x01 #Limpa o Display
	instr r15

# Adicionando endereço de botoes, leds, aos registradores
	movi r12, buttons
	movi r4, esp #base do RS232
	movi r3, button0
	movi r13, button1
	movi r14, button2
	movi r16, button3
	ret

end:
	br end