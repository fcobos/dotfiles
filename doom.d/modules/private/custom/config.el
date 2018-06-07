;; Custom keybindings
(add-hook! 'after-init-hook
  (map!
    (:leader
      :desc "M-x" :n "SPC" #'execute-extended-command)))

;; pipenv config
(use-package pipenv
  :hook (python-mode . pipenv-mode))

