;;; config.el -*- lexical-binding: t; -*-

(add-hook 'after-save-hook #'garbage-collect)
(add-hook 'suspend-hook #'garbage-collect)
(run-with-idle-timer 15 t (lambda () (garbage-collect)))
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; disable window decorations
(set-frame-parameter nil 'undecorated t)
;; disable scroll bar
(set-scroll-bar-mode nil)
;; start maximized
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; enable fill column indicator
(when EMACS27+
  (add-hook! '(text-mode-hook prog-mode-hook conf-mode-hook) (display-fill-column-indicator-mode 1)))
;; Set the theme
(setq doom-theme 'doom-one-light)

;; faces configuration
(custom-set-faces
 '(variable-pitch ((t (:family "Cantarell"))))
 '(lsp-face-highlight-read ((t (:background "#e5e5e6"))))
 '(fill-column-indicator ((t (:foreground "#e5e5e6" :distant-foreground "#e5e5e6"))))
 '(font-lock-function-name-face ((t (:foreground "#0184bc")))))

;; Set line numbers style
(setq display-line-numbers-type t)

;; custom dashboard banner
(defvar dashboard-banner-list '())
(add-to-list 'dashboard-banner-list "\n\n\n\n\n\n")
(add-to-list 'dashboard-banner-list (concat " (" (system-name) " - " system-configuration ")"))
(add-to-list 'dashboard-banner-list (concat "Welcome to Emacs " emacs-version))
(defun doom-dashboard-widget-banner ()
  (mapc (lambda (line)
          (insert (propertize (+doom-dashboard--center +doom-dashboard--width line)
                              'face 'doom-dashboard-banner) " ")
          (insert "\n"))
        dashboard-banner-list))

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
(setq vterm-shell "/bin/bash")

;; avoid exit confirmation dialog
(setq confirm-kill-emacs nil)

;; company config
(setq company-dabbrev-ignore-case t)
(setq company-idle-delay 0.2)

;; longer flycheck idle-change-delay
(add-hook 'flycheck-after-syntax-check-hook
          (lambda()
            (setq-local flycheck-idle-change-delay 4.0)))

;; lsp tuning
(after! lsp-mode
  (setq lsp-idle-delay 0.250))

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

;; format rust buffers on save
(after! rustic
  (setq rustic-format-on-save t))

;; fix rust documentation keybind
(after! rustic
  (when (featurep 'evil)
    (add-hook 'lsp-mode-hook #'evil-normalize-keymaps))
  (map! :map (rustic-mode-map)
        :n   "K"  #'lsp-describe-thing-at-point))

;; set rust-analyzer as server for rust
(setq rustic-lsp-server 'rust-analyzer)

;; fix go documentation keybind
(after! go-mode
  (when (featurep 'evil)
    (add-hook 'lsp-mode-hook #'evil-normalize-keymaps))
  (map! :map (go-mode-map)
        :n   "K"  #'lsp-describe-thing-at-point))

;; fix go+lsp
(add-hook 'go-mode-hook #'lsp!)

;;; config.el ends here
