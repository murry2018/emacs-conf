;; functions:
;; - custom-install-packages
;; - custom-ensure-package (for internal use)
;; - init-for (for internal use)

;;; initialize melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;;; package-related definitions
(defvar *required-packages*
  '(company
    flycheck
    ace-window
    which-key
    slime
    slime-company
    paredit
    modus-themes))

(defun custom-install-packages ()
  (interactive)
  (when (not package-archive-contents)
    (package-refresh-contents))
  (mapc 'package-install
	*required-packages*))

(defun custom-ensure-package (package)
  "install package, if not installed"
  (when (not (package-installed-p package))
    (when (not package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

(defmacro init-for (package &rest body)
  "with installed package do whatever.
If given package is not installed, do nothing."
  `(when (package-installed-p ',package)
     (add-hook 'after-init-hook
	       (lambda ()
		 (progn
		   ,@body)))))
(put 'init-for 'lisp-indent-function 1)

(provide 'custom-packages)
