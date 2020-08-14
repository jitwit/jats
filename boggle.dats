#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"
staload "libats/DATS/funmap_rbtree.dats"
staload "libats/SATS/SHARE/funmap.hats"

datatype branch (a:t@ype) = B of (char,a)
datatype trie = branch of (bool,List(branch(trie)))

fn chr (x : char) : char -> bool = lam y => x = y

fn{x:t@ype} span {a,b,c:nat|a+b==c}
(p : x -> bool, xs : list(x,c)) : (list(x,a),list(x,b)) =
let fun{x:t@ype} lp {a,b:nat}
   (p : x -> bool, xs : list(x,a), ys : list(x,b)) 
   : (list(x,b),list(x,a)) =
    case+ xs of
    | nil () => (list_vt2t(reverse(ys)), xs)
    | cons (x,xs) => case p x of
    | true => (ys,cons(x,xs))
    // let val xys = $UN.cast(cons(x,$UN.cast(ys))) in lp (p,xs,xys) end
    | false => (cons(x,xs),ys)
in lp(p,xs,nil) end

(* fn gph (ws : List(List(char))) : List(char,(List(char))) = ws *)

(*
fn put (word : List0_vt(char), dict  : &trie >> _) : void = 
case dict of 
| branch (eow, dict) => case- word of
| list_vt_nil () => 
let prval () = $UN.cast2void(word) 
    val _ = eow := true
    prval _ = fold@ (eow)
in () end
*)

fn lc (f : FILEref) : [m:nat] int(m) =
let fun lp{n:nat} (f : FILEref, n : int(n)) : [m:nat|n <= m] int (m) = 
    if fileref_is_eof(f) then n
    else begin free(fileref_get_line_string(f)); lp(f,n+1) end
in lp (f,0) end

implement main0 () = 
let val dict_path = "/home/jrn/code/gobble/cobble/share/collins.txt"
    val dref = fileref_open_exn(dict_path,file_mode_r)
in println!(lc(dref)) end