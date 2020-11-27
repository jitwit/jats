#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"
staload "libats/libc/SATS/dlfcn.sats"

abstype J
stadef jinittype = {l:addr}()->(J@l | ptr l)
stadef jdotype = {l:addr}(!J@l>>_ | ptr l,string)->int
stadef jfreetype = {l:addr}(J@l | ptr l)->void

(* crucial example: https://github.com/githwxi/ATS-Postiats/blob/master/doc/EXAMPLE/ATSLIB/libats_libc_dlfcn.dats *)
implement main0 () = 
let
  val lj = stropt_some("/home/jrn/code/jats/libj.so")
  val (pf | pl) = dlopen(lj,RTLD_LAZY)
  val () = assertloc(pl > 0)
  prval Some_v(pf) = pf
  val (fpf | str) = dlerror ()
  prval () = fpf (str)

  val jinit = $UN.cast{jinittype}(dlsym(pf|pl,"JInit"))
  val jdo = $UN.cast{jdotype}(dlsym(pf | pl, "JDo"))
  val jfree = $UN.cast{jfreetype}(dlsym(pf|pl, "JFree"))

  val (pfj | j) = jinit()
  val res = jdo(pfj | j, "4 (1!:2)~ (10{a.),~\": i. 10")
  val () = jfree(pfj | j)

  val err = dlclose (pf | pl)
in end