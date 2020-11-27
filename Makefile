.PHONY : clean

# PATSHOME = ~/.guix-profile/lib/ats2-postiats-0.4.2
FLAGS = -verbose -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -I${PATSHOME}/contrib -ldl

%_dats : %.dats
	patscc $(FLAGS) -o $@ $< -latslib

clean :
	rm -f *_dats # myatscc binaries
	rm -f *~
