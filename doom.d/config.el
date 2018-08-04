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

;; Disable exit confirmation dialog
(setq confirm-kill-emacs nil)
;; Don't ask if processes should be killed
(setq confirm-kill-processes nil)

;; Set the font
(setq doom-font (font-spec :family "Iosevka SS04" :size 12)
      doom-big-font (font-spec :family "Iosevka SS04" :size 24)
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans Condensed" :size 12))

;; Set the theme
(setq doom-theme 'doom-tomorrow-night)
(unless (display-graphic-p)
  (custom-set-faces '(region ((t (:background "#303030"))))
                    '(hl-line ((t (:background "#303030"))))
                    '(ivy-current-match ((t (:background "#101010"))))
                    '(company-tooltip-selection ((t (:background "#101010"))))
                    '(show-paren-match ((t (:foreground "red" :background "#101010"))))))

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

;; config python linters
;;(defun config-python-linters ()
;;  (flycheck-define-checker
;;      python-mypy "Mypy syntax and type checker.  Requires mypy>=0.580.
;;
;;See URL `http://mypy-lang.org/'."
;;      :command ("mypy" "--ignore-missing-imports" "--fast-parser"
;;                "--python-version" "3.6" source-original)
;;      :error-patterns
;;      ((error line-start (file-name) ":" line ": error:" (message) line-end)
;;       (warning line-start (file-name) ":" line ": warning:" (message) line-end))
;;      :modes python-mode
;;      :predicate flycheck-buffer-saved-p)
;;  (flycheck-add-next-checker 'python-flake8 'python-mypy)
;;  (flycheck-add-next-checker 'python-mypy 'python-pylint))
;;(add-hook 'python-mode-hook #'config-python-linters)

;; disable fci-mode for markdown modes
(defun disable-fci-mode ()
  (fci-mode 0))
(add-hook 'markdown-mode-hook #'disable-fci-mode)
(add-hook 'gfm-mode-hook #'disable-fci-mode)

;; enable rainbow delimiters for programming modes
(defun set-rainbow-max-face-count ()
  (setq rainbow-delimiters-max-face-count 7))
(add-hook 'rainbow-delimiters-mode-hook #'set-rainbow-max-face-count)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

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

;; eshell maximum lines of scrollback
(setq eshell-buffer-maximum-lines 1000)
(add-hook 'eshell-output-filter-functions #'eshell-truncate-buffer)

;;; config.el ends here
