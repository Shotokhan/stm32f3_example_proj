compiler=arm-none-eabi-gcc
objcopy=arm-none-eabi-objcopy
flags=-mthumb -mcpu=cortex-m4
program=main
gdb_port=6000


all: $(program).elf
	$(objcopy) -I elf32-littlearm $(program).elf -O binary $(program).bin

$(program).elf: startup.o $(program).o
	$(compiler) -o $(program).elf startup.o $(program).o -T linker_script.ld --specs=nosys.specs -nostdlib

startup.o: startup.s
	$(compiler) $(flags) -c startup.s -o startup.o

$(program).o: $(program).c
	$(compiler) $(flags) -c $(program).c -o $(program).o
	
flash: $(program).bin
	st-flash write $(program).bin 0x8000000
	echo "1" > flashed
	
debug: flashed
	st-util -p 6000 &
	echo "If debug doesn't work, type 'load $(program).elf' in gdb"
	gdb -ex "target extended-remote localhost:6000" $(program).elf 
	pkill st-util
	
clean:
	rm -f *.o
	rm -f *.elf
	rm -f *.bin
	rm -f flashed

