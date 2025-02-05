;;; initailize `customize'
(setopt custom-file
	(expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;; visual options

;;;; Set fill-column and turn indicator on
(setopt fill-column 80)                 ; default: 72
(global-display-fill-column-indicator-mode)

;;;; turn off scrollbar and toolbar
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;;;; frame background (for dark background terminal)
(when (not (display-graphic-p))
  (setopt frame-background-mode 'dark)
  ;; You can uncomment the below line if you need debugging. 
  ;; (debug-on-variable-change 'frame-background-mode)
  (mapc 'frame-set-background-mode (frame-list)))

;;; Elisp appearance
(put 'setopt 'lisp-indent-function 1)
(put 'add-hook 'lisp-indent-function 1)
(put 'add-to-list 'lisp-indent-function 1)
(put ':map 'lisp-indent-function 1)
(put 'advice-add 'lisp-indent-function 1)

;;; Encoding
(prefer-coding-system 'utf-8)

;;; modes

;;;; ibuffer :yes
(keymap-global-set "C-x C-b" 'ibuffer)

;;;; electric-pair-mode :yes
;; auto-close parenthesis
(electric-pair-mode t)

;;;; display-line-numbers-mode :only on file-backed buffers
(defun pref--enable-line-numbers ()
  "Turn on `display-line-numbers-mode' only when the buffer is
visiting a file"
  (when buffer-file-name
    (display-line-numbers-mode 1)))

(add-hook 'after-change-major-mode-hook
  ;; "Is there an Emacs hook that runs after every buffer is created?"
  ;; "Unfortunately, no"
  ;; - https://stackoverflow.com/a/7900156
  #'pref--enable-line-numbers)

;;;; show-paren-mode :yes
;; highlight matching parens
(show-paren-mode t)
(setopt show-paren-when-point-inside-paren t)

;;;; save-place-mode :yes
;; [when you visit a file, point goes to the last place ...]
(save-place-mode t)

;;;; recentf-mode :yes
;; [maintains a list of recently opened files...]
(recentf-mode t)

;;;; savehist-mode :yes
;; save minibuffer history
(savehist-mode t)

;;;; global-subword-mode :yes
;; ride on CamelCase words
(global-subword-mode t)

;;;; blink-cursor-mode :no
;; Don't Blink
(blink-cursor-mode -1)

;;;; dired-extra :yes
;; enable dired-do-* commands
(require 'dired-x)

;;; variables
(setopt
    ;; ask y/n instead of yes/no
    use-short-answers t
    
    ;; tab width = 4
    tab-width 4
    c-basic-offset 4
    
    ;; focus to help window when open
    help-window-select t
    
    ;; sentences are end with period, and single space
    ;; It affects M-e(`forward-sentence') or M-a(`backward-sentence').
    sentence-end-without-period nil
    sentence-end-double-space nil
    
    ;; mouse yank commands yank at point instead of at click.
    mouse-yank-at-point t
    
    ;; draw block cursor as wide as the glyph under it
    x-stretch-cursor t
    
    ;; construct unique buffer name like 'bar/mumble/name'
    ;; rather than like 'name<bar/mumble>'
    uniquify-buffer-name-style 'forward
    
    ;; resize window combinations proportionally
    window-combination-resize t

    ;; [Toggle whether indentation can insert TAB characters.]
    indent-tabs-mode nil

    ;; Show directory first in dired
    ls-lisp-dirs-first t

    ;; flash screen instead of beeping
    visible-bell t
    )

;; Eldoc for IELM
(add-hook 'ielm-mode-hook 'eldoc-mode)

(provide 'pref-defaults)
