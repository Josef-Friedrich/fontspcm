all:
	luatex specimen.ins
	lualatex specimen.dtx
	makeindex -s gglo.ist -o specimen.gls specimen.glo
	makeindex -s gind.ist -o specimen.ind specimen.idx
	lualatex specimen.dtx

clean:
	./.githook_pre-commit

ctan:
	rm -rf specimen
	mkdir specimen
	cp -f README.md specimen/README
	cp -f specimen.ins specimen/
	cp -f specimen.dtx specimen/
	cp -f specimen.pdf specimen/
	tar cvfz specimen.tar.gz specimen
	rm -rf specimen

.PHONY: all clean ctan
