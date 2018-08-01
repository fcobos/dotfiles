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
(setq doom-font (font-spec :family "Iosevka SS04" :size 12)
      doom-big-font (font-spec :family "Iosevka SS04" :size 24))

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
;; better looking comment delimiter face on base16
;; (so it's visible when selected)
(setq my-gray "#585858")
(setq my-dark-gray "#d8d8d8")
(setq my-green "#a1b56c")
(setq my-red "#ab4642")
(setq my-orange "#a16946")
(setq my-blue "#7cafc2")
(setq my-light-blue "#86c1b9")
(setq my-yellow "#f7ca88")
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
                    ((t (:background "#585858"))))
                  ;; rainbow delimiters colors
                  '(rainbow-delimiters-depth-2-face
                    ((t (:foreground "#A16946"))))
                  '(rainbow-delimiters-depth-3-face
                    ((t (:foreground "#a1b56c"))))
                  '(rainbow-delimiters-depth-4-face
                    ((t (:foreground "#7CAFC2"))))
                  ;; evil-ex-substitute-replacement
                  '(evil-ex-substitute-replacement
                    ((t (:foreground "#ab4642"))))
                  ;; imenu faces
                  '(imenu-list-entry-face-0
                    ((t (:foreground "#f7ca88"))))
                  '(imenu-list-entry-face-1
                    ((t (:foreground "#a1b56c"))))
                  '(imenu-list-entry-face-2
                    ((t (:foreground "#86c1b9"))))
                  '(imenu-list-entry-face-3
                    ((t (:foreground "#a16946"))))
                  )
(unless (display-graphic-p)
  (custom-set-faces '(show-paren-match ((t (:foreground "#d8d8d8"
                                            :background "#585858"))))))
;;(doom-themes-treemacs-config)
;;(doom-themes-neotree-config)
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

;; run pylint after flake8
(defun pylint-after-flake8 ()
  (flycheck-add-next-checker 'python-flake8 'python-pylint))
(add-hook 'python-mode-hook #'pylint-after-flake8)
;; run mypy after pylint
(defun mypy-after-pylint ()
  (flycheck-define-checker
      python-mypy ""
      :command ("mypy"
                "--ignore-missing-imports" "--fast-parser"
                source-original)
      :error-patterns
      ((error line-start (file-name) ":" line ": error:" (message) line-end))
      :modes python-mode)
  (add-to-list 'flycheck-checkers 'python-mypy t)
  (flycheck-add-next-checker 'python-pylint 'python-mypy t))
(add-hook 'python-mode-hook #'mypy-after-pylint)

;; better scrolling performance maybe...
(setq auto-window-vscroll nil)
;;(setq scroll-margin 0
;;      scroll-conservatively 0
;;      scroll-up-aggressively 0.01
;;      scroll-down-aggressively 0.01)

;; disable fci-mode for markdown modes
(defun disable-fci-mode ()
  (fci-mode 0))
(add-hook 'markdown-mode-hook #'disable-fci-mode)
(add-hook 'gfm-mode-hook #'disable-fci-mode)
;; fci-rule-color
(setq +fci-rule-color-function nil)
(setq fci-rule-color "#383838")

;; enable rainbow delimiters for programming modes
(defun set-rainbow-max-face-count ()
  (setq rainbow-delimiters-max-face-count 7))
(add-hook 'rainbow-delimiters-mode-hook #'set-rainbow-max-face-count)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; use treemacs git deferred mode
(after! treemacs
  (treemacs-git-mode 'deferred)
  ;; use the same font for treemacs
  (setq doom-treemacs-enable-variable-pitch nil))

;; check for errors on buffer load and save
(add-hook 'flycheck-mode-hook '(lambda ()
                                 (setq flycheck-check-syntax-automatically
                                       '(save mode-enabled))))
;; show flycheck indicators on the right side
(after! flycheck
  (setq flycheck-indication-mode 'right-fringe)
  ;; left arrow
  (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
    [16 48 112 240 112 48 16] nil nil 'center))

;; eshell maximum lines of scrollback
(setq eshell-buffer-maximum-lines 1000)
(add-hook 'eshell-output-filter-functions #'eshell-truncate-buffer)

;;; config.el ends here
