.PHONY : clean

FLAGS = -verbose -cleanaft -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -I${PATSHOME}/contrib -ldl -latslib

j_dats : j.dats j.sats
	patscc $(FLAGS) -o $@ j.dats -s j.sats

%_dats : %.dats
	patscc $(FLAGS) -o $@ $<

clean :
	rm -f *_dats # myatscc binaries
	rm -f *~
