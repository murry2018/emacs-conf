(push (expand-file-name "lisp" user-emacs-directory)
      load-path)

;; load packages and definitions
(require 'custom-packages)
;; better defaults
(require 'custom-defaults)
;; setup basic packages(company, flycheck, ace-window, which-key)
(require 'custom-setup-basics)
;; ivy(minibuffer completion)
(require 'custom-ivy)
;; slime
(require 'custom-slime)
;; paredit
(require 'custom-paredit)
;; tramp
(require 'custom-tramp)

;; machine dependent configs
;; these functions are available:
;; - custom-install-packages (\custom-packages)
;; - custom-add-slime-filename-translation (\custom-slime)
;; - custom-add-tramp-completion (\custom-tramp)
(require 'custom-site-config nil t)
