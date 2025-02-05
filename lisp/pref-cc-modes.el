(require 'pref-packages)

;; Enable eglot (default: clangd)
(when (or (executable-find "clangd")
          (executable-find "ccls"))
  (add-hook 'c-mode-hook #'eglot-ensure)
  (add-hook 'c++-mode-hook #'eglot-ensure))

;; Customize C style based on k&r and set it as the default.
(c-add-style "pref-c"
             '("k&r"
               (c-basic-offset . 4)
               (c-offsets-alist
                (cpp-macro . 0)
                (arglist-close . c-lineup-close-paren))))
(setopt c-default-style "pref-c")

;; eglot-inactive-regions
;; Eglot inactive regions doesn't loaded properly on startup,
;; hence this dirty hack.
(when (load "~/.emacs.d/elpa/eglot-inactive-regions-0.6.3/eglot-inactive-regions.el" t)
  (eglot-inactive-regions-mode 1))
;; (init-for eglot-inactive-regions
;;   (eglot-inactive-regions-mode 1))
(setopt eglot-inactive-regions-style 'shadow-face)

;; which-function-mode
(defun pref-c-which-function-mode-setup ()
  (interactive)
  (which-function-mode 1)
  (setopt header-line-format
    '((which-func-mode ("" which-func-format " "))))
  (setopt mode-line-misc-info
    ;; We remove Which Function Mode from the mode line, because it's mostly
    ;; invisible here anyway.
    (assq-delete-all 'which-func-mode mode-line-misc-info)))
(add-hook 'c-mode-hook #'pref-c-which-function-mode-setup)

;; Stop format-on-type
(defun pref-c-no-document-formatting ()
  ;; Thanks to this:
  ;; https://andreyor.st/posts/2023-09-09-migrating-from-lsp-mode-to-eglot/
  (setopt eglot-ignored-server-capabilities
    '(:documentFormattingProvider
      :documentOnTypeFormattingProvider
      :foldingRangeProvider)))
(add-hook 'c-mode-hook #'pref-c-no-document-formatting)


(provide 'pref-cc-modes)
