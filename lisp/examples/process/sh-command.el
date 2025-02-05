;;; process/sh-command.el
;; In this example, three commands are provided:
;; - `sh-start' launches an `sh' process in `pty' connection mode,
;; - `sh-shutdown' shutdowns running `sh' process,
;; - `sh-run' runs given command, and writes the result at "buff0" buffer.
;;
;; dependency: s

(require 's)

(defvar +ex:proc-name+      "proc0")
(defvar +ex:proc-buff-name+ "buff0")
(defvar +ex:proc-command+   '("sh" "-i"))
(defvar +ex--proc+ nil)

(defun ex--args-setup (name buff-name command)
  (let* ((name      (or name
                        +ex:proc-name+))
         (buff-name (or buff-name
                        +ex:proc-buff-name+))
         (command   (or command
                        +ex:proc-command+)))
    `( :name ,name
       :buffer ,(get-buffer-create buff-name)
       :command ,command
       :command-type pty)))

(cl-defun ex:sh-start (&optional verbose &key name buff-name command)
  "EX:SH-START: Start an `sh' process.

When VERBOSE is non-nil, it tells what it's doing. Its default
value is nil, but when EX:SH-START is called interactively, its
value is t.

NAME is the name of the process(which is different with executable's
name). If NAME is not given, `+ex:proc-name+' will be used.

BUFF-NAME is the name of the buffer which the output will be
written on. If you run a command with `sh-run', its result is
going to be written on <BUFF-NAME> buffer. If BUFF-NAME is not
given, `+ex:proc-buff-name+' will be used.

COMMAND represents the command which the process runs, whose
first element is command name or executable path, and the other
elements are the command-line arguments. If COMMAND is not given,
`+ex:proc-command+' will be used, whose value is '(\"sh\" \"-i\")"
  (interactive '(t))
  (ex:sh-shutdown)
  (let ((args (ex--args-setup name buff-name command)))
    (setf +ex--proc+ 
          (apply #'make-process args))
    (when verbose
        (message "process(%s) started in %s."
                 (process-name +ex--proc+)
                 (process-buffer +ex--proc+)))))

(defun ex:sh-shutdown (&optional verbose)
  "EX:SH-SHUTDOWN: Shutdown running `sh' process

It first send EOF to running process, which is typically a
graceful way to exit from a shell. However, when the process
doesn't respond to that, it sends SIGKILL to the process. If the
process is already terminated, it does nothing.

When VERBOSE is non-nil, it tells what it's doing. Its default
value is nil, but when EX:SH-SHUTDOWN is called interactively, its
value is t."
  (interactive '(t))
  (when (process-live-p +ex--proc+)
    (when verbose
        (message "terminating process(%s)..."
                 (process-name +ex--proc+)))
    (process-send-eof +ex--proc+)
    (accept-process-output +ex--proc+ 0.2)
    (when (process-live-p +ex--proc+)
      (when verbose 
        (message "killing process(%s)..."
                 (process-name +ex--proc+)))
      (delete-process +ex--proc+))))

(defun ex:sh-run (cmd &optional verbose)
  (interactive
   (list (read-string "command: " nil 'ex-history)
         t))
  (if (process-live-p +ex--proc+)
      (process-send-string +ex--proc+ (s-wrap cmd "" "\n"))
    (when verbose
      (message "There is no process running. You should first start a process with EX:SH-START command."))))

(provide 'sh-command)
