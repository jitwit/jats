.PHONY : clean

FLAGS = -verbose -cleanaft -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -I${PATSHOME}/contrib -ldl

%_dats : %.dats
	patscc $(FLAGS) -o $@ $< -latslib

clean :
	rm -f *_dats # myatscc binaries
	rm -f *~
