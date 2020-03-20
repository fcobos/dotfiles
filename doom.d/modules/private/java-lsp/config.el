;;; private/java/config.el -*- lexical-binding: t; -*-

(use-package! lsp-mode
  :commands (lsp-mode lsp-define-stdio-client)
  :init
  (setq lsp-response-timeout 30
        lsp-eldoc-render-all nil
        lsp-auto-guess-root t
        lsp-keep-workspace-alive nil
        lsp-session-file (concat doom-etc-dir "lsp-session")
        lsp-enable-completion-at-point t))

(use-package! lsp-java
  :init
  (add-hook 'java-mode-hook #'lsp)
  (setq lsp-java-server-install-dir (concat doom-etc-dir "eclipse.jdt.ls/server/")
        lsp-java-workspace-dir (concat doom-local-dir "java-workspace/")
        lsp-java-workspace-cache-dir (concat lsp-java-workspace-dir ".cache/"))
  :config
  (add-hook 'java-mode-hook 'flycheck-mode))

(use-package! lsp-ui
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

(use-package! company-lsp
  :after lsp-mode
  :config
  (set-company-backend! 'lsp-mode '(company-lsp))
  (setq company-lsp-cache-candidates t
        company-lsp-enable-snippet t
        company-lsp-async t
        company-lsp-enable-recompletion t))

(use-package! dap-mode
  :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(use-package! dap-java
  :after lsp-java)

(after! lsp-java
  (when (featurep 'evil)
    (add-hook 'lsp-mode-hook #'evil-normalize-keymaps))
  (map! :map java-mode-map
        :n   "K"  #'lsp-describe-thing-at-point
        :nv  "gd" #'lsp-ui-peek-find-definitions
        :nv  "gD" #'lsp-ui-peek-find-references
        :localleader
        (:prefix ("r" . "Refactor")
          :desc "Add import"
          :n "i" #'lsp-java-add-import
          :desc "Add unimplemented methods"
          :n "u" #'lsp-java-add-unimplemented-methods
          :desc "Create field"
          :n "e" #'lsp-java-create-field
          :desc "Create local"
          :n "l" #'lsp-java-create-local
          :desc "Create parameter"
          :n "p" #'lsp-java-create-parameter
          :desc "Extract to constant"
          :n "c" #'lsp-java-extract-to-constant
          :desc "Extract method"
          :n "m" #'lsp-java-extract-method
          :desc "Organize imports"
          :n "o" #'lsp-java-organize-imports
          :desc "Format buffer"
          :n "f"  #'lsp-format-buffer
          :desc "Rename"
          :n "r"  #'lsp-rename)
        (:prefix ("h" . "Help")
          :desc "Describe thing at point"
          :n "."  #'lsp-describe-thing-at-point)
        (:prefix ("g" . "Navigation")
          :desc "Go to type definition"
          :n "d" #'lsp-goto-type-definition
          :desc "Go to implementation"
          :n "i" #'lsp-goto-implementation)
        (:prefix ("d" . "Debug")
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
        (:prefix ("b" . "Build")
          :desc "Build project"
          :n "b"  #'lsp-java-build-project
          :desc "Update project configuration"
          :n "u"  #'lsp-update-project-configuration))
  (local-set-key (kbd "<f5>") 'dap-next)
  (local-set-key (kbd "<f6>") 'dap-step-in)
  (local-set-key (kbd "<f7>") 'dap-step-out))
