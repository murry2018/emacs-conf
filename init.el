(push (expand-file-name "lisp" user-emacs-directory)
      load-path)

;; load packages, customizations, definitions
(require 'preload)
;; better defaults
(require 'custom-defaults)
;; minibuffer completion(ido, fido, ibuffer, isearch)
(require 'custom-minibuffer)
;; site modules:
;; - `site-slime-tramp-connectors':
;;     should contain *site-slime-tramp-connectors*
;;     which is a list of slime-filename-translator
;;     i.e. (list (slime-create-filename-translator ...))

;; theme(modus)
(ensure-package 'modus-themes)

;;; Package setup
;;;; company
(init-for company
  (global-company-mode t))

;;;; flycheck
(init-for flycheck
  (global-flycheck-mode))
(setopt
    flycheck-emacs-lisp-load-path 'inherit
    flycheck-disabled-checkers '(emacs-lisp-checkdoc))

;;;; tramp
(require 'tramp)
(setopt password-cache-expiry 86400
        auth-source-debug t
        auth-sources nil)

;;;; ace-window
(init-for ace-window
  (keymap-global-set "M-o" 'ace-window))

;;;; which-key
(init-for which-key
  (which-key-mode))

;;;; slime
(ensure-package 'slime)
(ensure-package 'slime-company)
(setopt
    inferior-lisp-program "sbcl"
    slime-company-completion 'fuzzy
    slime-company-after-completion 'slime-company-just-one-space)

(when (require 'site-slime-tramp-connectors nil t)
  (setf slime-filename-translations
        *site-slime-tramp-connectors*))

(slime-setup '(slime-fancy slime-company slime-tramp))

;;;; Paredit
(ensure-package 'paredit)
(require 'paredit)

;; Paredit with IELM
(add-hook 'ielm-mode-hook 'paredit-mode)
(keymap-set paredit-mode-map "RET" nil)
(keymap-set paredit-mode-map "C-j" 'paredit-newline)

;; Paredit with anything else
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)

(defun override-slime-del-key ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-del-key)
