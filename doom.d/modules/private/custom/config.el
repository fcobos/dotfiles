;; Custom keybindings
(add-hook! 'after-init-hook
  (map!
    (:leader
      :desc "M-x" :n "SPC" #'execute-extended-command)))

;; pipenv config
(use-package pipenv
  :hook (python-mode . pipenv-mode))

;; fill column indicator
(def-package! fill-column-indicator
  :after-call doom-before-switch-buffer-hook
  :config
  (defvar-local company-fci-mode-on-p nil)

  (defun company-turn-off-fci (&rest ignore)
    (setq company-fci-mode-on-p fci-mode)
    (when fci-mode (fci-mode -1)))

  (defun company-maybe-turn-on-fci (&rest ignore)
    (when company-fci-mode-on-p (fci-mode 1)))

  (add-hook 'company-completion-started-hook #'company-turn-off-fci)
  (add-hook 'company-completion-finished-hook #'company-maybe-turn-on-fci)
  (add-hook 'company-completion-cancelled-hook #'company-maybe-turn-on-fci))

