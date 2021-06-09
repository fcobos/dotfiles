;;; config.el -*- lexical-binding: t; -*-

(add-hook 'after-save-hook #'garbage-collect)
(add-hook 'suspend-hook #'garbage-collect)
(run-with-idle-timer 15 t (lambda () (garbage-collect)))
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; disable window decorations
;;(set-frame-parameter nil 'undecorated t)
;; start maximized
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; enable fill column indicator
(when EMACS27+
  (add-hook! '(text-mode-hook prog-mode-hook conf-mode-hook) (display-fill-column-indicator-mode 1)))
;; Set the theme
(setq doom-theme 'doom-one-light)

;; configure mode-line
(setq doom-modeline-buffer-file-name-style 'filename)

;; faces configuration
(custom-set-faces
 '(variable-pitch ((t (:family "Cantarell"))))
 '(lsp-face-highlight-read ((t (:background "#e5e5e6"))))
 '(fill-column-indicator ((t (:foreground "gray70"))))
 '(font-lock-function-name-face ((t (:foreground "#0184bc")))))
(when (eq doom-theme 'doom-one)
  (custom-set-faces '(fill-column-indicator ((t (:foreground "gray30"))))))

;; Set line numbers style
(setq display-line-numbers-type t)

;; custom dashboard banner
(if (display-graphic-p)
  (progn
    (setq fancy-splash-image "~/.doom.d/Emacs-logo.svg"))

  (defvar dashboard-banner-list '())
  (add-to-list 'dashboard-banner-list "\n\n\n\n\n\n")
  (add-to-list 'dashboard-banner-list (concat " (" (system-name) " - " system-configuration ")"))
  (add-to-list 'dashboard-banner-list (concat "Welcome to GNU Emacs " emacs-version))
  (defun doom-dashboard-widget-banner ()
    (mapc (lambda (line)
            (insert (propertize (+doom-dashboard--center +doom-dashboard--width line)
                      'face 'doom-dashboard-banner) " ")
            (insert "\n"))
      dashboard-banner-list)))

;; macOS - change theme on system appearance change
(defun my/apply-theme (appearance)
  "Load theme, taking current system APPEARANCE into consideration."
  (mapc #'disable-theme custom-enabled-themes)
  (pcase appearance
    ('light (load-theme 'doom-one-light t))
    ('dark (load-theme 'doom-one t))))

(add-hook 'ns-system-appearance-change-functions #'my/apply-theme)

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

;; use treemacs git deferred mode
(after! treemacs
  (treemacs-git-mode 'deferred))
;; don't use variable pitch font for treemacs
(after! doom-themes
  (setq doom-treemacs-enable-variable-pitch nil))

;; eshell maximum lines of scrollback
(setq eshell-buffer-maximum-lines 1000)
(add-hook 'eshell-output-filter-functions #'eshell-truncate-buffer)

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
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-java-format-on-type-enabled nil)
  (setq lsp-idle-delay 0.250))

(after! lsp-ui
  ;; map SPC o i to lsp-ui-imenu
  (map! :leader
        (:prefix "o"
         :desc "Toggle lsp-ui-imenu" "i" #'lsp-ui-imenu))
  ;; map SPC o i to lsp-ui-imenu
  (setq lsp-ui-sideline-enable 'nil)
  (setq lsp-ui-doc-enable 'nil))

(after! go-mode
  ;; fix go documentation keybind
  (when (featurep 'evil)
    (add-hook 'lsp-mode-hook #'evil-normalize-keymaps))
  (map! :map (go-mode-map)
        :n   "K"  #'lsp-describe-thing-at-point))

(after! rustic
  ;; format rust buffers on save
  (setq rustic-format-on-save t)
  ;; fix rust documentation keybind
  (when (featurep 'evil)
    (add-hook 'lsp-mode-hook #'evil-normalize-keymaps))
  (map! :map (rustic-mode-map)
        :n   "K"  #'lsp-describe-thing-at-point))

;; set rust-analyzer as server for rust
(setq rustic-lsp-server 'rust-analyzer)

;;; config.el ends here
