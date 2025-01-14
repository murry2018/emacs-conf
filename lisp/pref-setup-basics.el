(require 'pref-packages)

;; company
(init-for company
  (global-company-mode t))

;; flycheck
(init-for flycheck
  (global-flycheck-mode))
(setopt
    flycheck-emacs-lisp-load-path 'inherit
    flycheck-disabled-checkers '(emacs-lisp-checkdoc))

;; avy
(init-for avy
  (keymap-global-set "C-:" #'avy-goto-char))

;; smartparens
(defun pref--c-no-electric-pair ()
  (electric-pair-mode -1))
(init-for smartparens-mode
  (add-hook 'c-mode-hook #'smartparens-mode)
  (add-hook 'c-mode-hook #'pref--c-no-electric-pair))

;; ace-window
(init-for ace-window
  (keymap-global-set "M-o" 'ace-window))
(setopt aw-keys
	'(?a ?s ?d ?f ?g ?h ?k ?l))

;; which-key
(init-for which-key
  (which-key-mode))

;; imenu-list
(init-for imenu-list
  (keymap-global-set "C-'" #'imenu-list-smart-toggle))

(provide 'pref-setup-basics)
