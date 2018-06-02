;; Custom keybindings
(add-hook! 'after-init-hook
  (map!
    (:leader
      :desc "M-x" :n "SPC" #'execute-extended-command)))

