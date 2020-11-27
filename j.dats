#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"
staload "libats/libc/SATS/dlfcn.sats"

abstype J
stadef jinittype = {l:addr}()->(J@l | ptr l)
stadef jdotype   = {l:addr}(!J@l | ptr l,strptr)->int
stadef jfreetype = {l:addr}(J@l | ptr l)->void

(* crucial example: https://github.com/githwxi/ATS-Postiats/blob/master/doc/EXAMPLE/ATSLIB/libats_libc_dlfcn.dats *)
implement main0 () = 
let
  val lj = stropt_some("/home/jrn/code/jats/libj.so")
  val (pf | jhandle) = dlopen(lj,RTLD_LAZY)
  val () = assertloc(jhandle > 0)
  prval Some_v(pf) = pf
  val (fpf | str) = dlerror ()
  prval () = fpf (str)

  val p = dlsym(pf|jhandle, "JInit")
  val () = assertloc(p>0)
  val jinit = $UN.cast{jinittype}(p)

  val p = dlsym(pf|jhandle, "JDo")
  val () = assertloc(p>0)
  val jdo = $UN.cast{jdotype}(p)

  val p = dlsym(pf|jhandle, "JFree")
  val () = assertloc(p>0)
  val jfree = $UN.cast{jfreetype}(p)

  val (pfj | j) = jinit()
  val res = jdo(pfj | j, string0_copy("4 (1!:2)~ (10{a.),~\": *: i. 10"))
  val () = jfree(pfj | j)

  val err = dlclose (pf | jhandle)
in end