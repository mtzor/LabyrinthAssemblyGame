.data
instructions: .asciiz "Use w,a,s,d to move. Press E to find best solution.\n"
Labyrinth: .asciiz "Labyrinth:\n"
nextline: .asciiz "\n"
win:.asciiz "Winner Winner Chicken Dinner!"

map: .asciiz   "I.IIIIIIIIIIIIIIIIIII\nI....I....I.......I.I\nIII.IIIII.I.I.III.I.I\nI.I.....I..I..I.....I\nI.I.III.II...II.I.III\nI...I...III.I...I...I\nIIIII.IIIII.III.III.I\nI.............I.I...I\nIIIIIIIIIIIIIII.I.III\n@...............I..II\nIIIIIIIIIIIIIIIIIIIII\n"



	.align 0
	.space 242
	
temp: .align 0
	  .space 242
	  
currentMove: .align 0
			.space 1
			
cflag: .align 2
		.space 4
cdata: .align 0
		.space 1
.text 
.globl cdata
.globl cflag
.globl main
.globl instructions
.globl map
.globl temp
.globl currentMove

main:

li $s0,21  ##width
li $s1,11	##height
li $s5,242	##numberOfELements
li $s4,1	##PlayerPos
li $s2,1	##startX
li $s3,198	##EndX
li $s6,46

li $v0,4
la $a0,instructions ## printing instructions
syscall

#jal findExit
#jal findStart
#move $s2,$v0




#li $v0,1
#move $a0,$s2
#syscall

jal printLabyrinth

                #enabling bit 0 and bit 11 of register $12
				mfc0 $t0,$12
				li $t1, 0x801
				and $t0,$t0,$t1
				addi $t0,$t0,1
				mtc0 $t0,$12
				
				
				
while_loop_main:
                #Interupt enable bit 1 
				li $t0,0xffff0000
				lw $t1,0($t0)
				ori $t2,$t1,0x2
				sw $t2,0($t0)

				beq $s4,$s3, while_loop_end_main
				
				#initialising cflag=0
				la $t0,cflag
				li $t1,0			
				sw $t1,0($t0)
				
while_loop_cflag:
                 #if cflag =1 go out of while
				li $t1,1
				lw $t2,0($t0)
				bne $t2,$zero,while_loop_cflag_end
				
				j while_loop_cflag
while_loop_cflag_end:	

				#t9=cdata=current
				la $t1,cdata 
				lb $t9,0($t1)
				
				li $t0,0xffff0000
				lw $t1,0($t0)
				and $t2,$t1,0x0
				sw $t2,0($t0)
				
				addi $t7,$s0,1
#////////////MOVING UP///////////////////////////////////////////////////////////
first_conditionw: 
				 li $t1,87
                 bne $t9,$t1,second_conditionw      
                 j end_ifw
                         
second_conditionw: 
				 li $t1,119
                 bne $t9,$t1,end_if_2w      
                    
end_ifw:           
				la $t0,map
				sub $t1,$s4,$t7
				add $t2,$t0,$t1
				
				lb	$t3,0($t2)
				bne $t3,$s6,third_conditionw
				move $s4,$t1                   
                j end_if_2w
				
third_conditionw:
				la $t0,map
				sub $t1,$s4,$t7
				add $t2,$t0,$t1
				
				lb	$t3,0($t2)
				li $t4,64
				bne $t3,$t4,end_if_2w
				move $s4,$t1                  
                  
end_if_2w:

#////////////////MOVING LEFT////////////////////////////////////////////////////                  
                          
first_conditiona: 
				 li $t1,65
                 bne $t9,$t1,second_conditiona      
                 j end_ifa
                         
second_conditiona:  
				 li $t1,97
                 bne $t9,$t1,end_if_2a
        
end_ifa: 
				la $t0,map
				addi $t1,$s4,-1
				add $t2,$t0,$t1
				
				lb	$t3,0($t2)
				bne $t3,$s6,third_conditiona
				move $s4,$t1                   
                j end_if_2a
				
third_conditiona:
				la $t0,map
				addi $t1,$s4,-1
				add $t2,$t0,$t1
				
				lb	$t3,0($t2)
				li $t4,64
				bne $t3,$t4,end_if_2a
				move $s4,$t1  
                                  
end_if_2a:
                          
# ////////////////MOVING DOWN////////////////////////////////////////////////////                  
                          
first_conditions:  
				li $t1,83
                bne $t9,$t1,second_conditions      
                j end_ifs
                         
second_conditions:  
				li $t1,115
                bne $t9,$t1,end_if_2s
                        
end_ifs: 
				la $t0,map
				add $t1,$s4,$t7
				add $t2,$t0,$t1
				
				lb	$t3,0($t2)
				bne $t3,$s6,third_conditions
				move $s4,$t1                   
                j end_if_2s
                         
third_conditions:
				la $t0,map
				add $t1,$s4,$t7
				add $t2,$t0,$t1
				
				lb	$t3,0($t2)
				li $t4,64
				bne $t3,$t4,end_if_2s
				move $s4,$t1
                              
end_if_2s:    
   
 #////////////////MOVING RIGHT////////////////////////////////////////////////////                  
                          
first_conditiond: 
				li $t1,68
                bne $t9,$t1,second_conditiond      
                j end_ifd
                         
                         
second_conditiond: 
				li $t1,100
                bne $t9,$t1,end_if_2d
        
end_ifd: 
				la $t0,map
				addi $t1,$s4,1
				add $t2,$t0,$t1
				
				lb	$t3,0($t2)
				bne $t3,$s6,third_conditiond
				move $s4,$t1                   
                j end_if_2d
                         
third_conditiond:
				la $t0,map
				addi $t1,$s4,1
				add $t2,$t0,$t1
				
				lb	$t3,0($t2)
				li $t4,64
				bne $t3,$t4,end_if_2d
				move $s4,$t1
                               
end_if_2d: 

# ////////////////E SOLVING IT////////////////////////////////////////////////////                               
first_conditione: 
				li $t1,69
				
                bne $t9,$t1,second_conditione
				
				move $a0,$s2
                jal makeMove
				
				li $v0,10
				syscall
                         
second_conditione: 
				li $t1,101
				
                bne $t9,$t1,end_if_e
				
				move $a0,$s2
                jal makeMove
				
				li $v0,10
				syscall
                       
end_if_e:
        
				jal printLabyrinth
    
				j while_loop_main
        
while_loop_end_main:
					move $a0,$s2
					jal makeMove
				
                    li $v0,4
					la $a0,win
					syscall
					
                       
					li $v0,10
					syscall


################# usleep ###########################################################					
usleep:
				addi $sp,$sp,-8
				sw $t9,0($sp)
				sw $t8,4($sp)
				
				li $t9,0
				li $t8,20000
	   
for_usleep:    
			bgt $t9,$t8,for_usleep_end

			addi $t9,$t9,1
			   j for_usleep
			   
for_usleep_end:
				lw $t9,0($sp)
				lw $t8,4($sp)
				addi $sp,$sp,8
				
				jr $ra



################# PRINT LABIRYNTH ###########################################################
printLabyrinth:
				 addi $sp,$sp,-48
				 sw $s7,0($sp)
				 sw $t0,4($sp)
				 sw $t1,8($sp)
				 sw $t2,12($sp) 
				 sw $t3,16($sp)
				 sw $t4,20($sp)
				 sw $t5,24($sp)
				 sw $t6,28($sp)
				 sw $t7,32($sp)
				 sw $t8,36($sp)
				 sw $t9,40($sp)
				 sw $a0,44($sp)
				 
				 la $t7,map
				 la $t4,temp
				 
				 li $t3,0
				 li $t1,0
				  
				li $v0,4
				la $a0,Labyrinth ## print labyrinth
				syscall

				

for_loop1: 
			bge $t1,$s1,for_loop1_end 
            li $t2,0
			
for_loop2: 
				
				addi $s7,$s0,1
				bge $t2,$s7,for_loop2_end 

				bne $t3,$s4,else_label 
				
				add $t5,$t4,$t2 
				li $t6,80
				sb $t6 ,0($t5) # temp[T2]='P';
						
				j if_end3
	
else_label:
			add $t5,$t4,$t2
			 
			add $t8,$t7,$t3
			lb $t9,0($t8)#map[T3];
			sb $t9,0($t5)#temp[T2]=map[T3];
           
if_end3:
		addi $t3,$t3,1
		addi $t2,$t2,1
		  
		j for_loop2
			
for_loop2_end:
				addi $t5,$t2,1
				add $t6,$t5,$t4

				lb $zero,0($t6)#temp[T2+1]='\0';

				li $v0,4
				la $a0,temp
				syscall

				addi $t1,$t1,1 
           
            
				j for_loop1
for_loop1_end:
				
				 lw $s7,0($sp)
				 lw $t0,4($sp)
				 lw $t1,8($sp)
				 lw $t2,12($sp) 
				 lw $t3,16($sp)
				 lw $t4,20($sp)
				 lw $t5,24($sp)
				 lw $t6,28($sp)
				 lw $t7,32($sp)
				 lw $t8,36($sp)
				 lw $t9,40($sp)
				 lw $a0,44($sp)
				addi $sp,$sp,48
				jr $ra


               
##########################MAKEMOVE#####################################################################
 makeMove:  	la $t0,map
				li $t3,42
				li $t4,1
				li $t5,35
				li $t6,64
				li $t8,37
				
				addi $sp,$sp,-8
				sw $s7,0($sp)
				sw $ra,4($sp)
				
               
                move $s7,$a0
                
				bgtz $a0,secondif 
				li $v0,0
				
				lw $s7,0($sp)
				addi $sp,$sp,8
				jr $ra
     
 secondif:   
				blt $a0,$s5, endcondition
				li $v0,0

				lw $s7,0($sp)
				
				addi $sp,$sp,8
				jr $ra
     
 endcondition:

if_rec1:    	add $t1,$t0,$a0
				lb $t2,0($t1) #map[A0]

				bne $t2,$s6,if_rec1_end
				
				sb $t3,0($t1) #  map[A0]='*'
				
				sw $ra,4($sp)
				jal printLabyrinth
				lw $ra,4($sp)
				
				sw $ra,4($sp)
				jal usleep 
				lw $ra,4($sp)
				
                addi $a0,$a0,1
				
                sw $ra,4($sp)
                jal makeMove 
				lw $ra,4($sp)
				
                bne $v0,$t4,firstrecend
				add $t1,$t0,$s7
				sb $t5,0($t1)# map[S7]='#';
               
                sw $ra,4($sp)
				jal printLabyrinth
				lw $ra,4($sp)
				
				sw $ra,4($sp)
				jal usleep 
				lw $ra,4($sp)
				
                li $v0,1
				
				lw $s7,0($sp)
				
				addi $sp,$sp,8
				jr $ra
firstrecend:
				addi $t1,$s0,1
				add $a0,$s7,$t1
				
               
                sw $ra,4($sp)
                jal makeMove 
				lw $ra,4($sp)
				
				bne $v0,$t4,secondrecend
				add $t1,$t0,$s7
				sb $t5,0($t1)# map[S7]='#';
				
                sw $ra,4($sp)
				jal printLabyrinth
				lw $ra,4($sp)
				
				sw $ra,4($sp)
				jal usleep 
				lw $ra,4($sp)
				
                li $v0,1
				
				lw $s7,0($sp)
				
				addi $sp,$sp,8
				jr $ra
secondrecend:
                addi $a0,$s7,-1
				
               
                sw $ra,4($sp)
                jal makeMove 
				lw $ra,4($sp)
				
				bne $v0,$t4,thirdrecend
				add $t1,$t0,$s7
				sb $t5,0($t1)# map[S7]='#';
				
                sw $ra,4($sp)
				jal printLabyrinth
				lw $ra,4($sp)
				
				sw $ra,4($sp)
				jal usleep 
				lw $ra,4($sp)
				
                li $v0,1
				
				lw $s7,0($sp)
				
				addi $sp,$sp,8
				jr $ra
                          
thirdrecend:
                addi $t1,$s0,1
                sub $a0,$s7,$t1
				
               
                sw $ra,4($sp)
                jal makeMove 
				lw $ra,4($sp)
				
				bne $v0,$t4,fourthrecend
				add $t1,$t0,$s7
				sb $t5,0($t1)# map[S7]='#';
				
                sw $ra,4($sp)
				jal printLabyrinth
				lw $ra,4($sp)
				
				sw $ra,4($sp)
				jal usleep 
				lw $ra,4($sp)
				
                li $v0,1
				
				lw $s7,0($sp)
				addi $sp,$sp,8
				jr $ra
fourthrecend:
if_rec1_end:               
			add $t1,$t0,$a0
			lb $t7,0($t1) #map[A0]
			
			bne $t6,$t7,after_else #if (map[A0]!='@')goto after_else;
			
			add $t1,$t0,$s7
			sb $t8,0($t1) #map[S7]='%';
			
			sw $ra,4($sp)
		    jal printLabyrinth
			lw $ra,4($sp)
			
			sw $ra,4($sp)
			jal usleep 
			lw $ra,4($sp)
			
			li $v0,1
				
			lw $s7,0($sp)
			addi $sp,$sp,8
            jr $ra

 after_else:
			li $v0,0

			lw $s7,0($sp)
            addi $sp,$sp,8  
			jr $ra
			
#############FIND START#########################
findStart:

    li $t1,0
	la $t3,map
	li $t4,0
	addi $t7,$s0,1

for1:
      bgt $t1,$s1,for1_end 
      li $t2,0    
                
for2:
     bgt $t2,$s0,for2_end 
     mul $t4,$t1,$t7
     add $t4,$t4,$t2
	 add $t7,$t4,$t3
	 
     lb $t5,0($t7)	# map[(T1*S0+T2)] 
     bne $t5,$s6,if_end # if(map[(T1*S0+T2)]!=46)goto if_end;
     move $v0,$t4      #         S2=(T1*S0+T2);
      jr $ra      
	  
if_end:
       addi $t2,$t2,1          
       j for2
	   
for2_end:
	 addi $t6,$s1,-1
	 add $t1,$t1,$t6    ##T1+=(S1);
     j for1           
	 
for1_end:  
      
     li $t2,0    
	 la $t3,map 
for3:
       bge $t2,$s0,for3_end ##         if(T2>=S0)goto for3_end;
       li $t1,0          
                
for4:   bge $t1,$s1,for4_end  
		mul $t4,$t1,$t7
		add $t4,$t4,$t2
		add $t8,$t4,$t3
		
		lb $t5,0($t8)	# map[(T1*S0+T2)] 
		bne $t5,$s6,if2_end # if(map[(T1*S0+T2)]!=46)goto if_end;
		move $v0,$t4      #         S2=(T1*S0+T2);
		jr $ra          
                    
if2_end:
        addi $t1,$t1,1      
        j for4
		
for4_end:
		addi $t6,$s0,-1
		add $t2,$t2,$t6    ##T2+=(S0-1);
		j for3 
                
for3_end:  
		jr $ra			
			
