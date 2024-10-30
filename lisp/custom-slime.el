;; functions:
;; - custom-add-slime-filename-translation

;; make slime contribs list, for `slime-setup'
(defvar *slime-contribs* '(slime-fancy slime-tramp))
(when (package-installed-p 'slime-company)
  (add-to-list '*slime-contribs* 'slime-company t))

(when (require 'slime-autoloads nil t)
  ;; `slime-setup' should come before everything else
  (slime-setup *slime-contribs*)
  
  (setopt
    inferior-lisp-program "sbcl"
    slime-company-completion 'fuzzy
    slime-company-after-completion 'slime-company-just-one-space))
  
(defun custom-add-slime-filename-translation (machine-instance host username)
  (when (require 'slime-tramp nil t)
    (add-to-list 'slime-filename-translations
      (slime-create-filename-translator :machine-instance machine-instance
                                        :remote-host host
                                        :username username))))

(provide 'custom-slime)
