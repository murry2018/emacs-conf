(require 'pref-packages)

(init-for ivy
  (ivy-mode t)
  (keymap-global-set "C-c C-r" 'ivy-resume)
  (keymap-set ivy-minibuffer-map "<return>" 'ivy-alt-done)
  (keymap-set ivy-occur-grep-mode-map "C-n" 'next-error-no-select)
  (keymap-set ivy-occur-grep-mode-map "C-p" 'previous-error-no-select))
(setopt ivy-use-virtual-buffers 'recentf
        enable-recursive-minibuffers t
        ivy-magic-tilde nil)

(init-for counsel
  (counsel-mode t))

(init-for swiper
  (keymap-global-set "C-s" 'swiper)
  (keymap-global-set "C-M-s" 'swiper-all))

(provide 'pref-ivy)
