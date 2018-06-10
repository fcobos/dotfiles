;; Custom keybindings
(add-hook! 'after-init-hook
  (map!
   (:leader
     :desc "M-x" :n "SPC" #'execute-extended-command
     (:desc "code" :prefix "c"
       :desc "Format buffer" :n "f" #'format-all-buffer))))

;; pipenv config
(use-package pipenv
  :hook (python-mode . pipenv-mode))


;; Maximize frame
;; (add-hook 'doom-init-hook (lambda () (toggle-frame-maximized)))

;; Set the font
(setq doom-font (font-spec :family "Hack" :size 12)
      doom-big-font (font-spec :family "Hack" :size 24))

;; Set the theme
;; (setq doom-theme 'doom-tomorrow-night)
;; (solaire-mode 1)
(unless (display-graphic-p)
  (setq base16-theme-256-color-source "colors"))
(load-theme 'base16-default-dark t)
(doom-themes-neotree-config)
(doom-themes-org-config)

;; disable bold and italic fonts
(setq doom-themes-enable-bold nil)
(setq doom-themes-enable-italic nil)

;; Set line numbers style
(setq doom-line-numbers-style 'relative)

;; setup default indentation
(setq indent-tabs-mode 't)
(setq-default tab-width 8)
(setq default-tab-width 8)
(setq c-basic-offset 8)
(c-set-offset 'case-label '+)

;; Disable cursor blink
(add-hook 'window-setup-hook (lambda () (blink-cursor-mode 0)))
(setq visible-cursor nil)

;; Disable whitespace-mode
(add-hook 'after-init-hook (lambda ()
                             (remove-hook 'after-change-major-mode-hook
                                          'doom|show-whitespace-maybe)))

;; Enable gdb many windows.
(setq gdb-many-windows t)
;; python debugger
(setq gud-pdb-command-name "python -m pdb")

;; modeline height
(setq +doom-modeline-height 20)

;; open *rc files as conf-mode
(add-to-list 'auto-mode-alist '("\\rc$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\vimrc$" . vimrc-mode))
(add-to-list 'auto-mode-alist '("\\zshrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\bashrc$" . shell-script-mode))

;; make postframe stop moving my mouse pointer, kthxbai
(add-hook 'flycheck-mode-hook (lambda ()
                                (setq posframe-mouse-banish nil)))

;; fix python repl
(defun python-repl-config ()
  (setq python-shell-interpreter "python"
        python-shell-interpreter-args "-i"
        python-shell-prompt-regexp nil
        python-shell-prompt-block-regexp nil
        python-shell-prompt-output-regexp nil
        python-shell-completion-setup-code nil
        python-shell-completion-string-code nil))
(add-hook 'python-mode-hook #'python-repl-config)
