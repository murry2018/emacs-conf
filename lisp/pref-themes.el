(defun pref-light-theme ()
  (interactive)
  (mapcan #'disable-theme custom-enabled-themes)
  (if (require 'modus-themes nil t)
      (load-theme 'modus-operandi-tinted)
    (load-theme 'tango)))

(defun pref-dark-theme ()
  (interactive)
  (mapcan #'disable-theme custom-enabled-themes)
  (if (require 'color-theme-sanityinc-tomorrow nil t)
      (progn 
        (load-theme 'sanityinc-tomorrow-night)
        (pref--postprocess-tomorrow-dark))
    (load-theme 'tango-dark)))

(defun pref--postprocess-tomorrow-dark ()
  ;; No strike-through
  (set-face-attribute 'org-headline-done nil
                      :strike-through nil
                      :foreground "#969696"
                      :background "#333333"))

(provide 'pref-themes)
