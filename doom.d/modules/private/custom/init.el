;; Maximize frame
(add-hook 'doom-init-hook (lambda () (toggle-frame-maximized)))

;; Set the font
(setq doom-font (font-spec :family "Hack" :size 12)
      doom-big-font (font-spec :family "Hack" :size 24)
      doom-variable-pitch-font (font-spec :family "Noto Sans")
      doom-unicode-font (font-spec :family "DejaVu Sans Mono"))
(setq-default line-spacing 0)

;; Set the theme
;(setq doom-theme 'doom-molokai)

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
(defun custom-dashboard-widget-banner ()
  (mapc (lambda (line)
          (insert (propertize (+doom-dashboard--center +doom-dashboard--width line)
                              'face 'font-lock-comment-face) " ")
          (insert "\n"))
        '("                                           "
          "███████╗███╗   ███╗ █████╗  ██████╗███████╗"
          "██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝"
          "█████╗  ██╔████╔██║███████║██║     ███████╗"
          "██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║"
          "███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║"
          "╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝"
          "                                           ")))
(defvar +doom-dashboard-functions '(custom-dashboard-widget-banner
                                    doom-dashboard-widget-shortmenu
                                    doom-dashboard-widget-loaded)
  "List of widget functions to run in the dashboard buffer to construct the
dashboard. These functions take no arguments and the dashboard buffer is current
while they run.")

;; Enable gdb many windows.
(setq gdb-many-windows t)

;; qml-mode
(autoload 'qml-mode "qml-mode" "Editing Qt Declarative." t)
(add-to-list 'auto-mode-alist '("\\.qml$" . qml-mode))

