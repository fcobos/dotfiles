;;; private/cc-lsp/config.el -*- lexical-binding: t; -*-

(def-package! lsp-mode
  :commands (lsp-mode lsp-define-stdio-client)
  :init
  (setq lsp-response-timeout 30
        lsp-eldoc-render-all nil
        lsp-enable-completion-at-point t))

(def-package! ccls
  :defer t
  :hook ((c-mode c++-mode cuda-mode objc-mode) . (lambda () (require 'ccls) (lsp)))
  :init
  ;;(setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t)))
  (setq ccls-initialization-options
   '(:clang
     (:excludeArgs
      ;; Linux's gcc options. See ccls/wiki
      ["-falign-jumps=1" "-falign-loops=1" "-fconserve-stack" "-fmerge-constants" "-fno-code-hoisting" "-fno-schedule-insns" "-fno-var-tracking-assignments" "-fsched-pressure"
       "-mhard-float" "-mindirect-branch-register" "-mindirect-branch=thunk-inline" "-mpreferred-stack-boundary=2" "-mpreferred-stack-boundary=3" "-mpreferred-stack-boundary=4" "-mrecord-mcount" "-mindirect-branch=thunk-extern" "-mno-fp-ret-in-387" "-mskip-rax-setup"
       "--param=allow-store-data-races=0" "-Wa arch/x86/kernel/macros.s" "-Wa -"]
      :extraArgs ["--gcc-toolchain=/usr"]
      :pathMappings ,+ccls-path-mappings)
     :completion
     (:include
      (:blacklist
       ["^/usr/(local/)?include/c\\+\\+/[0-9\\.]+/(bits|tr1|tr2|profile|ext|debug)/"
        "^/usr/(local/)?include/c\\+\\+/v1/"
        ]))
     :index (:initialBlacklist ,+ccls-initial-blacklist :trackDependency 1)))
  :config
  (setq ccls-sem-highlight-method 'font-lock)
  (add-to-list 'projectile-globally-ignored-directories ".ccls-cache")
  ;;(evil-set-initial-state 'ccls-tree-mode 'emacs)

  (add-hook 'c-mode-hook 'flycheck-mode)
  (add-hook 'c++-mode-hook 'flycheck-mode)
  (add-hook 'objc-mode-hook 'flycheck-mode)
  (when (featurep 'evil)
    (add-hook 'lsp-mode-hook #'evil-normalize-keymaps))
  (map! :map (c-mode-map c++-mode-map objc-mode-map)
        :m  "gd" #'lsp-ui-peek-find-definitions
        :m  "gD" #'lsp-ui-peek-find-references
        :localleader
        (:desc "Help"
          :prefix "h"
          :desc "Describe thing at point"
          :n "."  #'lsp-describe-thing-at-point)
        (:desc "Navigation"
          :prefix "g"
          :desc "Find definitions"
          :n "d" #'lsp-ui-peek-find-definitions
          :desc "Go to implementation"
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
