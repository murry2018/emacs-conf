(require 'custom-packages)

(init-for ivy
  (ivy-mode t)
  (keymap-global-set "C-c C-r" 'ivy-resume))
(setopt ivy-use-virtual-buffers t
        enable-recursive-minibuffers t)

(init-for counsel
  (counsel-mode t))

(init-for swiper
  (keymap-global-set "C-s" 'swiper))

(provide 'custom-ivy)
