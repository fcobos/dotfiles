;;; private/cc-lsp/config.el -*- lexical-binding: t; -*-

(defvar +cc-default-include-paths (list "include/")
  "A list of default paths, relative to a project root, to search for headers in
C/C++. Paths can be absolute. This is ignored if your project has a compilation
database.")

(defvar +cc-default-header-file-mode 'c-mode
  "Fallback major mode for .h files if all other heuristics fail (in
`+cc-c-c++-objc-mode').")

(defvar +cc-default-compiler-options
  `((c-mode . nil)
    (c++-mode
     . ,(list "-std=c++1z" ; use C++17 draft by default
              (when IS-MAC
                ;; NOTE beware: you'll get abi-inconsistencies when passing
                ;; std-objects to libraries linked with libstdc++ (e.g. if you
                ;; use boost which wasn't compiled with libc++)
                "-stdlib=libc++")))
    (objc-mode . nil))
  "A list of default compiler options for the C family. These are ignored if a
compilation database is present in the project.")


;;
;; Packages

(def-package! cc-mode
  :commands (c-mode c++-mode objc-mode java-mode)
  :mode ("\\.mm\\'" . objc-mode)
  :init
  (setq-default c-basic-offset tab-width
                c-backspace-function #'delete-backward-char
                c-default-style "doom")

  ;; The plusses in c++-mode can be annoying to search for ivy/helm (which reads
  ;; queries as regexps), so we add these for convenience.
  (defalias 'cpp-mode 'c++-mode)
  (defvaralias 'cpp-mode-map 'c++-mode-map)

  ;; Activate `c-mode', `c++-mode' or `objc-mode' depending on heuristics
  (add-to-list 'auto-mode-alist '("\\.h\\'" . +cc-c-c++-objc-mode))

  :config
  (set-electric! '(c-mode c++-mode objc-mode java-mode) :chars '(?\n ?\} ?\{))
  (set-docsets! 'c-mode "C")
  (set-docsets! 'c++-mode "C++" "Boost")

  (set-rotate-patterns! 'c++-mode
    :symbols '(("public" "protected" "private")
               ("class" "struct")))

  (set-pretty-symbols! '(c-mode c++-mode)
    ;; Functional
    ;; :def "void "
    ;; Types
    :null "nullptr"
    :true "true" :false "false"
    :int "int" :float "float"
    :str "std::string"
    :bool "bool"
    ;; Flow
    :not "!"
    :and "&&" :or "||"
    :for "for"
    :return "return"
    :yield "#require")

  ;;; Better fontification (also see `modern-cpp-font-lock')
  (add-hook 'c-mode-common-hook #'rainbow-delimiters-mode)
  (add-hook! '(c-mode-hook c++-mode-hook) #'+cc|fontify-constants)

  (setq-hook! 'c-mode-common-hook electric-indent-inhibit nil)

  ;; Custom style, based off of linux
  (unless (assoc "doom" c-style-alist)
    (push '("doom"
            (c-basic-offset . tab-width)
            (c-comment-only-line-offset . 0)
            (c-hanging-braces-alist (brace-list-open)
                                    (brace-entry-open)
                                    (substatement-open after)
                                    (block-close . c-snug-do-while)
                                    (arglist-cont-nonempty))
            (c-cleanup-list brace-else-brace)
            (c-offsets-alist
             (knr-argdecl-intro . 0)
             (substatement-open . 0)
             (substatement-label . 0)
             (statement-cont . +)
             (case-label . +)
             ;; align args with open brace OR don't indent at all (if open
             ;; brace is at eolp and close brace is after arg with no trailing
             ;; comma)
             (brace-list-intro . 0)
             (brace-list-close . -)
             (arglist-intro . +)
             (arglist-close +cc-lineup-arglist-close 0)
             ;; don't over-indent lambda blocks
             (inline-open . 0)
             (inlambda . 0)
             ;; indent access keywords +1 level, and properties beneath them
             ;; another level
             (access-label . -)
             (inclass +cc-c++-lineup-inclass +)
             (label . 0)))
          c-style-alist))

  ;;; Keybindings
  ;; Smartparens and cc-mode both try to autoclose angle-brackets intelligently.
  ;; The result isn't very intelligent (causes redundant characters), so just do
  ;; it ourselves.
  (define-key! c++-mode-map "<" nil ">" nil)
  ;; ...and leave it to smartparens
  (sp-with-modes '(c++-mode objc-mode)
    (sp-local-pair "<" ">"
                   :when '(+cc-sp-point-is-template-p +cc-sp-point-after-include-p)
                   :post-handlers '(("| " "SPC"))))

  (sp-with-modes '(c-mode c++-mode objc-mode java-mode)
    (sp-local-pair "/*!" "*/" :post-handlers '(("||\n[i]" "RET") ("[d-1]< | " "SPC")))))


(def-package! modern-cpp-font-lock
  :hook (c++-mode . modern-c++-font-lock-mode))

;;
;; Major modes

(def-package! company-cmake  ; for `cmake-mode'
  :when (featurep! :completion company)
  :after cmake-mode
  :config (set-company-backend! 'cmake-mode 'company-cmake))


(def-package! demangle-mode
  :hook llvm-mode)


(def-package! company-glsl  ; for `glsl-mode'
  :when (featurep! :completion company)
  :after glsl-mode
  :config (set-company-backend! 'glsl-mode 'company-glsl))


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
