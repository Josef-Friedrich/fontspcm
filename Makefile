all:
	luatex fontspcm.ins
	lualatex fontspcm.dtx
	makeindex -s gglo.ist -o fontspcm.gls fontspcm.glo
	makeindex -s gind.ist -o fontspcm.ind fontspcm.idx
	lualatex fontspcm.dtx

clean:
	./.githook_pre-commit

ctan:
	rm -rf fontspcm
	mkdir fontspcm
	cp -f README.md fontspcm/README
	cp -f fontspcm.ins fontspcm/
	cp -f fontspcm.dtx fontspcm/
	cp -f fontspcm.pdf fontspcm/
	tar cvfz fontspcm.tar.gz fontspcm
	rm -rf fontspcm

.PHONY: all clean ctan
