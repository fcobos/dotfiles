;; -*- lexical-binding: t -*-
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
;; better looking comment delimiter face on base16
;; (so it's visible when selected)
(custom-set-faces '(font-lock-comment-delimiter-face
                    ((t (:foreground "#585858")))))
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
(add-to-list 'auto-mode-alist '("PKGBUILD" . shell-script-mode))

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

;; better scrolling performance maybe...
(setq auto-window-vscroll nil)

;; modeline configuration
(use-package telephone-line
  :demand t
  :config
  (setq telephone-line-primary-left-separator 'telephone-line-abs-left
        telephone-line-primary-right-separator 'telephone-line-abs-right)

  (telephone-line-defsegment my-vc-info ()
    (when vc-mode
      (cond
       ((string-match "Git[:-]" vc-mode)
        (let ((branch (mapconcat 'concat (cdr (split-string vc-mode "[:-]")) "-")))
          (concat "" (format " %s" branch))))
       ((string-match "SVN-" vc-mode)
        (let ((revision (cadr (split-string vc-mode "-"))))
          (concat "" (format "SVN-%s" revision))))
       (t (format "%s" vc-mode)))))

  (telephone-line-defsegment* my-airline-position-segment (&optional lines columns)
    (let* ((l (number-to-string (if lines lines 1)))
           (c (number-to-string (if columns columns 2))))
      (if (eq major-mode 'paradox-menu-mode)
          (telephone-line-raw mode-line-front-space t)
        `((-3 "%p") ,(concat "  " "%" l "l:%" c "c")))))

  (setq telephone-line-rhs
        '((nil    . (telephone-line-flycheck-segment
                     telephone-line-misc-info-segment))
          (accent . (telephone-line-major-mode-segment))
          (evil   . (my-airline-position-segment))))

  (setq telephone-line-lhs
        '((evil   . (telephone-line-evil-tag-segment))
          (accent . (my-vc-info
                     telephone-line-process-segment))
          (nil    . (telephone-line-buffer-segment
                     telephone-line-projectile-segment))))

  (telephone-line-mode 1))
