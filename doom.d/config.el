;;; config.el -*- lexical-binding: t; -*-

;; disable window decorations
;;(set-frame-parameter nil 'undecorated t)

;; Set the font
(setq doom-font (font-spec :family "Iosevka SS04" :size 14)
      doom-big-font (font-spec :family "Iosevka SS04" :size 24)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans Condensed" :size 14))
(setq-default line-spacing 1)

;; Set the theme
(setq doom-theme 'doom-one)

;; Set line numbers style
(setq display-line-numbers-type 'relative)

;; Enable gdb many windows.
(setq gdb-many-windows t)
;; python debugger
(setq gud-pdb-command-name "python -m pdb")

;; modeline config
(setq doom-modeline-height 22)

;; file associations
(add-to-list 'auto-mode-alist '("\\rc$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\vimrc$" . vimrc-mode))
(add-to-list 'auto-mode-alist '("\\.?vimperatorrc\\'" . vimrc-mode))
(add-to-list 'auto-mode-alist '("\\zshrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\bashrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("Pipfile" . toml-mode))
(add-to-list 'auto-mode-alist '("Pipfile.lock" . json-mode))
(add-to-list 'auto-mode-alist '("\\patch$" . diff-mode))

;; make postframe stop moving my mouse pointer, kthxbai
(defun disable-posframe-mouse-banish ()
  (setq posframe-mouse-banish nil))
(add-hook 'flycheck-mode-hook #'disable-posframe-mouse-banish)

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

;; show flycheck indicators on the right side
(after! flycheck
  (setq flycheck-indication-mode 'right-fringe)
  ;; left arrow
  (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
    [16 48 112 240 112 48 16] nil nil 'center))

;; disable lsp-ui live reporting
;; (after! lsp-ui
;;   (setq lsp-ui-flycheck-live-reporting nil))

;; eshell maximum lines of scrollback
(setq eshell-buffer-maximum-lines 1000)
(add-hook 'eshell-output-filter-functions #'eshell-truncate-buffer)

;; use bash for terminals
(setq multi-term-program "/bin/bash")

;; setup default indentation
(setq indent-tabs-mode 't)
(setq-default tab-width 8)
(setq default-tab-width 8)
(setq c-basic-offset 8)
(c-set-offset 'case-label '+)

;; autodetect indentation settings
(add-hook 'prog-mode-hook (lambda () (dtrt-indent-mode 1)))

;; use eww to open urls
(setq +lookup-open-url-fn 'eww)

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

;; key bindings
(map! :leader
      (:prefix "c"
        :desc "Toggle comment"         "l" #'evil-commentary-line
        :desc "Copy and comment lines" "y" #'evil-commentary-yank-line))

;; ugly hack to fix weird right border under i3
(add-hook 'after-init-hook (lambda() (toggle-frame-fullscreen) (toggle-frame-fullscreen)))

;;; config.el ends here
