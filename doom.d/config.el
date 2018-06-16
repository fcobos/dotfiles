;;; config.el -*- lexical-binding: t; -*-

;; Custom keybindings
(map!
 (:leader
   :desc "M-x" :n "SPC" #'execute-extended-command
   (:prefix "c"
     :desc "Format buffer" :n "f" #'format-all-buffer)))

;; pipenv config
(add-hook 'python-mode-hook #'pipenv-mode)

;; Maximize frame
;; (add-hook 'doom-init-hook (lambda () (toggle-frame-maximized)))

;; Set the font
(setq doom-font (font-spec :family "Hack" :size 12)
      doom-big-font (font-spec :family "Hack" :size 24))

;; Set the theme
(setq doom-theme 'doom-one)
(unless (display-graphic-p)
  (add-hook 'after-change-major-mode-hook (lambda ()
                                            (solaire-mode 0)))
  (add-hook 'after-change-major-mode-hook (lambda ()
                                            (hl-line-mode 0)))
  (custom-set-faces '(region ((t (:background "color-18"))))
		    '(hl-line ((t (:background "color-18"))))
                    '(font-lock-comment-delimiter-face
                      ((t (:foreground "color-20"))))
                    '(font-lock-comment-face
                      ((t (:foreground "color-20"))))
                    '(show-paren-match
                      ((t (:foreground "red" :background "color-20"))))
                    '(mode-line ((t (:background "#1f1f1f"))))))

;; disable bold and italic fonts
;; (setq doom-themes-enable-bold nil)
;; (setq doom-themes-enable-italic nil)

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
;; just show the file name (don't waste cpu cycles truncating paths)
(setq +doom-modeline-buffer-file-name-style 'file-name)

;; open *rc files as conf-mode
(add-to-list 'auto-mode-alist '("\\rc$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\vimrc$" . vimrc-mode))
(add-to-list 'auto-mode-alist '("\\zshrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\bashrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("PKGBUILD" . shell-script-mode))

;; make postframe stop moving my mouse pointer, kthxbai
(add-hook 'flycheck-mode-hook (lambda ()
                                (setq posframe-mouse-banish nil)))

;; use python as repl instead of ipython
(defun python-repl-config ()
  (setq python-shell-interpreter "python"
        python-shell-interpreter-args "-i"
        python-shell-prompt-regexp nil
        python-shell-prompt-block-regexp nil
        python-shell-prompt-output-regexp nil
        python-shell-completion-setup-code nil
        python-shell-completion-string-code nil))
(add-hook 'python-mode-hook #'python-repl-config)

;; better scrolling performance maybe...
(setq auto-window-vscroll nil)
(setq scroll-margin 0
      scroll-conservatively 0
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)

;;; config.el ends here
