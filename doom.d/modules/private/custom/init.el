;; Disable cursor blink
(add-hook 'doom-post-init-hook (lambda () (blink-cursor-mode 0)))
(setq visible-cursor nil)
;; Disable whitespace-mode
(add-hook 'doom-post-init-hook (lambda ()
  (remove-hook 'editorconfig-custom-hooks 'doom|editorconfig-whitespace-mode-maybe)))
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


