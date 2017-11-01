all: itc dtc

%.o: %.s
	nasm -f elf64 -g -F dwarf $<

itc: itc.o
	ld -o $@ $<

dtc: dtc.o
	ld -o $@ $<

t%: %
	gdb -q -x cmd.gdb $^

clean:
	rm -f *.o itc dtc
