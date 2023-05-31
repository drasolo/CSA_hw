.data

cerinta: .space 4
n: .space 4
x: .space 4
inde: .space 4
contor: .space 4
lungime: .space 4
sursa: .space 4
destinatie: .space 4
v: .space 400
matrix: .space 40000
matrixx: .space 40000
matrixrezult: .space 40000
coloana: .space 4
linie: .space 4
formatread: .asciz "%ld"
formatprint: .asciz "%ld "
endlprint: .asciz "\n"

.text

#matrix_mult(m1, m2, mres, n)

matrix_mult:

pushl %ebp
movl %esp, %ebp

mov $0,%ebx
pushl $0
pushl $0
pushl $0
pushl $0
pushl $0
pushl $0

# -20(%ebp) = m2[k][j]
# -16(%ebp) = m1[i][k]
# -12(%ebp) = k
# -8(%ebp) = j
# -4(%ebp) = i

# 8(%ebp) = m1
# 12(%ebp) = m2
# 16(%ebp) = mres
# 20(%ebp) = n

movl 20(%ebp),%eax

jmp for

incfor:
incl -4(%ebp)              #i++
movl $0,-8(%ebp)            #j=0

for:
mov -4(%ebp),%ecx
cmp 20(%ebp),%ecx        #i<n?
je return

jmp for2

incfor2:
incl -8(%ebp)            #j++
movl $0,-12(%ebp)         #k=0

for2:
mov -8(%ebp),%ecx
cmp 20(%ebp),%ecx       #j<n?
je incfor

jmp for3
#acum parcurgem m1 pe linia i si m2 pe linia j

incfor3:
incl -12(%ebp)

for3:

mov -12(%ebp),%ecx
cmp 20(%ebp),%ecx      #k<n?
je incfor2

#acum sa accesam m1[i][k] m2[k][j] si sa punem in m3[i][j]

xor %edx,%edx
xor %eax,%eax
IAMA:
movl 20(%ebp),%eax
movl -4(%ebp),%ebx
mul %ebx                                      # %eax = n*i
addl -12(%ebp),%eax                           # %eax = n*i+k

mov %eax,%ecx
movl 8(%ebp),%edi
movl (%edi,%ecx,4),%eax                       # -16(%ebp) = m1[i][k]
movl %eax,-16(%ebp) 

xor %edx,%edx
movl 20(%ebp),%eax
movl -12(%ebp),%ebx
mul %ebx                                     # %eax = n*k
addl -8(%ebp),%eax                           # %eax = n*k+j

mov %eax,%ecx
movl 12(%ebp),%edi
movl (%edi,%ecx,4),%eax               # -20(%ebp) = m2[i][k]
movl %eax,-20(%ebp)

xor %edx,%edx
mov -16(%ebp),%eax
mov -20(%ebp),%ebx
mul %ebx                   
mov %eax,-20(%ebp)          # %edx = m1[i][k] * m2[k][j]

movl 20(%ebp),%eax
movl -4(%ebp),%ebx
mul %ebx
addl -8(%ebp),%eax          # %eax = n*i+j

movl 16(%ebp),%edi
movl (%edi,%eax,4),%ecx
addl -20(%ebp),%ecx 

STOP:

movl %ecx,(%edi,%eax,4)       # m3[i][j] += m1[i][k] * m2[k][j]

jmp incfor3



return:


popl %ebx
popl %ebx
popl %ebx
popl %ebx
popl %ebx
popl %ebx
popl %ebp
ret

.global main

main:

push $cerinta
push $formatread
call scanf
pop %eax
pop %eax

push $n
push $formatread
call scanf
pop %eax
pop %eax

lea v,%edi

xor %ecx,%ecx

citirevector:

cmp n,%ecx
je eusunt

# citesc cate o valoare a vectorului

pusha
push $x
push $formatread
call scanf
pop %eax
pop %eax
popa

dupacitire:

# pun valoarea respectiva in vector

mov x,%eax
lea v,%edi
mov %eax, (%edi,%ecx,4)

inc %ecx
jmp citirevector

# xorez ecx ca sa fie 0 inainte de citire matrice

eusunt:
xor %ecx,%ecx
dec %ecx

liniimatrice:

inc %ecx
cmp %ecx,n # n se refera la ce nod sunt
je vfcerinta

# mut in x cate noduri are legate si fol "contor" ca si counter

lea v, %edi
mov (%edi,%ecx,4),%eax
mov %eax,x
xor %ebx,%ebx
mov %ebx,contor

faurirematrice:

mov contor,%ebx
cmp x,%ebx
je liniimatrice


pusha
push $inde
push $formatread
call scanf
pop %eax
pop %eax
popa

iasavedem:


mov %ecx,%ebx
mov n,%eax
mul %ebx
addl inde,%eax
lea matrix,%edi
movl $1,(%edi,%eax,4)
lea matrixx,%edi
movl $1,(%edi,%eax,4)

incl contor
jmp faurirematrice

vfcerinta:
xor %ecx,%ecx
movl %ecx,inde
mov $1,%eax
cmp cerinta,%eax
je afisarematrice

mov $2,%eax
cmp cerinta,%eax
je nrdrumuri


incrementareperversa:
inc %ecx
movl $0,inde

afisarematrice:

cmp n,%ecx
je et_exit

 parcurgcoloane:
 movl inde,%ebx
 cmp n,%ebx
 je incrementareperversa
 
 #aici afisez
 xor %edx,%edx
 lea matrix,%edi
 mov n,%eax
 mov %ecx,%ebx
 mul %ebx
 addl inde,%eax
 
 mov (%edi,%eax,4),%ebx
 mov %ebx,x

 inaintede:
 
 pusha
 push x
 push $formatprint
 call printf
 pop %eax
 pop %eax
 popa
 
 pusha
 push $0
 call fflush
 pop %eax
 popa
 
 
 incl inde
 jmp parcurgcoloane

nrdrumuri:

push $lungime
push $formatread
call scanf
pop %eax
pop %eax

push $sursa
push $formatread
call scanf
pop %eax
pop %eax

push $destinatie
push $formatread
call scanf
pop %eax
pop %eax

xor %ecx,%ecx
mov %ecx,contor
mov $1,%eax

inmultimmatrici:


pushl n
pushl $matrixrezult
pushl $matrixx
pushl $matrix
call matrix_mult
pop %eax
pop %eax
pop %eax
pop %eax

incl contor

mov contor,%ecx
cmp lungime,%ecx
je afisajlungime1

salutamici:

pushl n
pushl $matrixx
pushl $matrixrezult
pushl $matrix
call matrix_mult
pop %eax
pop %eax
pop %eax
pop %eax

incl contor
mov contor,%ecx
cmp lungime,%ecx
je afisajlungime2

incl contor
jmp inmultimmatrici



afisajlungime1:

mov n,%eax
mov sursa,%ebx
mul %ebx
addl destinatie,%eax

lea matrixx,%edi
movl (%edi,%eax,4),%edx
movl %edx,x

pusha
push x
push $formatread
call printf
pop %eax
pop %eax
popa

push $0
call fflush
pop %eax


jmp et_exit

afisajlungime2:

mov n,%eax
mov sursa,%ebx
mul %ebx
addl destinatie,%eax

lea matrixrezult,%edi
movl (%edi,%eax,4),%edx
movl %edx,x

pusha
push x
push $formatread
call printf
pop %eax
pop %eax
popa

push $0
call fflush
pop %eax


et_exit:
mov $1,%eax
xor %ebx,%ebx
int $0x80
