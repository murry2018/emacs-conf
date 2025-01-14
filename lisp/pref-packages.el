;; functions:
;; - pref-install-packages
;; - pref-ensure-package
;; - init-for

;;; initialize melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; 
(defvar *required-packages*
  '(s
    company
    flycheck
    ace-window
    which-key
    avy
    ivy
    swiper
    counsel
    paredit
    markdown-mode
    json-mode
    smartparens
    imenu-list))
(defvar *additional-packages*
  '(modus-themes
    slime
    slime-company
    magit
    rg))

(defun pref-install-packages (opt)
  (interactive
   (list (completing-read
          "Install option[default: minimal] "
          '("minimal" "all")
          nil
          t
          ""
          t
          "minimal")))
  (when (not package-archive-contents)
    (package-refresh-contents))
  (message "Installing %s packages" opt)
  (mapc 'package-install
	    *required-packages*)
  (when (string-equal-ignore-case opt "all")
    (mapc 'package-install
          *additional-packages*))
  t)

;;; package-related definitions
(defun pref-ensure-package (package)
  "install package, if not installed"
  (when (not (package-installed-p package))
    (when (not package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

(defmacro init-for (package &rest body)
  "with installed package do whatever.
If given package is not installed, do nothing."
  `(when (package-installed-p ',package)
     (add-hook 'after-init-hook
	       (lambda ()
		 (progn
		   ,@body)))))
(put 'init-for 'lisp-indent-function 1)

(provide 'pref-packages)
