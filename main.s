.data
	numar_cerinta: 	.long 0
	numar_noduri:	.long 0
	nod_sursa:	.long 0
	nod_destinatie: .long 0
	lungime_drum:	.long 0
	nr_muchii:	.long 0
	x:		.long 0
	i:		.long 0
	j:		.long 0
	k:		.long 0
	var_stocare:	.long 0
	rezultat:	.long 0
	
	suma1:		.long 0
	suma2:		.long 0
	
	scan_str: 	.asciz "%ld"
	print_str: 	.asciz "%ld "
	print_fara_space: .asciz "%ld"
	endl_str:	.asciz "\n"
	test_str:	.asciz "b"
	
	nr_legaturi: 	.space 100
	mat:		.space 1000
	mat_2:		.space 1000
	mat_rez:	.space 1000
	
	
	
.text
	matrix_mult:
		pushl %ebp
		mov %esp, %ebp
		
		#alocare spatiu variabile locale 
		
		subl $12, %esp		
		movl $0, -4(%ebp)	# -4(%ebp) <=> i
		movl $0, -8(%ebp)	# -8(%ebp) <=> j
		movl $0, -12(%ebp)	# -12(%ebp) <=> k
		
		#restaurarea registrilor 
		
		pushl %ebx
		pushl %ebp
		pushl %esi
		pushl %edi
		
		#movl 8(%ebp), %edi -> adresa mat
		#movl 12(%ebp), %edi -> adresa mat_2
		#movl 16(%ebp), %edi -> adresa mat_rez
		
		#for(int i=0; i<n; i++)
		#	for(int j=0; j<n; j++)
		#		for(int k=0; k<n; k++)
		#			rez_mat[i][j] += mat[i][k] * mat_2[k][j];
	
		movl $0, -4(%ebp)
		movl $0, -8(%ebp)
		movl $0, -12(%ebp)
		
		
		
		
		for_1.6:
			
			#if i == numar_noduri stop
		
			movl -4(%ebp), %eax
			movl 20(%ebp) , %ebx
			cmp %eax, %ebx
			je finish
			
			
			movl $0, -8(%ebp)
			
			for_2.6:
				
				#aici se mareste i in cazul in care j == numar_noduri
			
				movl -4(%ebp), %eax
				inc %eax
				movl %eax, -4(%ebp)
				
				#if j == numar_noduri
				
				movl -8(%ebp), %eax
				movl 20(%ebp), %ebx
				cmp %eax, %ebx
				je for_1.6
				
				#aici se scade i-ul marit anterior
				
				movl -4(%ebp), %eax
				dec %eax
				movl %eax, -4(%ebp)
				
				movl $0, -12(%ebp)
				
				for_3.6:
				
					#aici se mareste j in cazul in care k == numar_noduri
				
					movl -8(%ebp), %eax
					inc %eax
					movl %eax, -8(%ebp)
					
					#if k == numar_noduri
					
					movl -12(%ebp), %eax
					movl 20(%ebp), %ebx
					cmp %eax, %ebx
					je for_2.6
					
					#aici se scade j-ul marit anterior
					
					movl -8(%ebp), %eax
					dec %eax
					movl %eax, -8(%ebp)
					
					
						#calculare indice mat[i][k]
						
						movl -4(%ebp), %eax
						movl 20(%ebp), %ebx
						mul %ebx
						addl -12(%ebp), %eax
						movl %eax, suma1
							
						#calculare indice mat_2[k][j]
						
						movl -12(%ebp), %eax
						movl 20(%ebp), %ebx
						mul %ebx
						add -8(%ebp), %eax
						movl %eax, suma2
						
						
						movl 8(%ebp), %edi
						movl suma1, %ebx
						movl (%edi, %ebx, 4), %eax
						
						movl 12(%ebp), %edi
						movl suma2, %ecx
						movl (%edi, %ecx, 4), %edx
						
						movl %edx, %ebx
						imul %ebx
						movl %eax, suma1
						
						#calculare indice mat_rez[i][j]
						
						movl -4(%ebp), %eax
						movl 20(%ebp), %ebx
						mul %ebx
						add -8(%ebp), %eax
						
						movl 16(%ebp), %edi
						movl (%edi, %eax, 4), %ecx
						movl %ecx, suma2
						
						movl suma1, %eax
						movl suma2, %ebx
						addl %ebx, %eax
						movl %eax, suma1
						
						
						movl -4(%ebp), %eax
						movl 20(%ebp), %ebx
						mul %ebx
						add -8(%ebp), %eax
						
						movl suma1, %ecx
						movl %ecx, (%edi, %eax, 4)
						
						
						
							
						
						
					#marire k
				
					movl -12(%ebp), %eax
					inc %eax
					movl %eax, -12(%ebp)
					
					jmp for_3.6
					
					
		
		finish:
		
			
		
			#restaurarea registrilor
		
			popl %edi
			popl %esi
			popl %ebp
			popl %ebx
		
			addl $12, %esp
			
			popl %ebp
			ret
.global main

	main:
		#citire nr. cerinta
		
		pushl $numar_cerinta
		pushl $scan_str
		call scanf
		popl %edx
		popl %ebx

		#citire nr. noduri
		
		pushl $numar_noduri
		pushl $scan_str
		call scanf
		popl %edx
		popl %ebx
		
		
		mov $0, %ecx
		lea nr_legaturi, %edi
		
	citire_nr_legaturi:
		
		mov numar_noduri, %eax
		cmp %eax, %ecx
		je construire_matrice
		
		#citire element in x
		
		pusha
		pushl $x
		pushl $scan_str
		call scanf
		popl %edx
		popl %ebx
		popa
		
		#mutare x in vectorul nr_legaturi
		
		mov x, %eax
		movl %eax, (%edi, %ecx, 4)
		inc %ecx
		jmp citire_nr_legaturi
	
	construire_matrice:
		
		lea mat, %edi
		movl $0, i
		movl $0, j
		
		for_1:
			
			#if i == numar_legaturi stop
			#else parcurge urmatoarea linie
			
			movl i, %eax
			movl numar_noduri, %ebx
			cmp %eax, %ebx
			je citire_legaturi
			
			movl $0, j
			
			for_2:
			
				#aici se mareste i in cazul in care j == numar_noduri
			
				movl i, %eax
				inc %eax
				movl %eax, i
				
				#if j == numar_noduri
				
				movl j, %eax
				movl numar_noduri, %ebx
				cmp %eax, %ebx
				je for_1
				
				#aici se scade i-ul marit anterior
				
				movl i, %eax
				dec %eax
				movl %eax, i
				
				#calculare destinatie
				
				movl i, %eax
				movl numar_noduri, %ebx
				mul %ebx
				add j, %eax
				
				movl $0, (%edi,%eax, 4)
				
				
				#marire j
				
				movl j, %eax
				inc %eax
				movl %eax, j
				
				jmp for_2
		
		
		
				
				
		
	citire_legaturi:
		
		movl $0, %ecx
		lea nr_legaturi, %edi
		movl (%edi, %ecx, 4), %eax
		movl %eax, nr_muchii
		movl $0, i
		
		for_1.1:
			
			#if i == nr_noduri stop
			#else continua
			
			movl i, %eax
			movl numar_noduri, %ebx
			cmp %eax, %ebx
			je alegere_cerinta
			
			lea nr_legaturi, %edi
			movl $0, j
			movl i, %ecx
			movl (%edi, %ecx, 4), %eax
			movl %eax, nr_muchii
			
			for_2.1:
			
				#aici se mareste i in cazul in care j == nr_muchii
			
				movl i, %eax
				inc %eax
				movl %eax, i
				
				#if j == nr_muchii
				
				movl j, %eax
				movl nr_muchii, %ebx
				cmp %eax, %ebx
				je for_1.1
				
				#aici se scade i-ul marit anterior
				
				movl i, %eax
				dec %eax
				movl %eax, i
				
				
				#citire 
					
				pushl $x
				pushl $scan_str
				call scanf
				popl %edx
				popl %ebx
					
				#mat[i][x]=1
				
				lea mat, %edi
				movl i, %eax
				movl numar_noduri, %ebx
				mul %ebx
				add x, %eax
				
				movl $1, (%edi, %eax, 4)
				
				
				
				#marire j
				
				movl j, %eax
				inc %eax
				movl %eax, j
				
				jmp for_2.1
				
				
	alegere_cerinta:
		
		movl numar_cerinta, %eax
		movl $1, %ebx
		cmp %eax, %ebx
		je afisare_matrice
		
		movl numar_cerinta, %eax
		movl $2, %ebx
		cmp %eax, %ebx
		je citire_cerinta_2
		
	afisare_matrice:
	
		lea mat, %edi
		movl $0, i
		movl $0, j
		
		for_1.2:
			
			#if i == numar_legaturi stop
			#else parcurge urmatoarea linie
			
			movl i, %eax
			movl numar_noduri, %ebx
			cmp %eax, %ebx
			je et_flush
			
			movl $0, j
			
			for_2.2:
			
				#aici se mareste i in cazul in care j == numar_noduri
			
				movl i, %eax
				inc %eax
				movl %eax, i
				
				#if j == numar_noduri
				
				movl j, %eax
				movl numar_noduri, %ebx
				cmp %eax, %ebx
				je for_1.2
				
				#aici se scade i-ul marit anterior
				
				movl i, %eax
				dec %eax
				movl %eax, i
				
				#calculare destinatie
				
				movl i, %eax
				movl numar_noduri, %ebx
				mul %ebx
				add j, %eax
				
				#print element
				
				pushl (%edi, %eax, 4)
				pushl $print_str
				call printf
				popl %edx
				popl %ebx
				
				
				#marire j
				
				movl j, %eax
				inc %eax
				movl %eax, j
				
				
				
				jmp for_2.2
				
	et_flush:
	
		pushl $0
		call fflush
		popl %ebx
		jmp et_exit
		
	citire_cerinta_2:
		
		#citire lungime drum
		
		pushl $lungime_drum
		pushl $scan_str
		call scanf
		popl %edx
		popl %ebx
		
		#citire nod sursa
		
		pushl $nod_sursa
		pushl $scan_str
		call scanf
		popl %edx
		popl %ebx
		
		#citire nod destinatie
		
		pushl $nod_destinatie
		pushl $scan_str
		call scanf
		popl %edx
		popl %ebx
	
	copiere_matrice:
		
		lea mat, %edi
		movl $0, i
		movl $0, j
		
		for_1.3:
			
			#if i == numar_legaturi stop
			#else parcurge urmatoarea linie
			
			movl i, %eax
			movl numar_noduri, %ebx
			cmp %eax, %ebx
			je ridicare_matrice
			
			movl $0, j
			
			for_2.3:
			
				#aici se mareste i in cazul in care j == numar_noduri
			
				movl i, %eax
				inc %eax
				movl %eax, i
				
				#if j == numar_noduri
				
				movl j, %eax
				movl numar_noduri, %ebx
				cmp %eax, %ebx
				je for_1.3
				
				#aici se scade i-ul marit anterior
				
				movl i, %eax
				dec %eax
				movl %eax, i
				
				#calculare destinatie
				
				movl i, %eax
				movl numar_noduri, %ebx
				mul %ebx
				add j, %eax
				
				#copiere element 
				
				lea mat, %edi
				movl (%edi, %eax, 4), %ebx
				lea mat_2, %edi
				movl %ebx, (%edi, %eax, 4)
				lea mat_rez, %edi
				movl %ebx, (%edi, %eax, 4)
				
				
				#marire j
				
				movl j, %eax
				inc %eax
				movl %eax, j
				
				
				jmp for_2.3
				
				
	ridicare_matrice:
	
		mov $0, %ecx
	
		loop:
			#verific daca s-a ridicat matricea la puterea lungime_drum
			inc %ecx
			movl lungime_drum, %eax
			cmp %eax, %ecx
			je afisare_matrice_3
			
		
			mov_mat_rez_mat2:
				lea mat, %edi
				movl $0, i
				movl $0, j
				
				for_1.4:
					
					#if i == numar_legaturi stop
					#else parcurge urmatoarea linie
					
					movl i, %eax
					movl numar_noduri, %ebx
					cmp %eax, %ebx
					je resetare_matrice
					
					movl $0, j
					
					for_2.4:
					
						#aici se mareste i in cazul in care j == numar_noduri
					
						movl i, %eax
						inc %eax
						movl %eax, i
						
						#if j == numar_noduri
						
						movl j, %eax
						movl numar_noduri, %ebx
						cmp %eax, %ebx
						je for_1.4
						
						#aici se scade i-ul marit anterior
						
						movl i, %eax
						dec %eax
						movl %eax, i
						
						#calculare destinatie
						
						movl i, %eax
						movl numar_noduri, %ebx
						mul %ebx
						add j, %eax
						
						#copiere element 
						
						lea mat_rez, %edi
						movl (%edi, %eax, 4), %ebx
						lea mat_2, %edi
						movl %ebx, (%edi, %eax, 4)
						
						
						#marire j
						
						movl j, %eax
						inc %eax
						movl %eax, j
						
						
						jmp for_2.4
		resetare_matrice:
		
			lea mat_rez, %edi
			movl $0, i
			movl $0, j
			
			for_1.7:
				
				#if i == numar_legaturi stop
				#else parcurge urmatoarea linie
				
				movl i, %eax
				movl numar_noduri, %ebx
				cmp %eax, %ebx
				je apelare
				
				movl $0, j
				
				for_2.7:
				
					#aici se mareste i in cazul in care j == numar_noduri
				
					movl i, %eax
					inc %eax
					movl %eax, i
					
					#if j == numar_noduri
					
					movl j, %eax
					movl numar_noduri, %ebx
					cmp %eax, %ebx
					je for_1.7
					
					#aici se scade i-ul marit anterior
					
					movl i, %eax
					dec %eax
					movl %eax, i
					
					#calculare destinatie
					
					movl i, %eax
					movl numar_noduri, %ebx
					mul %ebx
					add j, %eax
					
					#copiere element 
					
					movl $0, (%edi, %eax, 4)
					
					
					#marire j
					
					movl j, %eax
					inc %eax
					movl %eax, j
					
					jmp for_2.7
				
		apelare:
	
			
			
			movl %ecx, var_stocare
			
			
			pushl numar_noduri
			pushl $mat_rez
			pushl $mat_2
			pushl $mat
		et_1:
			call matrix_mult
		et_2:
			popl %ebx
			popl %ebx
			popl %ebx
			popl %ebx
			
			
			movl var_stocare, %ecx
			
			jmp loop
			
	afisare_matrice_3:
	
	
		lea mat_rez, %edi
		
		movl nod_sursa, %eax
		movl numar_noduri, %ebx
		mul %ebx
		add nod_destinatie, %eax
		
		#afisare rezultat
		
		pushl (%edi, %eax, 4)
		pushl $print_fara_space
		call printf
		popl %edx
		popl %ebx
		
		jmp et_flush
		
		
			
	et_exit:
	
		mov $1, %eax
		xor %ebx, %ebx
		int $0x80
		
		
		
		
		
		
		
		
		
		
		
		
		