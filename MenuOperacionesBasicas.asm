org 100h ; Inicio de programa
 
include 'emu8086.inc' ;Incluye funciones de libreria emu8086
 
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
 

;Se declaran las variables y los mensajes  
.data 
suma db 2 dup (?) 
resta db 2 dup (?) 
multi db 2 dup (?)
divi db 2 dup (?)   


limite1 db 13,10,'------------------------------------------------------------------',13,10,'$' 
titulo1 db 13,10,'                  JESUS AMADO GOMEZ RENTERIA',13,10,'$'
titulo2 db 13,10, '          MENU DE OPERACIONES MATEMATICAS BASICAS',13,10,'$' 
titulo3 db 13,10, '                    ELIGE UNA OPCION                          ',13,10,'$'


texto db '1.- SUMA',13,10,'2.- RESTA ',13,10,'3.- MULTIPLICACION ',13,10,'4.- DIVISION ',13,10,'Para salir, Presione cualquier otra tecla',13,10,'$'
texto1 db 'SUMA DE DOS NUMEROS',13,10,'$'
texto2 db 'RESTA DE DOS NUMEROS',13,10,'$'
texto3 db 'MULTIPLICACION DE DOS NUMEROS',13,10,'$'    
texto4 db 'DIVISION DE DOS NUMEROS',13,10,'$'
limite2 db 13,10,'------------------------------------------------------------------',13,10,'$' 
 

;inicio
.code         
inicio:            
 mov ax,@data     ;Se llama a .data que se declaro en la parte de arriba
 mov ds,ax        ;Guardamos los datos en ds 
 
 lea dx,limite1   ;Imprimimos el mensaje de la variable limite1
 mov ah,9h
 int 21h  
  
 lea dx,titulo1   ;Imprimimos el mensaje de la variable titulo1
 mov ah,9h
 int 21h  
 
 lea dx,titulo2   ;Imprimimos el mensaje de la variable titulo2                                                      
 mov ah,9h
 int 21h 
 
  lea dx,titulo3   ;Imprimimos el mensaje de la variable titulo3                                                      
 mov ah,9h
 int 21h  
   
 
 
 lea dx,texto         ;Imprime la variable texto
 mov ah,9h
 int 21h  
 
 lea dx,limite2   ;Imprimimos el mensaje de la variable limite2
 mov ah,9h
 int 21h   
                      ;Llamado las funciones
 
 mov ah,08            ;Espera a que el usuario precione una tecla
 int 21h              ;Interrupcion para capturar en pantalla
 cmp al,49 
 

              
 je llamarSuma        ;Llama a la suma
 cmp al,50        
 je llamarResta       ;Llama a la resta
 cmp al,51         
 je llamarMultipli    ;Llama a la multiplicacion 
  cmp al,52         
 je llamarDivi        ;Llama a la division
 
 jmp fin

 fin:
 mov ax,4c00h       ;Funcion que termina el programa
 int 21h 

 llamarSuma:
 CALL SUMAPROC      ;Llama al procedimiento de suma
                                            
 llamarResta:
 CALL RESTAPROC     ;Llama  al procedimiento de resta

 llamarMultipli:
 CALL MULTIPROC     ;Llama  al procedimiento de multiplicacion
 
 llamarDivi:
 CALL DIVIPROC      ;Llama al procedimiento de division
                                                            
                                                            
              
 SUMAPROC PROC NEAR   ;Operacion de suma
 mov ah,0       ;Limpia el registro
 mov al,3h      ;Modo de texto
 int 10h
    
 lea dx,texto1 
 mov ah,9h
 int 21h  
 printn ""
 print "Ingrese el primer numero:"  ;Nos pide el primer numero
 call scan_num      ;scan_num almacena el valor en un arreglo 
 mov suma[0],cl  

 printn ""  
 print "Ingrese el segundo numero:" ;Nos pide el segundo numero
 call scan_num
 mov suma[1],cl   
    
 xor ax, ax   
 add al,suma[0]
 add al,suma[1] 
 printn "" 
 print "El resultado de la suma es:" 
 call print_num    ;print_num proceso que imprime valor 
 printn "" 
 CALL inicio       ;Llama al procedimiento de inicio para mostrar el menu
 RET               ;Retorna el proceso
SUMAPROC ENDP      ;Termina la operacion de suma


RESTAPROC PROC NEAR   ;Operacion la  resta
 mov ah,0
 mov al,3h
 int 10h
    
 lea dx,texto2  
 mov ah,9h
 int 21h  
 printn ""
 print "Ingrese el primer numero:"    ;Nos pide el primer numero
 call scan_num  
 mov resta[0],cl   

 printn ""  
 print "Ingrese el segundo numero:"   ;Nos pide el segundo numero
 call scan_num
 mov resta[1],cl
    
 ;Compara al numero mayor
 mov al,resta[0]    
 cmp al,resta[1] 
 jc mayordos
 jnz mayorprimero
      
RESTAPROC ENDP   ;Termina la operacion de resta

mayordos:   ;Resta si el numero mayora 2
    xor ax, ax 
    add al,resta[1] 
    sub al,resta[0]   
    printn "" 
    print "El resultado de la resta es:"       ;Resultado final
    call print_num 
              
    printn ""          
    CALL inicio
    RET 
.exit  
mayorprimero:  ;Resta si el numero es mayor a 1
    xor ax, ax 
    add al,resta[0] 
    sub al,resta[1]   
    printn "" 
    print "El resultado de la resta es:"      ;Resultado final
    call print_num  
    
    printn ""        
    CALL inicio
    RET
.exit


MULTIPROC PROC NEAR     ;Operacion de multplicacion
 mov ah,0
 mov al,3h
 int 10h  
   
 lea dx,texto3
 mov ah,9h
 int 21h 
 
 printn ""
 print "Ingrese el primer numero:"     ;Nos pide el primer numero
 call scan_num  
 mov multi[0],cl

 printn ""  
 print "Ingrese el segundo numero:"    ;Nos pide el segundo numero
 call scan_num        
 mov multi[1],cl
                   
 xor ax, ax 
 add al,multi[0] 
 mul multi[1]   
 printn "" 
 print "El resultado de la multiplicacion es:"  ;Resultado final
 call print_num
    
 printn "" 
  
 CALL inicio
 RET    
MULTIPROC ENDP                  ;Termina la operacion de multiplicacion


DIVIPROC PROC NEAR             ;Operacion la division
 mov ah,0
 mov al,3h
 int 10h   

 lea dx,texto4
 mov ah,9h
 int 21h 
 
 printn ""
 print "Ingrese el dividendo:"     ;Nos pide el primer numero
 call scan_num  
 mov divi[0],cl

 printn ""  
 print "Ingrese el divisor:"    ;Nos pide el segundo numero
 call scan_num        
 mov divi[1],cl
                   
 xor ax, ax 
 add al,divi[0] 
 div divi[1]   
 printn "" 
 print "El resultado de la division es:"  ;Resultado de la operacion
 call print_num 
              

 printn "" 
  
 CALL inicio
 RET    
DIVIPROC ENDP              ; Termina la operacion de division

end inicio       final del codigo   ;Fin del codigo del programa
