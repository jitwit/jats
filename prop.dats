#include "share/atspre_staload.hats"
(* Fib to demo props *)

datatype F (int,int) = 
| F0 (0,0) of ()
| F1 (1,1) of ()
| {n,r0,r1:nat}
  F2 (n+2,r0+r1) of (F(n,r0), F(n+1,r1))

fun f {n:nat} (n: int n) : [r:nat] (F(n,r) | int(r)) = 
case+ n of
| 0 => (F0 () | 0)
| 1 => (F1 () | 1)
(* patterh 'n => ...' failed. with '_ =>>' checker knows n-2 >= 0, apparently *)
| _ =>> let 
  val (fn2 | r2) = f (n-2)
  val (fn1 | r1) = f (n-1)
in (F2 (fn2,fn1) | r1+r2) end

implement main0 () = let
  val (pf | fib) = f(30)
in println!(fib) end