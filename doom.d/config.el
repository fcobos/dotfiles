;;; config.el -*- lexical-binding: t; -*-

(add-hook 'after-save-hook #'garbage-collect)
(add-hook 'suspend-hook #'garbage-collect)
(run-with-idle-timer 15 t (lambda () (garbage-collect)))

;; disable window decorations
(set-frame-parameter nil 'undecorated t)

;; Set the font
(setq doom-font (font-spec :family "Iosevka SS04" :size 14)
      doom-big-font (font-spec :family "Iosevka SS04" :size 24)
      doom-variable-pitch-font (font-spec :family "Roboto" :size 14))
(setq-default line-spacing nil)

;; Set the theme
(setq doom-theme 'doom-one-light)

;; faces configuration
(custom-set-faces
 '(variable-pitch ((t (:family "Roboto"))))
 '(lsp-face-highlight-read ((t (:background "#e5e5e6"))))
 '(font-lock-function-name-face ((t (:foreground "#0184bc")))))

;; Set line numbers style
(setq display-line-numbers-type 'relative)

;; Enable gdb many windows.
(setq gdb-many-windows t)
;; python debugger
(setq gud-pdb-command-name "python -m pdb")

;; file associations
(add-to-list 'auto-mode-alist '("\\rc$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\vimrc$" . vimrc-mode))
(add-to-list 'auto-mode-alist '("\\.?vimperatorrc\\'" . vimrc-mode))
(add-to-list 'auto-mode-alist '("\\zshrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\bashrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("Pipfile" . toml-mode))
(add-to-list 'auto-mode-alist '("Pipfile.lock" . json-mode))
(add-to-list 'auto-mode-alist '("\\patch$" . diff-mode))

;; enable rainbow delimiters for programming modes
(defun set-rainbow-max-face-count ()
  (setq rainbow-delimiters-max-face-count 4))
(add-hook 'rainbow-delimiters-mode-hook #'set-rainbow-max-face-count)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'parinfer-mode-hook 'rainbow-delimiters-mode)

;; use treemacs git deferred mode
(after! treemacs
  (treemacs-git-mode 'deferred))
;; don't use variable pitch font for treemacs
(after! doom-themes
  (setq doom-treemacs-enable-variable-pitch nil))

;; eshell maximum lines of scrollback
(setq eshell-buffer-maximum-lines 1000)
(add-hook 'eshell-output-filter-functions #'eshell-truncate-buffer)

;; use bash for terminals
(setq multi-term-program "/bin/bash")

;; format rust buffers on save
(after! rust-mode
  (setq rust-format-on-save t))

;; avoid exit confirmation dialog
(setq confirm-kill-emacs nil)

;; company config
(setq company-dabbrev-ignore-case t)
(setq company-idle-delay 0.2)

;; longer flycheck idle-change-delay
(add-hook 'flycheck-after-syntax-check-hook
          (lambda()
            (setq-local flycheck-idle-change-delay 4.0)))

;; dap-mode extensions location
(after! dap-mode
  (setq dap-utils-extension-path (concat doom-local-dir "extension")))
;; dap-mode breakpoints file location
(after! dap-mode
  (setq dap-breakpoints-file (concat doom-cache-dir ".dap-breakpoints")))

;; map SPC o i to lsp-ui-imenu
(after! lsp-ui
  (map! :leader
        (:prefix "o"
          :desc "Toggle lsp-ui-imenu" "i" #'lsp-ui-imenu)))

;; key bindings
(map! :leader
      (:prefix "c"
        :desc "Toggle comment"         "l" #'evil-commentary-line
        :desc "Copy and comment lines" "y" #'evil-commentary-yank-line))

;;; config.el ends here
