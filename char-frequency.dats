#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"

fn ix (x : int) : [k:nat | 0 <= k; k < 256 ] size_t(k) = $UN.cast(x)

fn hist (f : FILEref) : void = let
   var A = arrayref_make_elt (i2sz(256), 0)
   fun lp (A : arrayref(int,256)) : void = 
   case fileref_getc(f) of
   | x when 0 <= x && x < 256 => (A[ix(x)] := 1+A[ix(x)]; lp (A))
   | _ => ()
   val () = lp (A)
   var j:int
in for (j := 0; j < 256; j := j+1)
   let val y = A[ix(j)]
    in if y > 0 then println!(j,'\t',A[ix(j)]) else () end
end

implement main0 () = let
in hist(stdin_ref) end

