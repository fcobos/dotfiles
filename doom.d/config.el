;;; config.el -*- lexical-binding: t; -*-

;; https://www.reddit.com/r/emacs/comments/8sykl1/emacs_tls_defaults_are_downright_dangerous/
(setq gnutls-verify-error t)
(setq gnutls-min-prime-bits 2048)
(setq network-security-level 'high)
(setq nsm-save-host-names t)
(setq tls-program
      '("gnutls-cli -p %p --dh-bits=2048 --ocsp --x509cafile=%t \
            --priority='SECURE192:+SECURE128:-VERS-ALL:+VERS-TLS1.2:%PROFILE_MEDIUM' %h"))
(setq tls-checktrust t)

;; Custom keybindings
(map!
 (:leader
   :desc "M-x" :n "SPC" #'execute-extended-command
   (:prefix "c"
     :desc "Format buffer" :n "f" #'format-all-buffer)))

;; Maximize frame
;; (defun maximize-frame ()
;;   (toggle-frame-maximized))
;; (add-hook 'doom-init-hook #'maximize-frame)

;; Disable exit confirmation dialog
(setq confirm-kill-emacs nil)
;; Don't ask if processes should be killed
(setq confirm-kill-processes nil)

;; Set the font
(setq doom-font (font-spec :family "Hack" :size 12)
      doom-big-font (font-spec :family "Hack" :size 24))

;; Set the theme
;;(setq doom-theme 'doom-one)
;;(unless (display-graphic-p)
;;  (defun disable-solaire-mode ()
;;    (solaire-mode 0))
;;  (defun disable-hl-line-mode ()
;;    (hl-line-mode 0))
;;  (solaire-mode 0)
;;  (add-hook 'after-change-major-mode-hook #'disable-solaire-mode)
;;  (add-hook 'after-change-major-mode-hook #'disable-hl-line-mode)
;;  (custom-set-faces '(region ((t (:background "#404040"))))
;;                    '(hl-line ((t (:background "#404040"))))
;;                    '(font-lock-comment-delimiter-face
;;                      ((t (:foreground "#565c64"))))
;;                    '(font-lock-comment-face
;;                      ((t (:foreground "#565c64"))))
;;                    '(show-paren-match
;;                      ((t (:foreground "red" :background "#565c64"))))
;;                    '(mode-line ((t (:background "#1f1f1f"))))))
(unless (display-graphic-p)
  (setq base16-theme-256-color-source "colors"))
(load-theme 'base16-default-dark t)
                                        ; better looking comment delimiter face on base16
;; (so it's visible when selected)
(custom-set-faces '(font-lock-comment-delimiter-face
                    ((t (:foreground "#585858"))))
                  ;; make doc strings darker so they don't look too much like
                  ;; regular text
                  '(font-lock-doc-face
                    ((t (:foreground "honeydew4"))))
                  ;; flycheck configuration
                  '(flycheck-posframe-error-face
                    ((t (:background "#ab4642"))))
                  '(flycheck-posframe-warning-face
                    ((t (:background "#A16946"))))
                  '(flycheck-posframe-info-face
                    ((t (:background "#585858")))))
(doom-themes-treemacs-config)
(doom-themes-org-config)

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
(defun disable-cursor-blink ()
  (blink-cursor-mode 0))
(add-hook 'window-setup-hook #'disable-cursor-blink)
(setq visible-cursor nil)

;; Disable whitespace-mode
(remove-hook 'after-change-major-mode-hook
             'doom|show-whitespace-maybe)

;; Enable gdb many windows.
(setq gdb-many-windows t)
;; python debugger
(setq gud-pdb-command-name "python -m pdb")

;; modeline height
(setq +doom-modeline-height 22)
;; just show the file name (don't waste cpu cycles truncating paths)
(setq +doom-modeline-buffer-file-name-style 'file-name)

;; open *rc files as conf-mode
(add-to-list 'auto-mode-alist '("\\rc$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\vimrc$" . vimrc-mode))
(add-to-list 'auto-mode-alist '("\\zshrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\bashrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("PKGBUILD" . shell-script-mode))

;; make postframe stop moving my mouse pointer, kthxbai
(defun disable-posframe-mouse-banish ()
  (setq posframe-mouse-banish nil))
(add-hook 'flycheck-mode-hook #'disable-posframe-mouse-banish)

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

;; pipenv config
(add-hook 'python-mode-hook #'pipenv-mode)

;; better scrolling performance maybe...
(setq auto-window-vscroll nil)
                                        ;(setq scroll-margin 0
                                        ;      scroll-conservatively 0
                                        ;      scroll-up-aggressively 0.01
                                        ;      scroll-down-aggressively 0.01)

;; disable fci-mode for markdown modes
;; (defun disable-fci-mode ()
;;   (fci-mode 0))
;; (add-hook 'markdown-mode-hook #'disable-fci-mode)
;; (add-hook 'gfm-mode-hook #'disable-fci-mode)

;; enable rainbow delimiters for programming modes
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;; config.el ends here
