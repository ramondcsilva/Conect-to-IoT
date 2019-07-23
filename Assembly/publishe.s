.text
.global main
main:
movi r4,0x2030 #base do RS232
nextpc r9
#br resertar_modulo
#nextpc r9
#br CWMODE
#nextpc r9
#br desconect
#nextpc r9
br Conectar_AP
#nextpc r9
#br Enable_Conection
#nextpc r9
#br Encerra_Conexao
#br  versionfirm
#br echo
#br TCP_Configure
#br end
/*IP:192.168.43.186*/

#/*
# Resertar Modulo ESP8266

# AT+GMR
versionfirm:
movi r5,65 #A
call sendMsg
#call delay
movi r5,84 #T
call sendMsg
#call delay
movi r5,43 #+
call sendMsg
#call delay
movi r5,71 #G
call sendMsg
#call delay
movi r5,77 #M
call sendMsg
#call delay
movi r5,82 #R
call sendMsg
#call delay
movi r5,13 #\r
call sendMsg
#call delay
movi r5,10 #\n
call sendMsg
#call delay
addi r9,r9,4
#call print
jmp r9

resertar_modulo:
movi r5,65 #A
call sendMsg
call delay
movi r5,84 #T
call sendMsg
call delay
movi r5,43 #+
call sendMsg
call delay
movi r5,82 #R
call sendMsg
call delay
movi r5,83 #S
call sendMsg
call delay
movi r5,84 #T
call sendMsg
call delay
movi r5,13 #\r
call sendMsg
call delay
movi r5,10 #\n
call sendMsg
call delay
addi r9,r9,4
jmp r9

echo:
movi r5,65 #A
call sendMsg
#call delay
movi r5,84 #T
call sendMsg
#call delay
movi r5,69 #E
call sendMsg
#call delay
movi r5,48 #0
call sendMsg
#call delay
movi r5,13 #\r
call sendMsg
#call delay
movi r5,10 #\n
call sendMsg
#call delay
addi r9,r9,4
call print
jmp r9

print:
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR
call GET_CHAR

ret
#*/


/*
AT+CWMODE_CUR=3
Existem três modos de funcionamento WiFi: Modo Estação, modo softAP e a coexistência do modo Estação e do modo softAP. Este comando é usado para adquirir o modo Wi-Fi existente 
ou para definir um modo WiFi personalizado.
*/
CWMODE:
movi r5,65 #A
call sendMsg
#call delay
movi r5,84 #T
call sendMsg
#call delay
movi r5,43 #+
call sendMsg
#call delay
movi r5,67 #C
call sendMsg
#call delay
movi r5,87 #W
call sendMsg
#call delay
movi r5,77 #M
call sendMsg
#call delay
movi r5,79 #O
call sendMsg
#call delay
movi r5,68 #D
call sendMsg
#call delay
movi r5,69 #E
call sendMsg
#call delay
movi r5,95 #_
call sendMsg
#call delay
movi r5,67 #C
call sendMsg
#call delay
movi r5,85 #U
call sendMsg
#call delay
movi r5,82 #R
call sendMsg
#call delay
movi r5,61 #=
call sendMsg
#call delay
movi r5,49 #1
call sendMsg
#call delay
movi r5,13 #\r
call sendMsg
#call delay
movi r5,10 #\n
call sendMsg
#call delay
addi r9,r9,4

a:
	br a
#br print

jmp r9
#*/


/*
AT + CWJAP_CUR - Conecte-se ao AP, não salve no Flash
*/
Conectar_AP:
movi r5,65 #A
call sendMsg
#call delay
movi r5,84 #T
call sendMsg
#call delay
movi r5,43 #+
call sendMsg
#call delay
movi r5,67 #C
call sendMsg
#call delay
movi r5,87 #W
call sendMsg
#call delay
movi r5,74 #J
call sendMsg
#call delay
movi r5,65 #A
call sendMsg
#call delay
movi r5,80 #P
call sendMsg
#call delay
movi r5,95 #_
call sendMsg
#call delay
movi r5,67 #C
call sendMsg
#call delay
movi r5,85 #U
call sendMsg
#call delay
movi r5,82 #R
call sendMsg
#call delay
movi r5,61 #=
call sendMsg
#call delay
movi r5,34 #"
call sendMsg
#call delay
movi r5,84 #T
call sendMsg
#call delay
movi r5,101 #e
call sendMsg
#call delay
movi r5,115 #s
call sendMsg
#call delay
movi r5,116 #t
call sendMsg
#call delay
movi r5,101 #e
call sendMsg
#call delay
movi r5,34 #"
call sendMsg
#call delay
movi r5,44 #,
call sendMsg
#call delay
movi r5,34 #"
call sendMsg
#call delay
movi r5,49 #1
call sendMsg
#call delay
movi r5,50 #2
call sendMsg
#call delay
movi r5,51 #3
call sendMsg
#call delay
movi r5,52 #4
call sendMsg
#call delay
movi r5,53 #5
call sendMsg
#call delay
movi r5,54 #6
call sendMsg
#call delay
movi r5,55 #7
call sendMsg
#call delay
movi r5,56 #8
call sendMsg
#call delay
movi r5,34 #"
call sendMsg
#call delay
movi r5,13 #\r
call sendMsg
#call delay
movi r5,10 #\n
call sendMsg
#call delay
addi r9,r9,4
b:
	br b

call print

jmp r9



/*
AT + CIPMUX - Habilita múltiplas conexões ou não
1. "AT + CIPMUX = 1" só pode ser definido quando a transmissão transparente estiver desativada
("AT + CIPMODE = 0")
2. Este modo só pode ser alterado após todas as conexões serem desconectadas.
3. Se o servidor TCP for iniciado, tem que apagar o servidor TCP primeiro, então a mudança para conexão única é permitida.

Enable_Conection:
movi r5,65 #A
call sendMsg
call delay
movi r5,84 #T
call sendMsg
call delay
movi r5,43 #+
call sendMsg
call delay
movi r5,67 #C
call sendMsg
call delay
movi r5,73 #I
call sendMsg
call delay
movi r5,80 #P
call sendMsg
call delay
movi r5,77 #M
call sendMsg
call delay
movi r5,85 #U
call sendMsg
call delay
movi r5,88 #X
call sendMsg
call delay
movi r5,61 #=
call sendMsg
call delay
movi r5,48 #0 se colocar 0 é 48 se 1 é 49
call sendMsg
call delay
movi r5,13 #\r
call sendMsg
call delay
movi r5,10 #\n
call sendMsg
call delay
addi r9,r9,4
jmp r9
*/

/*192.168.1.201*/
/*port: 1833*/

/*
O monitor do servidor será criado automaticamente quando o servidor for criado. Quando um cliente está conectado ao servidor, ele recebe uma conexão e recebe um ID.
*/
TCP_Configure:
movi r5,65 #A
call sendMsg
call delay
movi r5,84 #T
call sendMsg
call delay
movi r5,43 #+
call sendMsg
call delay
movi r5,67 #C
call sendMsg
call delay
movi r5,73 #I
call sendMsg
call delay
movi r5,80 #P
call sendMsg
call delay
movi r5,83 #S
call sendMsg
call delay
movi r5,69 #E
call sendMsg
call delay
movi r5,82 #R
call sendMsg
call delay
movi r5,86 #V
call sendMsg
call delay
movi r5,69 #E
call sendMsg
call delay
movi r5,82 #R
call sendMsg
call delay
movi r5,61 #=
call sendMsg
call delay
movi r5,49 #1
call sendMsg
call delay
movi r5,44 #,
call sendMsg
call delay
movi r5,56 #8
call sendMsg
call delay
movi r5,48 #0
call sendMsg
call delay
movi r5,13 #\r
call sendMsg
call delay
movi r5,10 #\n
call sendMsg
call delay
addi r9,r9,4
jmp r9

Encerra_Conexao:
movi r5,65 #A
call sendMsg
call delay
movi r5,84 #T
call sendMsg
call delay
movi r5,43 #+
call sendMsg
call delay
movi r5,67 #C
call sendMsg
call delay
movi r5,73 #I
call sendMsg
call delay
movi r5,80 #P
call sendMsg
call delay
movi r5,67 #C
call sendMsg
call delay
movi r5,76 #L
call sendMsg
call delay
movi r5,79 #O
call sendMsg
call delay
movi r5,83 #S
call sendMsg
call delay
movi r5,69 #E
call sendMsg
call delay
movi r5,13 #\r
call sendMsg
call delay
movi r5,10 #\n
call sendMsg
call delay
addi r9,r9,4
jmp r9

/*Wireless@aedes@192.168.1.200*/
/*192*/
# AT+CWQAP - Desconecta Access Point
desconect:
movi r5,65 #A
call sendMsg
call delay
movi r5,84 #T
call sendMsg
call delay
movi r5,43 #+
call sendMsg
call delay
movi r5,67 #C
call sendMsg
call delay
movi r5,87 #W
call sendMsg
call delay
movi r5,87 #Q
call sendMsg
call delay
movi r5,65 #A
call sendMsg
call delay
movi r5,80 #P
call sendMsg
call delay
movi r5,13 #\r
call sendMsg
call delay
movi r5,10 #\n
call sendMsg
call delay
addi r9,r9,4
jmp r9

delay:
	movi r8, 16000
	movi r1,0
loop:
	bgt r1,r8,endDelay
	addi r1,r1,1
	br loop
endDelay:
	ret

/*
A sub-rotina sendMsg tenta criar um caractere para a RS232UART. Ela é bem sucedida na fila TX FIFO da UART RS232, que determina pela leitura dos bits 23 a 16 do
registrador Control. Se não houver espaço, a sub-rotina pula a instrução stwio, não escrevendo o caractere para o RS232 UART.
*/
sendMsg:

	/* save any modified registers */
	subi sp, sp, 4 												/* reserve space on the stack */
	stw r6, 0(sp) 												/* save register */
	ldwio r6, 4(r4) 											/* read the RS232 UART Control register */
	andhi r6, r6, 0x00ff 										/* check for write space */
	beq r6, r0, END_PUT 										/* if no space, ignore the character */
	stwio r5, 0(r4) 											/* send the character */

END_PUT:
	
	/* restore registers */
	ldw r6, 0(sp)
	addi sp, sp, 4
	
	ret
/**
As sub-rotinas GET_CHAR são características do UR232UART,e retornam esse caractere no registro2. Se a fila RX FIFO da UART RS232 estiver vazia, ela retornará o caractere nulo "\ 0".
**/
GET_CHAR: 
	
	/* save any modified registers */
	subi sp, sp, 8 												/* reserve space on the stack */
	stw r5, 0(sp) 												/* save register */
	ldwio r2, 0(r4) 											/* read the RS232 UART Data register */
	andi r5, r2, 0x8000 										/* check if there is new data */
	bne r5, r0, RETURN_CHAR
	mov r2, r0 													/* if no new data, return ‘\0’ */

RETURN_CHAR:
	andi r5, r2, 0x00ff 										/* the data is in the least significant byte */
	mov r2, r5 													/* set r2 with the return value */

	/* restore registers */
	ldw r5, 0(sp)
	addi sp, sp, 8
	
	ret
end:
	br end