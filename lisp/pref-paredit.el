(require 'pref-packages)

(init-for paredit
  (require 'paredit)
  
  ;; Paredit with IELM
  (add-hook 'ielm-mode-hook 'paredit-mode)
  (keymap-set paredit-mode-map "RET" nil)
  (keymap-set paredit-mode-map "C-j" 'paredit-newline)

  ;; Paredit with SLIME repl
  (defun pref--override-slime-del-key ()
    (define-key slime-repl-mode-map
                (read-kbd-macro paredit-backward-delete-key) nil))
  (add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
  (add-hook 'slime-repl-mode-hook 'pref--override-slime-del-key)

  ;; Paredit with everything else
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  )


(provide 'pref-paredit)
