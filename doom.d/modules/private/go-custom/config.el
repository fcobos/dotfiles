;;; private/go-custom/config.el -*- lexical-binding: t; -*-

;;;###autoload
(defun go-guru-dumb-jump()
  "Try to jump with go-guru-definition and if it fails use dumb-jump-go."
  (interactive)
  (condition-case nil
      (go-guru-definition)
    (error (dumb-jump-go)))
  (recenter))

;; go configuration
(after! go-mode
  ;; debugger configuration
  (require 'dap-go)
  (dap-go-setup)

  ;; flycheck config
  (add-hook 'flycheck-mode-hook (lambda ()
                                  (push 'go-errcheck flycheck-disabled-checkers)
                                  (push 'go-staticcheck flycheck-disabled-checkers)
                                  (push 'go-unconvert flycheck-disabled-checkers)))

  ;; use gogetdoc for documentation
  (setq godoc-at-point-function #'godoc-gogetdoc)

  (map! :map go-mode-map
        :nv "gd" #'lsp-ui-peek-find-definitions
        :nv "gD" #'lsp-ui-peek-find-references
        :nv "K"  #'lsp-describe-thing-at-point)

  (setq company-lsp-cache-candidates nil
        company-lsp-filter-candidates nil
        company-lsp-async t)

  (map! :map go-mode-map
        :localleader
        (:prefix ("r" . "refactor")
          "d" #'godoctor-godoc
          "e" #'godoctor-extract
          "f" #'go-tag-add
          "F" #'go-tag-remove
          "l" #'go-impl
          "n" #'godoctor-rename
          "t" #'godoctor-toggle)
        (:prefix ("t" . "test")
          "g" #'go-gen-test-dwim
          "f" #'go-gen-test-exported
          "F" #'go-gen-test-all))

  ;; format go buffers on save
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook #'gofmt-before-save)
)

;;; config.el ends here
