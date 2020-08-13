.PHONY : clean

MFGS = -verbose -cleanaft -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -I${PATSHOME}/contrib


%_dats : %.dats
	patscc $(MFGS) -o $@ $< -latslib

clean :
	rm -f *_dats # myatscc binaries
	rm -f *~
