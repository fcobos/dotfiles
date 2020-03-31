;;; private/cc-lsp/config.el -*- lexical-binding: t; -*-

(after! cc-mode
  (add-hook 'c-mode-hook 'flycheck-mode)
  (add-hook 'c++-mode-hook 'flycheck-mode)
  (add-hook 'objc-mode-hook 'flycheck-mode)
  (set-lookup-handlers! '(c-mode c++-mode objc-mode)
    :documentation #'lsp-describe-thing-at-point
    :definition #'lsp-ui-peek-find-definitions
    :references #'lsp-ui-peek-find-references)
  (when (featurep 'evil)
    (add-hook 'lsp-mode-hook #'evil-normalize-keymaps))
  (map! :map (c-mode-map c++-mode-map objc-mode-map)
        :n   "K"  #'lsp-describe-thing-at-point
        :nv  "gd" #'lsp-ui-peek-find-definitions
        :nv  "gD" #'lsp-ui-peek-find-references
        :localleader
        (:desc "Help"
          :prefix "h"
          :desc "Describe thing at point"
          :n "."  #'lsp-describe-thing-at-point)
        (:desc "Navigation"
          :prefix "g"
          :desc "Find definitions"
          :n "d" #'lsp-ui-peek-find-definitions
          :desc "Find references"
          :n "D" #'lsp-ui-peek-find-references
          :desc "Go to implementation"
          :n "i" #'lsp-goto-implementation)))
