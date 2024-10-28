;;; ido-mode
;; References:
;; 1. https://www.masteringemacs.org/article/introduction-to-ido-mode
;; 2. https://stackoverflow.com/questions/25903024/ido-completion-map-keys-not-working-when-ergoemacs-is-enable
(ido-mode t)
(setopt 
    ido-everywhere t
    ido-enable-flex-matching t
    ;; C-x C-f on filename string
    ido-use-filename-at-point 'guess
    ;; disable ido auto merge
    ido-auto-merge-work-directories-length -1)
(add-hook 'ido-setup-hook
  (lambda ()
    (keymap-set ido-completion-map
                "TAB" 'ido-exit-minibuffer)
    (keymap-set ido-completion-map
                "C-n" 'ido-next-match)
    (keymap-set ido-completion-map
                "C-p" 'ido-prev-match)))

;;; fido-mode
(fido-vertical-mode t)

;;; ibuffer
(keymap-global-set "C-x C-b" 'ibuffer)

;;; isearch
;; References:
;; 1. https://emacs.dyerdwelling.family/emacs/20230503211610-emacs--isearch-occur-advice-window-focus/
;; 2. https://blog.chmouel.com/posts/emacs-isearch/
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; initial focus in `isearch-occur' buffer
(advice-add
    'isearch-occur :after
    (lambda (origin &rest args)
      (isearch-exit)
      (select-window (get-buffer-window "*Occur*"))
      (goto-char (point-min))))

;; [C-o] to open `isearch-occur' during isearch
;; (originally [M-s o])
(keymap-set isearch-mode-map
            "C-o" 'isearch-occur)
;; [C-n] and [C-p] to move between isearch-occur results
(keymap-set occur-mode-map
            "C-n" 'next-error-no-select)
(keymap-set occur-mode-map
            "C-p" 'previous-error-no-select)

(provide 'custom-minibuffer)
