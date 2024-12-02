;; functions:
;; - pref-add-tramp-completion

(setopt tramp-default-method
  (if (eq system-type 'windows-nt)
      (if (executable-find "plink")
          "plink"
        "sshx")
    "ssh"))

(defvar *tramp-completion-list*
  '())
(defun pref--tramp-completion-function (whatever)
  *tramp-completion-list*)
(init-for tramp
  (require 'tramp)
  (tramp-set-completion-function tramp-default-method
    `((pref--tramp-completion-function ""))))
(defun pref-add-tramp-completion (username remote)
  (add-to-list '*tramp-completion-list*
    (list username remote)))

(provide 'pref-tramp)
