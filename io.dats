#include "share/atspre_staload.hats"

#define EOF %(~1)

implement main0 () = 
let fun lp (n : int) : int = 
    case fileref_getc (stdin_ref) of
    | EOF => n
    | _ => lp (1+n)
 in println!(lp(0)) end
