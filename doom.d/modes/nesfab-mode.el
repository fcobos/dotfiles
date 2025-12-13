;;; nesfab-mode.el --- Major mode for NESFab programming language -*- lexical-binding: t; -*-

;; Keywords: languages
;; Version: 0.0.1
;; Package-Requires: ((emacs "24.3"))
;; URL: https://pubby.games/nesfab/


;;; Commentary:

;; Major mode for editing NESFab files with syntax highlighting.

;;; Code:

(defvar nesfab-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; Comment styles
    (modify-syntax-entry ?/ ". 124" table)
    (modify-syntax-entry ?* ". 23b" table)
    (modify-syntax-entry ?\n ">" table)
    ;; String delimiters
    (modify-syntax-entry ?\" "\"" table)
    (modify-syntax-entry ?` "\"" table)
    table)
  "Syntax table for `nesfab-mode'.")

(defconst nesfab-keywords
  '("if" "else" "for" "while" "do" "break" "continue" "return" "fn"
    "ct" "nmi" "mode" "goto" "label" "file" "struct" "vars" "data"
    "omni" "ready" "fence" "irq" "default" "switch" "case" "asm"
    "charmap" "chrrom" "true" "false" "audio" "system" "stows"
    "employs" "preserves" "state" "read" "write" "sizeof" "len"
    "push" "pop" "mapfab" "min" "max" "abs" "macro" "nmi_counter" "swap")
  "NESFab keywords.")

(defvar nesfab-font-lock-keywords
  (list
   ;; Keywords
   `(,(regexp-opt nesfab-keywords 'symbols) . font-lock-keyword-face)
   
   ;; Group names: /identifier
   '("/\\([[:alnum:]_]+\\)" . (1 font-lock-variable-name-face))
   
   ;; Type names with special prefixes
   ;; Fn._identifier or Fn.identifier
   '("\\<\\(Fn\\)\\.\\(_?[[:lower:]][[:alnum:]_]*\\)"
     (1 font-lock-type-face) (2 font-lock-type-face))
   
   ;; I._identifier or I.identifier
   '("\\<\\(I\\)\\.\\(_?[[:lower:]][[:alnum:]_]*\\)"
     (1 font-lock-type-face) (2 font-lock-type-face))
   
   ;; II._identifier or II.identifier
   '("\\<\\(II\\)\\.\\(_?[[:lower:]][[:alnum:]_]*\\)"
     (1 font-lock-type-face) (2 font-lock-type-face))
   
   ;; Type names: _Uppercase or Uppercase followed by alnum or underscore
   '("\\<_?\\([[:upper:]][[:alnum:]_]*\\)\\>" . (1 font-lock-type-face))
   
   ;; Hexadecimal numbers: $hex
   '("\\$[[:xdigit:]]+" . font-lock-constant-face)
   
   ;; Binary numbers: %binary
   '("%[01]+" . font-lock-constant-face)
   
   ;; Decimal numbers
   '("\\<[0-9]+\\(?:\\.[0-9]*\\)?\\>" . font-lock-constant-face))
  "Font lock keywords for `nesfab-mode'.")

;;;###autoload
(define-derived-mode nesfab-mode prog-mode "NESFab"
  "Major mode for editing NESFab files.

\\{nesfab-mode-map}"
  :syntax-table nesfab-mode-syntax-table
  
  ;; Font lock
  (setq font-lock-defaults '(nesfab-font-lock-keywords))
  
  ;; Comment style
  (setq-local comment-start "//")
  (setq-local comment-end "")
  (setq-local comment-start-skip "//+\\s-*")
  
  ;; Indentation (basic)
  (setq-local indent-tabs-mode nil)
  (setq-local tab-width 4))

;;;###autoload
;(add-to-list 'auto-mode-alist '("\\.nf\\'" . nesfab-mode))

(provide 'nesfab-mode)

;;; nesfab-mode.el ends here

