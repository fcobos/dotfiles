;;; private/java/config.el -*- lexical-binding: t; -*-

(def-package! lsp-mode
  :commands (lsp-mode lsp-define-stdio-client)
  :init
  (setq lsp-response-timeout 30
        lsp-eldoc-render-all nil
        lsp-enable-completion-at-point t))

(def-package! lsp-java
  :hook (java-mode . lsp-java-enable)
  :init
  (setq lsp-java-server-install-dir (concat doom-etc-dir "eclipse.jdt.ls/server/")
        lsp-java-workspace-dir (concat doom-local-dir "java-workspace/")
        lsp-java-workspace-cache-dir (concat lsp-java-workspace-dir ".cache/"))
  :config
  (add-hook 'java-mode-hook 'flycheck-mode)
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
  (set-company-backend! 'lsp-mode '(company-lsp))
  (setq company-lsp-cache-candidates t
        company-lsp-enable-snippet t
        company-lsp-async t
        company-lsp-enable-recompletion t))

(def-package! dap-mode
  :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(def-package! dap-java
  :after lsp-java)

(after! lsp-java
  (set-docsets! 'java-mode "Java" "Java EE8")
  (when (featurep 'evil)
    (add-hook 'lsp-mode-hook #'evil-normalize-keymaps))
  (map! :map java-mode-map
        :localleader
        (:prefix "r"
          :n "ai" #'lsp-java-add-import
          :n "au" #'lsp-java-add-unimplemented-methods
          :n "cf" #'lsp-java-create-field
          :n "cl" #'lsp-java-create-local
          :n "cp" #'lsp-java-create-parameter
          :n "ec" #'lsp-java-extract-to-constant
          :n "em" #'lsp-java-extract-method
          :n "oi" #'lsp-java-organize-imports
          :n "f"  #'lsp-format-buffer
          :n "r"  #'lsp-rename)
        (:prefix "h"
          :n "."  #'lsp-describe-thing-at-point)
        (:prefix "g"
          :n "d" #'lsp-goto-type-definition
          :n "i" #'lsp-goto-implementation)
        (:prefix "d"
          :n "k" #'dap-breakpoint-toggle
          :n "e" #'dap-eval
          :n "." #'dap-eval-thing-at-point
          :n "d" #'dap-java-debug
          :n "l" #'dap-ui-locals
          :n "r" #'dap-ui-repl
          :n "s" #'dap-ui-sessions
          :n "t" #'dap-java-run-test-method
          :n "m" #'dap-java-debug-test-method
          :n "c" #'dap-java-run-test-class
          :n "x" #'dap-java-debug-test-class)
        (:prefix "b"
          :n "b"  #'lsp-java-build-project
          :n "u"  #'lsp-update-project-configuration))
  (local-set-key (kbd "<f5>") 'dap-next)
  (local-set-key (kbd "<f6>") 'dap-step-in)
  (local-set-key (kbd "<f7>") 'dap-step-out))
