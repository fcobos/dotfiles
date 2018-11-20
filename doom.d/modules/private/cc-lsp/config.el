;;; private/cc-lsp/config.el -*- lexical-binding: t; -*-

(def-package! lsp-mode
  :commands (lsp-mode lsp-define-stdio-client)
  :init
  (setq lsp-response-timeout 30
        lsp-eldoc-render-all nil
        lsp-enable-completion-at-point t))

(def-package! cquery
  :hook ((c-mode c++-mode objc-mode) . lsp-cquery-enable)
  :init
  (setq cquery-executable (concat doom-etc-dir "cquery/bin/cquery"))
  (setq cquery-extra-init-params '(:index (:comments 2) :cacheFormat "msgpack" :completion (:detailedLabel t)))
  :config
  (setq cquery-sem-highlight-method 'font-lock)
  (add-hook 'c-mode-hook 'flycheck-mode)
  (add-hook 'c++-mode-hook 'flycheck-mode)
  (add-hook 'objc-mode-hook 'flycheck-mode)
  (when (featurep 'evil)
    (add-hook 'lsp-mode-hook #'evil-normalize-keymaps))
  (map! :map (c-mode-map c++-mode-map objc-mode-map)
        :m  "gd" #'lsp-ui-peek-find-definitions
        :m  "gD" #'lsp-ui-peek-find-references
        :localleader
        (:desc "help"
          :prefix "h"
          :n "."  #'lsp-describe-thing-at-point)
        (:desc "goto"
          :prefix "g"
          :n "d" #'lsp-ui-peek-find-definitions
          :n "i" #'lsp-goto-implementation))
  ;; don't highlight references of the symbol at point
  (defun lsp-document-highlight ()))

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
        lsp-ui-sideline-enable nil
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
