.data
.equ buttons, 0x2050
.equ esp, 0x2030

.equ button1, 0x1 #r3
.equ button2, 0x2 #r13
.equ button3, 0x4 #r14
.equ button4, 0x8 #r16
.equ button5, 0x10 #r17
.equ button6, 0x20 #r18
.equ button7, 0x40 #r19
.equ button8, 0xffffff80 #r20
.equ button9, 0x100 #r21
.equ button10, 0x200 #r22
.equ button11, 0x400 #r23

#Macro usado para instrucoes do lcd, facilita a chamada
.macro instr databits
	movi r1, 0 # Adiciona 0 ao registrador r1 para o Modulo LCD (Custom Instruction) reconhecer que ser� dados para instru��es 
	custom 0, r0, r1, \databits  # custom index, result, dataA, dataB   custom index, data result, data instr or write, databyte chain 
.endm
#Macro usado para dados no lcd, facilita a chamada
.macro data databits
	movi r1, 1 # Adiciona 1 ao registrador r1 para o Modulo LCD (Custom Instruction) reconhecer que ser� dados para escrita 
	custom 0, r0, r1, \databits
.endm

.text
.global main

/*IP local:192.168.43.11 , End MAC: 18:FE:34:DA:55:E0*/

/*
topico: SDTopic
porta: 1883

*/


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
	beq r11, r3, echoMod      		#OK 1
	beq r11, r13, clearDisplay		#OK 2
	beq r11, r14, chooseMod 		#OK 3
	beq r11, r16, enableConnect   	#OK 4
	beq r11, r17, connectAP     	#OK 5
	beq r11, r18, tcpConnect  		#OK 6
	beq r11, r19, mqttConnection   	#   7
	beq r11, r20, mqttPublisher		#   8

tcpStatus:

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
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,85 #U
	call sendChar
	call delay
	movi r5,83 #S
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


clearDisplay:
  	nextpc r9
  	br print
  	br menu

# Resertar Modulo ESP8266
reset:
	movi r5,65 #A
	call sendChar
	movi r5,84 #T
	call sendChar
	movi r5,43 #+
	call sendChar
	movi r5,82 #R
	call sendChar
	movi r5,83 #S
	call sendChar
	movi r5,84 #T
	call sendChar
	movi r5,13 #\r
	call sendChar
	movi r5,10 #\n
	call sendChar
	call delay

	nextpc r9
	br print
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
	call delay
	call getChar
	call delay	
	call getChar
	call delay
	call getChar
	call delay
	call getChar
	call delay	
	call getChar
	call delay	
	call getChar
	call delay
	call getChar
	call delay	
	call getChar
	call delay
	call getChar
	call delay
	call getChar
	call delay
	call getChar
	call delay
	call getChar
	call delay
	call getChar
	call delay	
	call getChar
	call delay	
	call getChar
	call delay

	movi r15, 0xc0 # move para 2 linha
	instr r15

	call getChar
	call delay
	call getChar
	call delay	
	call getChar
	call delay
	call getChar
	call delay
	call getChar
	call delay	
	call getChar
	call delay	
	call getChar
	call delay
	call getChar
	call delay	
	call getChar
	call delay
	call getChar
	call delay
	call getChar
	call delay
	call getChar
	call delay
	call getChar
	call delay
	call getChar
	call delay	
	call getChar
	call delay	
	call getChar
	call delay


	addi r9, r9, 4
	#movi r15, 0xc0 # move para 2 linha
	#instr r15
	jmp r9	
	#br menu

/*
AT+chooseMod_CUR=1
Existem tr�s modos de funcionamento WiFi: Modo Esta��o, modo softAP e a coexist�ncia do modo Esta��o e do modo softAP. Este comando � usado para adquirir o modo Wi-Fi existente 
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
AT + CWJAP_CUR - Conecte-se ao AP, n�o salve no Flash
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
AT + CIPMUX - Habilita m�ltiplas conex�es ou n�o
1. "AT + CIPMUX = 1" s� pode ser definido quando a transmiss�o transparente estiver desativada
("AT + CIPMODE = 0")
2. Este modo s� pode ser alterado ap�s todas as conex�es serem desconectadas.
3. Se o servidor TCP for iniciado, tem que apagar o servidor TCP primeiro, ent�o a mudan�a para conex�o �nica � permitida.
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
	movi r5,48 #0 se colocar 0 � 48 se 1 � 49
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

tcpPing:
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
	movi r5,49 #1
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

	nextpc r9
	br print
	br menu

tcpConnect:
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
	movi r5,49 #1
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

	nextpc r9
	br print
	br menu

/*
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

	nextpc r9
	br print
	br menu

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
	
	nextpc r9
	br print
	br menu
*/

mqttConnection:
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
	movi r5,78 #N
	call sendChar
	call delay
	movi r5,68 #D
	call sendChar
	call delay
	movi r5,61 #=
	call sendChar
	call delay
	movi r5,49 #1
	call sendChar
	call delay
	movi r5,53 #5
	call sendChar
	call delay
	movi r5,13 #\r
	call sendChar
	call delay
	movi r5,10 #\n
	call sendChar
	call delay
	# CONTROLE + FLAG FIXED HEADER
	
	movi r5,16 #Controle + FLAG
	call sendChar
	call delay
	movi r5,12 #VARIABLE + PAYLOAD
	call sendChar
	call delay

 	# VARIABLE HEADER
	movi r5,0 # MSB
	call sendChar
	call delay
	movi r5,4 # LSB
	call sendChar
	call delay
	movi r5,77 #M
	call sendChar
	call delay
	movi r5,81 #Q
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,84 #T
	call sendChar
	call delay
	movi r5,13 #\r
	call sendChar
	call delay

	movi r5,4 #Versao PROTOCOLO
	call sendChar
	call delay
	movi r5,6 #FLAG
	call sendChar
	call delay
	movi r5,0 #Keep Alive MSB
	call sendChar
	call delay
	movi r5,120 #Keep Alive LSB
	call sendChar


# PAYLOAD
	movi r5,0 #Tamanho id Cliente MSB
	call sendChar
	call delay	
	movi r5,1 #Tamanho id Cliente LSB
	call sendChar
	call delay

	movi r5,65 #Cliente
	call sendChar
	call delay
	movi r5,13 #\r
	call sendChar
	call delay

	nextpc r9
	br print
	br menu	


mqttPublisher:
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
	movi r5,78 #N
	call sendChar
	call delay
	movi r5,68 #D
	call sendChar
	call delay
	movi r5,61 #=
	call sendChar
	call delay
	movi r5,49 #1
	call sendChar
	call delay
	movi r5,56 #8
	call sendChar
	call delay
	movi r5,13 #\r
	call sendChar
	call delay
	movi r5,10 #\n
	call sendChar
	call delay


	# FIXED HEADER
	movi r5,48 # CONTROL E FLAG
	call sendChar
	call delay
	movi r5,14 # Tamanho da mensagem TOTAL
	call sendChar
	call delay
	

	# VARIABLE HEADER UTF-8
	movi r5,0 	# Tamanho do Topico MSB
	call sendChar
	call delay
	movi r5,7 	# Tamanho do Topico LSB
	call sendChar
	call delay
	movi r5,83  #S
	call sendChar
	call delay
	movi r5,68  #D
	call sendChar
	call delay
	movi r5,84  #T
	call sendChar
	call delay
	movi r5,111 #o
	call sendChar
	call delay
	movi r5,112 #p
	call sendChar
	call delay
	movi r5,105 #i
	call sendChar
	call delay
	movi r5,99  #c
	call sendChar
	call delay
	movi r5,13 #\r
	call sendChar
	call delay
	movi r5,67  #C
	call sendChar
	call delay
	movi r5,104 #h
	call sendChar
	call delay
	movi r5,101 #e
	call sendChar
	call delay
	movi r5,103 #g
	call sendChar
	call delay
	movi r5,117 #u
	call sendChar
	call delay
	movi r5,101 #e
	call sendChar
	call delay
	movi r5,105 #i
	call sendChar
	call delay
	movi r5,13 #\r
	call sendChar
	call delay

	nextpc r9
	br print
	br menu
 # Tamanho das coisas, e uso do /n /r
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
A sub-rotina sendChar tenta criar um caractere para a RS232UART. Ela � bem sucedida na fila TX FIFO da UART RS232, que determina pela leitura dos bits 23 a 16 do
registrador Control. Se n�o houver espa�o, a sub-rotina pula a instru��o stwio, n�o escrevendo o caractere para o RS232 UART.
*/
sendChar:
	/* save any modified registers */
	subi sp, sp, 4 							/* reserve space on the stack */
	stw r6, 0(sp) 							/* save register */
	ldwio r6, 4(r4) 						/* read the RS232 UART Control register */
	andhi r6, r6, 0x00ff 					/* check for write space */
	beq r6, r0, endPut 						/* if no space, ignore the character */
	stwio r5, 0(r4) 						/* send the character */

endPut:
	/* restore registers */
	ldw r6, 0(sp)
	addi sp, sp, 4
	
	ret
/**
As sub-rotinas getChar s�o caracter�sticas do UR232UART,e retornam esse caractere no registro2. Se a fila RX FIFO da UART RS232 estiver vazia, ela retornar� o caractere nulo "\ 0".
**/
getChar: 
	/* save any modified registers */
	subi sp, sp, 8								/* reserve space on the stack */
	stw r5, 0(sp) 								/* save register */
	ldwio r2, 0(r4) 							/* read the RS232 UART Data register */
	andi r5, r2, 0x8000 						/* check if there is new data */
	bne r5, r0, returnChar
	mov r2, r0 									/* if no new data, return �\0� */

returnChar:
	andi r5, r2, 0x00ff 						/* the data is in the least significant byte */
	mov r2, r5 									/* set r2 with the return value */
	/* restore registers */  
	ldw r5, 0(sp)
	addi sp, sp, 8
	beq r5, r0, retorno
	beq r2, r0, retorno
	data r2
	ret

retorno:
	ret
# Inicializa o LCD com suas instru��es de fucionamento e adiciona aos registradores os endere�os dos botoes,leds
initialize:
	movi r15, 0x30 #Seleciona fun��o
	instr r15
	movi r15, 0x39 #Seleciona fun��o
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

# Adicionando endere�o de botoes, leds, aos registradores
	movi r12, buttons
	movi r4, esp #base do RS232
	movi r3, button1
	movi r13, button2
	movi r14, button3
	movi r16, button4
	movi r17, button5
	movi r18, button6
	movi r19, button7
	movi r20, button8
	movi r21, button9
	movi r22, button10
	ret

end:
	br end