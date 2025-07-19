nasm -f elf32 -o lib.o lib.asm
nasm -f elf32 -o main.o main.asm
ld -m elf_i386 -s -o app lib.o main.o
