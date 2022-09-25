# ASM Integer To Binary

This program written in x86 Assembly, converts an integer to binary.

## Upcoming
- Add more number systems (octal, hexadecimal).

## Compilation

Install NASM with:

```bash
sudo apt-get install -y nasm
```

With NASM and MINGW confirmed to be installed, proceed with compilation for your system architecture:
    
```bash
nasm -f win32 main.asm -o main
gcc main.obj
```

## Acknowledgments
if this repository was useful to you, please leave it a star.
