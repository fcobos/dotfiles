;;; private/go-custom/config.el -*- lexical-binding: t; -*-

;; go configuration
(after! go-mode
  ;; use gogetdoc for go documentation
  (setq godoc-at-point-function #'godoc-gogetdoc)

  ;; format go buffers on save
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook #'gofmt-before-save)

  ;; lookup handlers
  (set-lookup-handlers! 'go-mode
    :definition #'lsp-ui-peek-find-definitions
    :references #'lsp-ui-peek-find-references
    :documentation #'godoc-at-point)

  ;; font lock
  (defconst go-basic-types
    '("bool" "string" "int" "int8" "int16" "int32" "int64"
      "uint" "uint8" "uint16" "uint32" "uint64" "uintptr"
      "rune" "float32" "float64" "complex64" "complex128"))

  (defun go--build-font-lock-keywords ()
    ;; we cannot use 'symbols in regexp-opt because GNU Emacs <24
    ;; doesn't understand that
    (append
     `((go--match-func
        ,@(mapcar (lambda (x) `(,x font-lock-type-face))
                  (number-sequence 1 go--font-lock-func-param-num-groups)))
       (,(concat "\\_<" (regexp-opt go-mode-keywords t) "\\_>") . font-lock-keyword-face)
       (,(concat "\\(\\_<" (regexp-opt go-builtins t) "\\_>\\)[[:space:]]*(") 1 font-lock-builtin-face)
       (,(concat "\\_<" (regexp-opt go-constants t) "\\_>") . font-lock-constant-face)
       (,(concat "\\_<" (regexp-opt go-basic-types t) "\\_>") . font-lock-type-face)
       (,go-func-regexp 1 font-lock-function-name-face)) ;; function (not method) name

     (if go-fontify-function-calls
         `((,(concat "\\(" go-identifier-regexp "\\)[[:space:]]*(") 1 font-lock-function-name-face) ;; function call/method name
           (,(concat "[^[:word:][:multibyte:]](\\(" go-identifier-regexp "\\))[[:space:]]*(") 1 font-lock-function-name-face)) ;; bracketed function call
       `((,go-func-meth-regexp 2 font-lock-function-name-face))) ;; method name

     `(
       ("\\(`[^`]*`\\)" 1 font-lock-multiline) ;; raw string literal, needed for font-lock-syntactic-keywords
       (,(concat "\\_<type\\_>[[:space:]]+\\([^[:space:](]+\\)") 1 font-lock-type-face) ;; types
       (,(concat "\\_<type\\_>[[:space:]]+" go-identifier-regexp "[[:space:]]*" go-type-name-regexp) 1 font-lock-type-face) ;; types
       (,(concat "[^[:word:][:multibyte:]]\\[\\([[:digit:]]+\\|\\.\\.\\.\\)?\\]" go-type-name-regexp) 2 font-lock-type-face) ;; Arrays/slices
       (,(concat "\\(" go-identifier-regexp "\\)" "{") 1 font-lock-type-face)
       (,(concat "\\_<map\\_>\\[[^]]+\\]" go-type-name-regexp) 1 font-lock-type-face) ;; map value type
       (,(concat "\\_<map\\_>\\[" go-type-name-regexp) 1 font-lock-type-face) ;; map key type
       (,(concat "\\_<chan\\_>[[:space:]]*\\(?:<-[[:space:]]*\\)?" go-type-name-regexp) 1 font-lock-type-face) ;; channel type
       (,(concat "\\_<\\(?:new\\|make\\)\\_>\\(?:[[:space:]]\\|)\\)*(" go-type-name-regexp) 1 font-lock-type-face) ;; new/make type
       ;; TODO do we actually need this one or isn't it just a function call?
       (,(concat "\\.\\s *(" go-type-name-regexp) 1 font-lock-type-face) ;; Type conversion
       ;; Like the original go-mode this also marks compound literal
       ;; fields. There, it was marked as to fix, but I grew quite
       ;; accustomed to it, so it'll stay for now.
       (,(concat "^[[:space:]]*\\(" go-label-regexp "\\)[[:space:]]*:\\(\\S.\\|$\\)") 1 font-lock-constant-face) ;; Labels and compound literal fields
       (,(concat "\\_<\\(goto\\|break\\|continue\\)\\_>[[:space:]]*\\(" go-label-regexp "\\)") 2 font-lock-constant-face)))) ;; labels in goto/break/continue

  ;; key bindings
  (map! :map go-mode-map
        :nv   "K"  #'godoc-at-point))

;; flycheck configuration
(add-hook 'flycheck-after-syntax-check-hook (lambda()
                                              (setq-local flycheck-idle-change-delay 10.0)))

;;; config.el ends here
