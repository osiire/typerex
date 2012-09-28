
type os_type = WINDOWS | CYGWIN | UNIX

let os_type =
  match String.lowercase Sys.os_type with
      "win32" -> WINDOWS
    | "cygwin" -> CYGWIN
    | "unix" -> UNIX
    | _ -> assert false

external waitpids : int -> int array -> int * Unix.process_status
  = "win32_waitpids_ml"


let rec waitpid1 pid =
   let (_, status) = Unix.waitpid [] pid in
   match status with
     Unix.WEXITED n -> n
   | _ -> waitpid1 pid

let rec waitpid pid =
   try
     waitpid1 pid
   with Unix.Unix_error (Unix.EINTR, _, _) -> waitpid pid

let command argv =
(*    Printf.fprintf stderr "exec %s\n%!" filename; *)
    let pid = try
      Unix.create_process argv.(0) argv
         Unix.stdin Unix.stdout Unix.stderr
      with e ->
	      Printf.fprintf stderr "Error \"%s\" executing %s\n%!"
                (Printexc.to_string e) Sys.argv.(0);
              exit 2
    in
    let status = waitpid pid in
(*    Printf.fprintf stderr "waitpid returned %d\n%!" status; *)
    status

let simulate_exec argv =
   let status = command argv in
   exit status



