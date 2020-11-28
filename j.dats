#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"
staload "libats/libc/SATS/dlfcn.sats"
//staload "prelude/basics_pre.sats"

abstype J
stadef jinittype = {l:addr}()->(J@l | ptr l)
stadef jdotype   = {l:addr}(!J@l | ptr l,!strptr)->int
stadef jfreetype = {l:addr}(J@l | ptr l)->void
stadef jgetmtype = 
{l,t,r,s,d:addr}
(!J@l, !int? @ t >> int @ t, !int? @ r >> int @ r, 
       !intptr? @ s >> intptr @ s, !intptr? @ d >> intptr @ d | 
 ptr l, ptr t, ptr r, ptr s, ptr d )
-> int

val (pf | jhandle) = dlopen(stropt_some("/home/jrn/code/jats/libj.so"),RTLD_LAZY)
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
(* val err = dlclose (pf | jhandle) *)

datatype jtype = 
| jbool of ()
| jlit of ()
| jint of ()
| jfloat of ()
| jcomplex of ()
(* etc *)

fn jwidth (t : jtype) : uint = 
case+ t of
| jbool () => sz2u(sizeof<bool>)
| jlit () => sz2u(sizeof<char>)
| jint () => sz2u(sizeof<lint>)
| jfloat () => sz2u(sizeof<double>)
| jcomplex () => 2u * sz2u(sizeof<double>)

(* crucial example: https://github.com/githwxi/ATS-Postiats/blob/master/doc/EXAMPLE/ATSLIB/libats_libc_dlfcn.dats *)
implement main0 () =
let

  val (pfj | j) = jinit ()
  val speech = string0_copy("4 (1!:2)~ ,/ (10{a.),.~ \": j./~ i:5")
  val res = jdo(pfj | j, speech)
  val () = free(speech)
  val () = jfree(pfj | j)

in end