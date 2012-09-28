#!/bin/sh

directory=$1

EXTRACT=../../../_obuild/ocp-extract/ocp-extract.asm

echo '(***********************************************************)'
echo '(*                                                         *)'
echo '(* This file was automatically generated by calling:       *)'
echo '(*    ./generate.sh ' $directory '             *)'
echo '(*                                                         *)'
echo '(***********************************************************)'


$EXTRACT -impl $directory/utils/config.ml -val cmi_magic_number


echo module Lexing = struct
$EXTRACT  $directory/stdlib/lexing.ml \
    -type position
echo end

echo module Location = struct
echo open Lexing
$EXTRACT  $directory/parsing/location.ml \
    -type t \
    -type loc
echo end

echo module Asttypes = struct
$EXTRACT  $directory/parsing/asttypes.mli \
    -type constant \
    -type direction_flag \
    -type private_flag \
    -type mutable_flag \
    -type virtual_flag \
    -type label \
    -type rec_flag \
    -type closed_flag \
    -type override_flag \
    -type loc
echo end

echo module Longident = struct
$EXTRACT  $directory/parsing/longident.ml \
    -type t
echo end

echo module Parsetree = struct
echo open Asttypes

$EXTRACT  $directory/parsing/parsetree.mli \
    -type core_type \
    -type class_infos \
    -type pattern \
    -type expression
echo end



echo module Primitive = struct

$EXTRACT  $directory/typing/primitive.ml \
    -type description

echo end

echo module Ident = struct

$EXTRACT  $directory/typing/ident.ml \
    -type t \
    -type tbl

echo end

echo module Path = struct

$EXTRACT  $directory/typing/path.ml \
    -type t

echo end

echo module Types = struct
echo open Asttypes
$EXTRACT -k  $directory/typing/types.ml \
    -type type_expr \
    -type type_desc \
    -type row_desc \
    -module TypeOps \
    -module OrderedString \
    -module Meths \
    -module Vars \
    -type value_description \
    -type constructor_description \
    -type label_description \
    -type type_declaration \
    -type exception_declaration \
    -module Concr \
    -type class_type \
    -type class_declaration \
    -type class_type_declaration \
    -type module_type

echo end

echo module Annot = struct

$EXTRACT  $directory/typing/annot.mli \
    -type call \
    -type ident

echo end

echo module Tbl = struct

$EXTRACT  $directory/utils/tbl.ml \
    -type t

echo end

echo module Subst = struct
echo open Types

$EXTRACT  $directory/typing/subst.ml \
    -type t

echo end

echo module Env = struct
echo open Types

$EXTRACT  $directory/typing/env.ml \
    -type summary \
    -type t

echo end

echo module Typedtree = struct
echo open Asttypes
echo open Types
$EXTRACT  $directory/typing/typedtree.mli \
    -type partial \
    -type optional \
    -type pattern \
    -type expression

echo end

echo module Cmi_format = struct

$EXTRACT  $directory/typing/cmi_format.ml \
    -type pers_flags \
    -type cmi_infos

echo end

echo module Lambda = struct
echo open Asttypes

$EXTRACT  $directory/bytecomp/lambda.ml \
    -type primitive \
    -type structured_constant \
    -type function_kind \
    -type let_kind \
    -type meth_kind \
    -type shared_code

echo end


echo module Cmo_format = struct

$EXTRACT  $directory/bytecomp/cmo_format.mli \
    -type reloc_info \
    -type compilation_unit \
    -type library

echo end

echo module Debuginfo = struct

$EXTRACT  $directory/asmcomp/debuginfo.ml \
    -type kind \
    -type t

echo end

echo module Clambda = struct
echo open Asttypes
echo open Lambda

$EXTRACT  $directory/asmcomp/clambda.ml \
    -type function_label \
    -type ulambda \
    -type function_description \
    -type value_approximation

echo end

echo module Cmx_format = struct
echo open Clambda

$EXTRACT  $directory/asmcomp/cmx_format.mli \
    -type unit_infos \
    -type library_infos

echo end





