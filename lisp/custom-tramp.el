;; functions:
;; - custom-add-tramp-completion

(setopt tramp-default-method
  (if (eq system-type 'windows-nt)
      (if (executable-find "plink")
          "plink"
        "sshx")
    "ssh"))

(defvar *tramp-completion-list*
  '())
(defun custom--tramp-completion-function (whatever)
  *tramp-completion-list*)
(add-to-list 'tramp-completion-function-alist
  `(,tramp-default-method
    (custom--tramp-completion-function "")))
(defun custom-add-tramp-completion (username remote)
  (add-to-list '*tramp-completion-list*
    (list username remote)))

(provide 'custom-tramp)
