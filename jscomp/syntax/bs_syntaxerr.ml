(* Copyright (C) 2015-2016 Bloomberg Finance L.P.
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * In addition to the permissions granted to you by the LGPL, you may combine
 * or link a "work that uses the Library" with a publicly distributed version
 * of this file to produce a combined library or application, then distribute
 * that combined work under the terms of your choosing, with no requirement
 * to comply with the obligations normally placed on you by section 4 of the
 * LGPL version 3 (or the corresponding section of a later version of the LGPL
 * should you choose to use a later version).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *)



type error 
  = Unsupported_predicates
  | Conflict_bs_bs_this_bs_meth  
  | Duplicated_bs_deriving
  | Conflict_attributes

  | Duplicated_bs_as 
  | Expect_int_literal
  | Expect_string_literal
  | Expect_int_or_string_literal
  | Unhandled_poly_type
  | Unregistered of string 
  | Invalid_underscore_type_in_external
  | Invalid_bs_string_type 
  | Invalid_bs_int_type 
  | Conflict_ffi_attribute

let pp_error fmt err =
  Format.pp_print_string fmt @@ match err with 
  | Unsupported_predicates 
    ->
     "unsupported predicates"
  | Conflict_bs_bs_this_bs_meth -> 
     "[@bs.this], [@bs], [@bs.meth] can not be applied at the same time"
  | Duplicated_bs_deriving
    -> "duplicated bs.deriving attribute"
  | Conflict_attributes
    -> "conflict attributes " 
  | Expect_string_literal
    -> "expect string literal "
  | Duplicated_bs_as 
    -> 
    "duplicated bs.as "
  | Expect_int_literal 
    -> 
    "expect int literal "
  | Expect_int_or_string_literal
    ->
    "expect int or string literal "
  | Unhandled_poly_type 
    -> 
    "Unhandled poly type"
  | Unregistered str 
    -> "Unregistered " ^ str 
  | Invalid_underscore_type_in_external
    ->
    "_ is not allowed in combination with external optional type"
  | Invalid_bs_string_type
    -> 
    "Not a valid  type for [@bs.string]"
  | Invalid_bs_int_type 
    -> 
    "Not a valid  type for [@bs.int]"
  | Conflict_ffi_attribute
    ->
    "conflict attributes found" 
 
exception  Error of Location.t * error

let () = 
  Location.register_error_of_exn (function
    | Error(loc,err) -> 
      Some (Location.error_of_printer loc pp_error err)
    | _ -> None
    )

let err loc error = raise (Error(loc, error))
