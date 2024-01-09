;;; Utility Functions
(defun complement (f)
  (lambda (&rest args)
    (not (apply f args))))

;;; Emacs Package Setting
(defun my/straight-bootstrap ()    
  (defvar bootstrap-version)
  (let ((bootstrap-file
	 (expand-file-name
          "straight/repos/straight.el/bootstrap.el"
          (or (bound-and-true-p straight-base-dir)
              user-emacs-directory)))
	(bootstrap-version 7))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
          (url-retrieve-synchronously
           "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
           'silent 'inhibit-cookies)
	(goto-char (point-max))
	(eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage)))

(defun my/initialize-package.el ()
  (require 'package)
  (add-to-list 'package-archives
	       '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize))

(defun my/install-use-package ()
  (require 'package)
  (setq use-package-enable-imenu-support t)
  (unless (package-installed-p 'use-package)
    (unless package-archive-contents
      (package-refresh-contents))
    (package-install 'use-package)))

(defun my/use-package-by-straight ()
  (setq use-package-enable-imenu-support t)
  (straight-use-package 'use-package)
  (require 'use-package)
  (setq straight-use-package-by-default t))

;;; Emacs Lisp Appearance
(defun my/emacs-lisp-outline-minor-mode-setup ()
  (outline-minor-mode t)
  (setq outline-minor-mode-use-buttons nil)
  (setq outline-minor-mode-cycle t)
  (setq outline-minor-mode-prefix ";;;"))

(defun my/emacs-lisp-imenu-setup ()
  (add-to-list 'imenu-generic-expression
	       '("Headings" "^;;; **\\(.*\\)" 1)))
