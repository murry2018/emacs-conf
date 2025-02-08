;; functions:
;; - pref-add-slime-filename-translation

;; make slime contribs list, for `slime-setup'
(defvar *slime-contribs* '(slime-fancy slime-tramp))
(when (package-installed-p 'slime-company)
  (add-to-list '*slime-contribs* 'slime-company t))

(defconst *pref-lisp-impls*
  '(( :prog "sbcl"
      :implementation (sbcl ("sbcl")
                            :coding-system utf-8-unix))
    ( :prog "qlot"
      :implementation (qlot ("qlot" "exec" "sbcl")
                            :coding-system utf-8-unix))
    ( :prog "ros"
      :implementation (ros ("ros" "-Q" "run")
                           :coding-system utf-8-unix)
      :helper "~/.roswell/helper.el")))

(defun pref--load-helper (helper-path)
  (let ((path (expand-file-name helper-path)))
    (when (file-exists-p path)
      (load path))))

(defun pref--flatmap (fn sequence)
  (cl-loop for item in sequence
           append (funcall fn item)))

(defun pref--filter-impl-line (impl-line)
  (cl-destructuring-bind (&key prog implementation helper)
      impl-line
    (if (executable-find prog)
        (list implementation)
      nil)))

(defun pref--make-slime-impls ()
  (pref--flatmap #'pref--filter-impl-line *pref-lisp-impls*))

(defun pref--/lisp/-is-valid-impl ()
  (and inferior-lisp-program
       (string= inferior-lisp-program "lisp")
       (executable-find "lisp")))

(defun pref--inferior-is-not-/lisp/ ()
  (and inferior-lisp-program
       (not (string= inferior-lisp-program "lisp"))))

(when (require 'slime-autoloads nil t)
  ;; `slime-setup' should come before everything else
  (slime-setup *slime-contribs*)

  (defun pref--setup-slime-ask-impl (slime-command)
    (cond (current-prefix-arg
           (call-interactively slime-command))
          ((or (pref--inferior-is-not-/lisp/)
               (pref--/lisp/-is-valid-impl))
           (call-interactively slime-command))
          (t
           (let ((current-prefix-arg '-))
             (call-interactively slime-command)))))
  
  (advice-add #'slime :around #'pref--setup-slime-ask-impl)
  
  (setopt
    slime-lisp-implementations (pref--make-slime-impls)
    slime-company-completion 'fuzzy
    slime-company-after-completion 'slime-company-just-one-space
    slime-enable-evaluate-in-emacs t))

(defun pref-add-slime-filename-translation (machine-instance host username)
  (when (require 'slime-tramp nil t)
    (add-to-list 'slime-filename-translations
      (slime-create-filename-translator :machine-instance machine-instance
                                        :remote-host host
                                        :username username))))

(provide 'pref-slime)
