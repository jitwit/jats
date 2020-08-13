#include "share/atspre_staload.hats"
staload "longest-line.sats"

fn ll () : void = 
let fun lp{m:nat} (str:Strptr1, m : int(m)) : void
      = if fileref_is_eof(stdin_ref) then begin println!(str); free str end else
      let var n:int
          val nxt = fileref_get_line_string_main(stdin_ref,n)
          prval _ = lemma_strnptr_param (nxt)
      in if n > m
        then begin free str; lp (strnptr2strptr(nxt),n) end
        else begin free nxt; lp (str,m) end end
in lp(string0_copy(""),0) end

implement main0 () = ll ()
