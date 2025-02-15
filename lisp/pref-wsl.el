(defun pref-on-wsl-p ()
  "Verify that this Emacs is running on top of the WSL.

Returns non-nil if WSL, otherwise non-nil."
  (and
   (eq system-type 'gnu/linux)
   (or
    ;; In most case, this line will be sufficient
    (getenv "WSL_DISTRO_NAME")
    ;; thanks to https://superuser.com/questions/1749781/how-can-i-check-if-the-environment-is-wsl-from-a-shell-script
    (string-match-p "microsoft" (shell-command-to-string "uname -a"))
    (file-exists-p "/etc/wsl.conf")
    (file-exists-p "/proc/sys/fs/binfmt_misc/WSLInterop"))))

(defun pref--wslu-installed-p ()
  "Verify that `wslu' is installed

Note: `wslview' is one of utilities from `wslu'"
  (executable-find "wslview"))

(defun pref--recommend-wslu ()
  "Print recommendation message to install `wslu'"
  (unless (pref--wslu-installed-p)
    (message "Installing `wslu' is highly recommended.")))

(defun pref--set-browser ()
  "Make `browse-url' open link via `wslview' or `cmd'.

This affects link opening action, such as `org-open-at-point'."
  (if (pref--wslu-installed-p)
      (setq browse-url-generic-program "wslview"
            browse-url-browser-function 'browse-url-generic)
    (progn
      (let ((cmd-exe "/mnt/c/Windows/System32/cmd.exe")
            (cmd-args '("/c" "start")))
        (when (file-exists-p cmd-exe)
          (setq browse-url-generic-program  cmd-exe
                browse-url-generic-args     cmd-args
                browse-url-browser-function 'browse-url-generic))))))

(when (pref-on-wsl-p)
  (pref--recommend-wslu)
  (pref--set-browser))

(provide 'pref-wsl)
