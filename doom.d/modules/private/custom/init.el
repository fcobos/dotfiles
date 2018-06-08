;; Maximize frame
;; (add-hook 'doom-init-hook (lambda () (toggle-frame-maximized)))

;; Set the font
(setq doom-font (font-spec :family "Hack" :size 12)
      doom-big-font (font-spec :family "Hack" :size 24))

;; Set the theme
(setq doom-theme 'doom-tomorrow-night)
(solaire-mode 1)
(unless (display-graphic-p)
  (setq base16-theme-256-color-source "colors")
  (load-theme 'base16-default-dark t))
;; Background and foreground like base16-default-dark
;; (custom-set-faces
;;  '(default ((t (:background "#181818" :foreground "#d8d8d8"))))
;;  '(solaire-default-face ((t (:background "#202020"))))
;;  '(solaire-hl-line-face ((t (:background "#282828"))))
;;  )
;; (load-theme 'darktooth)
;; (setq base16-theme-256-color-source "colors")
;; (load-theme 'base16-default-dark t)
;; (doom-themes-neotree-config)
;; ;(doom-themes-visual-bell-config)
;; (doom-themes-org-config)

;; Set line numbers style
(setq doom-line-numbers-style 'relative)

;; setup default indentation
(setq indent-tabs-mode 't)
(setq-default tab-width 8)
(setq default-tab-width 8)
(setq c-basic-offset 8)
(c-set-offset 'case-label '+)

;; Disable cursor blink
;; (add-hook 'window-setup-hook (lambda () (blink-cursor-mode 0)))
;; (setq visible-cursor nil)

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

;; fill column indicator
(setq fci-handle-truncate-lines nil)
(setq fci-always-use-textual-rule t)
(add-hook 'prog-mode-hook 'auto-fci-mode)
(add-hook 'window-size-change-functions 'auto-fci-mode)
(defun auto-fci-mode (&optional unused)
  (if (> (frame-width) 80)
      (if (derived-mode-p 'prog-mode)
          (fci-mode 1))
    (fci-mode 0))
  )

;; gc settings
(defun my-scroll-hook(_)
  "Increase gc-threshold before scroll and set it back after."
  (setq gc-cons-threshold most-positive-fixnum)
  (run-with-idle-timer 3 nil (lambda () (setq gc-cons-threshold (* 16 1024 1024)))))
(advice-add 'scroll-up-line :before 'my-scroll-hook)
(advice-add 'scroll-down-line :before 'my-scroll-hook)

;; open *rc files as conf-mode
(add-to-list 'auto-mode-alist '("\\rc$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\vimrc$" . vimrc-mode))
(add-to-list 'auto-mode-alist '("\\zshrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\bashrc$" . shell-script-mode))
