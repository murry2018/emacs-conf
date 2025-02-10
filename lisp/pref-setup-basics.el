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

(init-for ace-window
  (this-is-comment "
  The default behavior of `ace-window' is to ignore characters other
  than `aw-keys' when they are typed. However, for some reason, it
  fails to ignore Korean when it is typed (and presumably other
  East Asian languages as well).

  This advice function toggles input-method to switch to English
  before ace-window is called, and then toggles input-method again
  after it is called to revert to the original input-method.")

  (defun pref--handle-input-method-on-ace-window (oldfunc &rest r)
    (let ((input-method? current-input-method)
          (pref-current-buffer (current-buffer)))
      (when input-method?
        (toggle-input-method))
      (apply oldfunc r)
      (when input-method?
        (with-current-buffer pref-current-buffer
          (toggle-input-method)))))

  (advice-add 'ace-window :around
              #'pref--handle-input-method-on-ace-window))


;; which-key
(init-for which-key
  (which-key-mode))

;; imenu-list
(init-for imenu-list
  (keymap-global-set "C-'" #'imenu-list-smart-toggle))

(provide 'pref-setup-basics)
