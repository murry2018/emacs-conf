(require 'custom-packages)

;; markdown-mode
(init-for markdown-mode
  (autoload 'gfm-mode "markdown-mode")
  (add-to-list 'auto-mode-alist
    '("README\\.md\\'" . gfm-mode)))

(provide 'custom-document-modes)
