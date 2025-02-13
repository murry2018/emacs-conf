(require 'pref-packages)

;; markdown-mode
(init-for markdown-mode
  (autoload 'gfm-mode "markdown-mode")
  (when (package-installed-p 'valign)
    (require 'markdown-mode)
    (keymap-set markdown-mode-map "C-c g a" #'valign-table))
  (add-to-list 'auto-mode-alist
    '("README\\.md\\'" . gfm-mode)))

;; org-mode
(require 'org-tempo)
(defun pref--org-mode-init ()
  (visual-line-mode -1)
  (electric-pair-mode -1)
  (display-line-numbers-mode -1)
  (org-indent-mode)
  (when (package-installed-p 'valign)
    (keymap-set org-mode-map "C-c g a" #'valign-table)))
(add-hook 'org-mode-hook 'pref--org-mode-init)

(defun pref--remove-recur (elem seq test)
  " remove ELEM in SEQ recursively

e.g.
(remove-recur 1 '(1 2 3 (6 7 8 1 2 3) 1 2 3) #'=)
; => (2 3 (6 7 8 2 3) 2 3)"
  (cl-labels ((rec (acc e)
                (if (listp e)
                    (cons (pref--remove-recur elem e test) acc)
                  (if (funcall test e elem) acc (cons e acc)))))
    (reverse (cl-reduce #'rec seq :initial-value nil))))

(defun pref--disable-in-file-completion ()
  (require 'company)
  (setq-local company-backends
        (pref--remove-recur 'company-dabbrev company-backends #'eq)))
(add-hook 'org-mode-hook #'pref--disable-in-file-completion)

;; json-mode
(defun pref--json-mode-init ()
  (setopt indent-tabs-mode nil
          tab-width 2
          js-indent-level 2))
(add-hook 'json-mode-hook 'pref--json-mode-init)

(provide 'pref-document-modes)
