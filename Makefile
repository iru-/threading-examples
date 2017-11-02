all: itc dtc stc

%.o: %.s
	nasm -f elf64 -g -F dwarf $<

%tc: %tc.o
	ld -o $@ $<

t%: %
	gdb -q -x cmd.gdb $^

clean:
	rm -f *.o *tc
