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
(init-for smartparens-mode
  (add-hook 'c-mode-hook #'smartparens-mode))

;; ace-window
(init-for ace-window
  (keymap-global-set "M-o" 'ace-window))
(setopt aw-keys
	'(?a ?s ?d ?f ?g ?h ?k ?l))

;; which-key
(init-for which-key
  (which-key-mode))

(provide 'pref-setup-basics)
