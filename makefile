all:
	$(MAKE) -C minic2eeyore all
	$(MAKE) -C eeyore2tigger all
	$(MAKE) -C tigger2riscv all

clean:
	-$(MAKE) -C minic2eeyore clean
	-$(MAKE) -C eeyore2tigger clean
	-$(MAKE) -C tigger2riscv clean
