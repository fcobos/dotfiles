;; Custom keybindings
(add-hook! 'after-init-hook
  (map!
    (:leader
      :desc "M-x" :n "SPC" #'execute-extended-command
      (:desc "code" :prefix "c"
        :desc "Format buffer" :n "f" #'format-all-buffer))))

;; pipenv config
(use-package pipenv
  :hook (python-mode . pipenv-mode))

