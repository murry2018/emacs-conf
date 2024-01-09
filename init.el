;;; # Load implementations
(let ((impl-file (concat user-emacs-directory
			 "impl-init.el")))
  (when (file-exists-p impl-file)
    (load impl-file)))

;;; # Emacs Package Setting
;; **straight.el/use-package**
;; Because straight is an replacement of package.el, now we use
;; 'straight-use-package' or 'straight-get-recipe' instead of
;; 'package-install' or 'package-list-packages'
(when (executable-find "git")
  (my/straight-bootstrap)
  (my/use-package-by-straight))
;; **package.el/use-package**
;; straight.el requires git. If system doesn't have git, we would use
;; default package.el instead of straight.el.
(when (not (executable-find "git"))
  (my/initialize-package.el)
  (my/install-use-package))

;;; # Emacs Lisp Appearance
(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (my/emacs-lisp-outline-minor-mode-setup)
	    (my/emacs-lisp-imenu-setup)))

;;; # Emacs Startup Works
;; **Defining Custom File**
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;;; # Infrastructure
;; **Autocompletion**
(use-package company
  :ensure t
  :straight t
  :hook (after-init . global-company-mode))

;; **Syntax Checking**
(use-package flycheck
  :ensure t
  :straight t
  :init (global-flycheck-mode)
  :config
  (setq-default flycheck-disabled-checkers
		'(emacs-lisp-checkdoc)))

;; **Switching between windows**
(use-package ace-window
  :ensure t
  :straight t
  :bind ("M-o" . ace-window))

;; **Key-binding guide**
(use-package which-key
  :ensure t
  :straight t
  :config (which-key-mode))

;; **Minibuffer completion**
(use-package vertico
  ;; vertico: completion engine
  :ensure t
  :straight t
  :bind (:map vertico-map
	      ("C-l" . 'vertico-directory-up))
  :init (vertico-mode))
(use-package marginalia
  ;; marginalia: show more information
  :after vertico
  :ensure t
  :straight t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy
			   marginalia-annotators-light
			   nil))
  :init
  (marginalia-mode))
(use-package orderless
  ;; orderless: text-completion in orderless manner
  :ensure t
  :straight t
  :config (setq completion-styles '(orderless)))

;; **Show line numbers**
(global-display-line-numbers-mode t)

;;; # Languages
;; **Common-Lisp**
(use-package slime
  :if (executable-find "sbcl")
  :ensure t
  :straight t
  :config
  (setq inferior-lisp-program "sbcl"))
(use-package slime-company
  :after (slime company)
  :ensure t
  :straight t
  :init
  (slime-setup '(slime-fancy slime-company))
  :config
  (setq slime-company-completion 'fuzzy
	slime-company-after-completion 'slime-company-just-one-space))

