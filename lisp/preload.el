;;; initialization
;;;; initialize melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;;;; initailize customizations
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(defun ensure-package (package)
  "install package, if not installed"
  (when (not (package-installed-p package))
    (when (not package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

(defmacro init-for (package &rest body)
  "with installed package do whatever"
  `(progn
     (ensure-package ',package)
     (require ',package)
     (add-hook 'after-init-hook
       (lambda ()
         (progn
           ,@body)))))
(put 'init-for 'lisp-indent-function 1)

(provide 'preload)
