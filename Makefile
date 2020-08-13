.PHONY : clean

%_dats : %.dats
	myatscc $<

clean :
	rm *_dats # myatscc binaries
	rm *~
