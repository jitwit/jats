#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"
staload "libats/libc/SATS/dlfcn.sats"

abstype J

(* crucial example: https://github.com/githwxi/ATS-Postiats/blob/master/doc/EXAMPLE/ATSLIB/libats_libc_dlfcn.dats *)
implement main0 () = 
let
  val lj = stropt_some("/home/jrn/code/jats/libj.so")
   // strptr2stropt(string0_copy("libj.so"))
  val (pfo | pl) = dlopen(lj,RTLD_LAZY)
  val () = if pl = 0 then println!("blahhhh!") else ()
  val () = assertloc(pl > 0)
  prval Some_v(pf) = pfo
  val (fpf | str) = dlerror ()
  prval () = fpf (str)
  val sjinit = dlsym(pf|pl,"JInit")
  val jinit = $UN.cast{{l:addr}()->(J@l | ptr l)}(sjinit)
  val sjdo = dlsym(pf | pl, "JDo")
  val jdo = $UN.cast{{l:addr}(!J@l>>_ | ptr l,string)->int}(sjdo)
  val sjfree = dlsym(pf|pl, "JFree")
//  val speech = string0_copy("i. 10")
//  val () = println!(speech)
  val jfree = $UN.cast{{l:addr}(J@l | ptr l)->void}(sjfree)
  val (pfj | j) = jinit()
  val res = jdo(pfj | j, "4 (1!:2)~ \": i. 10")
  val () = jfree(pfj | j)
  val err = dlclose (pf | pl)
in println!("J loaded!") end