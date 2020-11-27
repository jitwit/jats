#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"
staload "libats/libc/SATS/dlfcn.sats"

(* dataview *)
(* option_view_bool_view *)
(*   (a:view+, bool) = *)
(*   | Some_v (a, true) of (INV(a)) | None_v (a, false) *)
(* // end of [option_view_bool_view] *)
(* stadef option_v = option_view_bool_view *)
(* // *)

(* praxi *)
(* dlopen_v_elim_null{l:addr | l <= null} (pf: dlopen_v (l)): void *)

(* absview dlopen_v (l:addr) *)

(* fun dlopen ( *)
(*   filename: NSH(stropt), flag: uint *)
(* ) : [l:addr] (option_v (dlopen_v(l), l > null) | ptr l) = "mac#%" *)
// is trick that addr is zero iff the option is none?

(* http://ats-lang.sourceforge.net/DOCUMENT/INT2PROGINATS/HTML/c3554.html *)
(* http://ats-lang.sourceforge.net/DOCUMENT/INT2PROGINATS/HTML/x3577.html *)
    (* val lj as (pfh | handle) : [l:addr] (option_v ( dlopen_v(l), l > null) | ptr l) =  *)
(* https://github.com/githwxi/ATS-Postiats/blob/master/doc/EXAMPLE/ATSLIB/libats_libc_dlfcn.dats *)

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
  val jinit = dlsym (pf | pl, "JInit")
  val jgetr = dlsym (pf | pl, "JGetR")
  val err = dlclose (pf | pl)
in println!("J loaded!") end