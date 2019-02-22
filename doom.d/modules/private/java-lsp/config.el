;;; private/java/config.el -*- lexical-binding: t; -*-

(def-package! lsp-mode
  :commands (lsp-mode lsp-define-stdio-client)
  :init
  (setq lsp-response-timeout 30
        lsp-eldoc-render-all nil
        lsp-enable-completion-at-point t))

(def-package! lsp-java
  :init
  (add-hook 'java-mode-hook #'lsp)
  (setq lsp-java-server-install-dir (concat doom-etc-dir "eclipse.jdt.ls/server/")
        lsp-java-workspace-dir (concat doom-local-dir "java-workspace/")
        lsp-java-workspace-cache-dir (concat lsp-java-workspace-dir ".cache/"))
  :config
  (add-hook 'java-mode-hook 'flycheck-mode))

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
        (:desc "Refactor"
          :prefix "r"
          :desc "Add import"
          :n "ai" #'lsp-java-add-import
          :desc "Add unimplemented methods"
          :n "au" #'lsp-java-add-unimplemented-methods
          :desc "Create field"
          :n "cf" #'lsp-java-create-field
          :desc "Create local"
          :n "cl" #'lsp-java-create-local
          :desc "Create parameter"
          :n "cp" #'lsp-java-create-parameter
          :desc "Extract to constant"
          :n "ec" #'lsp-java-extract-to-constant
          :desc "Extract method"
          :n "em" #'lsp-java-extract-method
          :desc "Organize imports"
          :n "oi" #'lsp-java-organize-imports
          :desc "Format buffer"
          :n "f"  #'lsp-format-buffer
          :desc "Rename"
          :n "r"  #'lsp-rename)
        (:desc "Help"
          :prefix "h"
          :desc "Describe thing at point"
          :n "."  #'lsp-describe-thing-at-point)
        (:desc "Navigation"
          :prefix "g"
          :desc "Go to type definition"
          :n "d" #'lsp-goto-type-definition
          :desc "Go to implementation"
          :n "i" #'lsp-goto-implementation)
        (:desc "Debugging"
          :prefix "d"
          :desc "Toggle breakpoint"
          :n "k" #'dap-breakpoint-toggle
          :desc "Eval"
          :n "e" #'dap-eval
          :desc "Eval thing at point"
          :n "." #'dap-eval-thing-at-point
          :desc "Debug"
          :n "d" #'dap-java-debug
          :desc "Show locals"
          :n "l" #'dap-ui-locals
          :desc "REPL"
          :n "r" #'dap-ui-repl
          :desc "Show sessions"
          :n "s" #'dap-ui-sessions
          :desc "Run test method"
          :n "t" #'dap-java-run-test-method
          :desc "Debug test method"
          :n "m" #'dap-java-debug-test-method
          :desc "Run test class"
          :n "c" #'dap-java-run-test-class
          :desc "Debug test class"
          :n "x" #'dap-java-debug-test-class)
        (:desc "Build"
          :prefix "b"
          :desc "Build project"
          :n "b"  #'lsp-java-build-project
          :desc "Update project configuration"
          :n "u"  #'lsp-update-project-configuration))
  (local-set-key (kbd "<f5>") 'dap-next)
  (local-set-key (kbd "<f6>") 'dap-step-in)
  (local-set-key (kbd "<f7>") 'dap-step-out))
