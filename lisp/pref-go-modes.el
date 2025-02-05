(require 'pref-packages)

(init-for go-mode
  (when (executable-find "go")
    (when (executable-find "gopls")
      (add-hook 'go-mode-hook #'eglot-ensure))))

(provide 'pref-go-modes)
