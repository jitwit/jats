#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"
staload "libats/DATS/funmap_rbtree.dats"
staload "libats/SATS/SHARE/funmap.hats"
(* word count post/article/tutorial maybe useful *)

datatype node = trie of @{eow = bool, sub = map(char,trie)}

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
fn add_word (s : charlst_vt, dict : trie) : trie = let
  fun lp(xs : charlst_vt, dict as trie t : trie) : trie
  = case xs of
  | ~nil_vt () => trie @{eow = true, sub = t.sub}
  | ~cons_vt(x,xs) => let // TODO
    val () = free(xs)
  in case funmap_search_opt(x,t.sub) of
  | None () => dict
  | _ => dict
  end
in lp(s,dict) end

fn lc (f : FILEref) : [m:nat] int(m) =
let fun lp{n:nat} (f : FILEref, n : int(n)) : [m:nat|n <= m] int (m) = 
    if fileref_is_eof(f) then n
    else begin free(fileref_get_line_string(f)); lp(f,n+1) end
in lp (f,0) end

implement main0 () = 
let val dict_path = "/home/jrn/code/gobble/cobble/share/collins.txt"
    val dref = fileref_open_exn(dict_path,file_mode_r)
in println!(lc(dref)) end