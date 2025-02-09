(require 'pref-packages)

(init-for ivy-posframe
  (ivy-posframe-mode 1))
(init-for which-key-posframe
  (which-key-posframe-mode 1))
(init-for eldoc-box
  (add-hook 'eglot-managed-mode-hook #'eldoc-box-hover-mode t))
(init-for flycheck-popup-tip
  (with-eval-after-load 'flycheck
    (require 'flycheck-popup-tip)
    (add-hook 'flycheck-mode-hook #'flycheck-popup-tip-mode)))

(provide 'pref-posframe)
