#include "share/atspre_staload.hats"

fn sum{n:nat} (n:int n) : double = 
let fun lp {i,n:nat | i <= n} .<n-i>. (n:int(n),i:int(i),t:double) : double =
  if i = n then t else lp (n,i+1:int(i+1),t+i)
 in lp (n,0,0.0) end

fn fact{n:nat} (n:int(n)) : double = let
 fun loop{n:nat}{l:addr} .<n>.
     (pf : !double@l | n : int n, res : ptr l) : void = 
 if n = 0 then () else let 
   val () = !res := n * !res
  in loop (pf | n-1, res) end
 var res:double with pf = 1.0
 val () = loop (pf | n, addr@res)
in res end

implement main0 () = let
 val () = println!(sum(1000)) 
 val () = println!(fact(20))
 in () end