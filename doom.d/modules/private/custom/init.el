;; Maximize frame
;(add-hook 'doom-init-hook (lambda () (toggle-frame-maximized)))

;; Set the font
(setq doom-font (font-spec :family "Hack" :size 12)
      doom-big-font (font-spec :family "Hack" :size 24))

;; Set the theme
(setq doom-theme 'doom-tomorrow-night)
(solaire-mode 1)
(unless (display-graphic-p)
  (setq base16-theme-256-color-source "colors")
  (load-theme 'base16-default-dark t))
;;; Background and foreground like base16-default-dark
;(custom-set-faces
; '(default ((t (:background "#181818" :foreground "#d8d8d8"))))
; '(solaire-default-face ((t (:background "#202020"))))
; '(solaire-hl-line-face ((t (:background "#282828"))))
; )
;(load-theme 'darktooth)
;(setq base16-theme-256-color-source "colors")
;(load-theme 'base16-default-dark t)
;(doom-themes-neotree-config)
;;(doom-themes-visual-bell-config)
;(doom-themes-org-config)

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
  (remove-hook 'after-change-major-mode-hook 'doom|show-whitespace-maybe)))

;; Change dashboard banner
;(defun custom-dashboard-widget-banner ()
;  (mapc (lambda (line)
;          (insert (propertize (+doom-dashboard--center +doom-dashboard--width line)
;                              'face 'font-lock-comment-face) " ")
;          (insert "\n"))
;        '("                                           "
;          "███████╗███╗   ███╗ █████╗  ██████╗███████╗"
;          "██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝"
;          "█████╗  ██╔████╔██║███████║██║     ███████╗"
;          "██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║"
;          "███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║"
;          "╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝"
;          "                                           ")))
;(defvar +doom-dashboard-functions '(custom-dashboard-widget-banner
;                                    doom-dashboard-widget-shortmenu
;                                    doom-dashboard-widget-loaded)
;  "List of widget functions to run in the dashboard buffer to construct the
;dashboard. These functions take no arguments and the dashboard buffer is current
;while they run.")

;; Enable gdb many windows.
(setq gdb-many-windows t)
;; python debugger
(setq gud-pdb-command-name "python -m pdb")

;; modeline height
(setq +doom-modeline-height 20)

