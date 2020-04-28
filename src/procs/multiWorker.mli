(**
 * Copyright (c) 2015, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the "hack" directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *
*)

(* The protocol for a next function is to return a list of elements.
 * It will be called repeatedly until it returns an empty list.
*)
type 'a nextlist = 'a list Hack_bucket.next

val next :
  Worker.t list option ->
  'a list ->
  'a list Hack_bucket.next

(* See definition in Hack_bucket *)
type 'a bucket = 'a Hack_bucket.bucket =
  | Job of 'a
  | Wait
  | Done

val call :
  Worker.t list option ->
  job:('c -> 'a -> 'b) ->
  merge:('b -> 'c -> 'c) -> neutral:'c ->
  next:'a Hack_bucket.next ->
  'c
