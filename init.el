(push (expand-file-name "lisp" user-emacs-directory)
      load-path)

;; load packages and definitions
(require 'pref-packages)
;; better defaults
(require 'pref-defaults)
;; setup basic packages(company, flycheck, ace-window, which-key)
(require 'pref-setup-basics)
;; ivy(minibuffer completion)
(require 'pref-ivy)
;; themes
(require 'pref-themes)
;; posframe
(require 'pref-posframe)
;; slime
(require 'pref-slime)
;; paredit
(require 'pref-paredit)
;; tramp
(require 'pref-tramp)
;; document modes (markdown, org-mode)
(require 'pref-document-modes)
;; C/C++ modes (eglot)
(require 'pref-cc-modes)
;; Go modes (eglot + gopls)
(require 'pref-go-modes)

;; machine dependent configs
;; these functions are available:
;; - init-for (\pref-packages)
;; - pref-ensure-package (\pref-packages)
;; - pref-install-packages (\pref-packages)
;; - pref-add-slime-filename-translation (\pref-slime)
;; - pref-add-tramp-completion (\pref-tramp)
(require 'pref-site-config nil t)
