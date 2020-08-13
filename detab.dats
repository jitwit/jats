#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"

#define EOF %(~1)

fn cmon_man{n:pos} (n : int(n)) : size_t(n) = $UN.cast(n)

fn detab{n:pos} (tabstop : int(n)) : void =
let implement string_tabulate$fopr<> (i) = ' '
    val fill = string_tabulate(cmon_man(tabstop))
    fun lp (fill : string) : void = case fileref_getc(stdin_ref) of
    | EOF => ()
    | 9 => begin print(fill); lp (fill) end
    | x => begin fileref_putc(stdout_ref,x); lp (fill) end
in lp (strnptr2string(fill)) end

implement main0 () = detab (14)