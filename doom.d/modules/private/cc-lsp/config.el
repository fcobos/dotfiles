;;; private/cc-lsp/config.el -*- lexical-binding: t; -*-

(def-package! lsp-mode
  :commands (lsp-mode lsp-define-stdio-client)
  :init
  (setq lsp-response-timeout 30
        lsp-eldoc-render-all nil
        lsp-auto-guess-root t
        lsp-keep-workspace-alive nil
        lsp-session-file (concat doom-etc-dir "lsp-session")
        lsp-enable-completion-at-point t))

(def-package! ccls
  :defer t
  :hook ((c-mode c++-mode cuda-mode objc-mode) . (lambda () (require 'ccls) (lsp)))
  :init
  (setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t)))
  :config
  (setq ccls-sem-highlight-method 'font-lock)
  (add-to-list 'projectile-globally-ignored-directories ".ccls-cache")
  ;;(evil-set-initial-state 'ccls-tree-mode 'emacs)

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
        :leader
        (:prefix ("c" . "code")
          :desc "Jump to references"          "D"   #'lsp-ui-peek-find-references
          :desc "Jump to definition"          "d"   #'lsp-ui-peek-find-definitions)
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

(def-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (set-lookup-handlers! 'lsp-ui-mode
    :documentation #'lsp-describe-thing-at-point
    :definition #'lsp-ui-peek-find-definitions
    :references #'lsp-ui-peek-find-references)
  (setq lsp-ui-doc-max-height 8
        lsp-ui-doc-max-width 35
        lsp-ui-sideline-ignore-duplicate t
        ;;lsp-ui-sideline-enable nil
        lsp-ui-doc-enable nil))

(def-package! company-lsp
  :after lsp-mode
  :config
  (set-company-backend! '(c-mode c++-mode cuda-mode objc-mode) '(company-lsp))
  (setq company-lsp-cache-candidates nil
        company-transformers nil
        company-lsp-enable-snippet t
        company-lsp-async t
        company-lsp-enable-recompletion t))
