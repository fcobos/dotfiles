;;; private/java/config.el -*- lexical-binding: t; -*-

(def-package! lsp-mode
;;  :commands (lsp-mode lsp-define-stdio-client)
  :init
  (setq lsp-eldoc-render-all nil
        lsp-enable-completion-at-point t
        lsp-highlight-symbol-at-point nil))

(def-package! lsp-java
  :hook (java-mode . lsp-java-enable)
  :config
  (add-hook 'java-mode-hook 'flycheck-mode))

(def-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (set-lookup-handlers! 'lsp-ui-mode
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
  (set-company-backend! 'lsp-mode '(company-lsp))
  (setq company-lsp-cache-candidates t
        company-lsp-enable-snippet t
        company-lsp-async t
        company-lsp-enable-recompletion t))

(def-package! dap-mode
  :after lsp-mode
  :config
  (dap-mode t)
  (dap-mode-ui t))

(def-package! dap-java
  :after lsp-java)
