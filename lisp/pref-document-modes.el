(require 'pref-packages)

;; markdown-mode
(init-for markdown-mode
  (autoload 'gfm-mode "markdown-mode")
  (add-to-list 'auto-mode-alist
    '("README\\.md\\'" . gfm-mode)))

;; org-mode
(require 'org-tempo)
(defun pref--org-mode-init ()
  (visual-line-mode -1)
  (electric-pair-mode -1)
  (display-line-numbers-mode -1))
(add-hook 'org-mode-hook 'pref--org-mode-init)

;; json-mode
(defun pref--json-mode-init ()
  (setopt indent-tabs-mode nil
          tab-width 2
          js-indent-level 2))
(add-hook 'json-mode-hook 'pref--json-mode-init)

(provide 'pref-document-modes)
