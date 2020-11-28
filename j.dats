#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"
staload "libats/libc/SATS/dlfcn.sats"

abstype J
stadef jinittype = () -> [l:agz] (J@l | ptr l)
// stadef jdotype   = {l:addr} (!J@l | ptr l,!strptr) -> int
stadef jdotype   = {l:agz} (!J@l | ptr l,string) -> int
stadef jfreetype = {l:agz} (J@l | ptr l) -> void
stadef jgetmtype = 
{l,t,r,s,d:addr}
(!J@l, !lint? @ t >> lint @ t, !lint? @ r >> lint @ r,
       !lint? @ s >> lint @ s, !lint? @ d >> lint @ d |
 ptr l, string, ptr t, ptr r, ptr s, ptr d )
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

val p = dlsym(pf|jhandle, "JGetM")
val () = assertloc(p>0)
val jgetm = $UN.cast{jgetmtype}(p)
(* val err = dlclose (pf | jhandle) *)

datatype jtype = 
| jbool of ()
| jlit of ()
| jint of ()
| jfloat of ()
| jcomplex of ()
| jtodo of (int)

fn ll2jt (t:int) : jtype = case t of
| 1 => jbool
| 2 => jlit
| 4 => jint
| 8 => jfloat
| 16 => jcomplex
| _ =>> jtodo(t)

(* etc *)

fn jwidth (t : jtype) : uint = 
case+ t of
| jbool () => sz2u(sizeof<char>)
| jlit () => sz2u(sizeof<char>)
| jint () => sz2u(sizeof<lint>)
| jfloat () => sz2u(sizeof<double>)
| jcomplex () => 2u * sz2u(sizeof<double>)
| jtodo(n) => $UN.cast(n)

dataview jval = 
{t,r,s,d:addr} jval of 
(int@t, int@r, int@s, int@d | ptr t, ptr r, ptr s, ptr d)

// fn jgetshape{s:addr}
// (pf : !lint@s | sh : ptr s, rk : uint)
// : [n:nat] [l:agz] (array_v (lint?, l, n), mfree_gc_v (l) | ptr l) = let
//   val n = g1ofg0(rk)
//   val (apf,afr|ar) = array_ptr_alloc<lint>(i2sz(n))
// //  val _ = $extfcall(int,"memcpy",ar,sh,rk)
// in (apf,afr|ar) end

fn jget{l:agz} (pf : !J@l | j : ptr l,jvar : string) : void = let
  val (pft,frt|t) = ptr_alloc<lint>()
  val (pfr,frr|r) = ptr_alloc<lint>()
  val (pfs,frs|s) = ptr_alloc<lint>()
  val (pfd,frd|d) = ptr_alloc<lint>()
  val res = jgetm(pf,pft,pfr,pfs,pfd|j,jvar,t,r,s,d)
  val rk = ptr_get(pfr|r)
//  val (pfsh,shfr|sh) = jgetshape(pfs|s,rk)
  val () = println!("\nok?     ",0=res,
                    "\ntype:   ",ptr_get(pft|t),
                    "\nrank:   ",rk,
                    "\nlength: ",$UN.ptr0_get<lint>($UN.cast(ptr_get(pfs|s))),
                    "\nshape:  ",0
                    )
  val () = ptr_free(frt,pft|t)
  val () = ptr_free(frr,pfr|r)
  val () = ptr_free(frs,pfs|s)
  val () = ptr_free(frd,pfd|d)
//  val () = ptr_free(shfr,pfsh|sh)
in end

(* crucial example: https://github.com/githwxi/ATS-Postiats/blob/master/doc/EXAMPLE/ATSLIB/libats_libc_dlfcn.dats *)
implement main0 () =
let

  val (pfj | j) = jinit ()
//  val res = jdo(pfj | j, "4 (1!:2)~ ,/ (10{a.),.~ \": j./~ i:5")

  val res = jdo(pfj | j, "x =: i. 2 2 10")
  val () = jget (pfj | j, "x")

  val res = jdo(pfj | j, "x =: a. {~ 65 + i. 26")
  val () = jget (pfj | j, "x")

  val res = jdo(pfj | j, "x =: = i. 10")
  val () = jget (pfj | j, "x")

  val () = jfree(pfj | j)

in end