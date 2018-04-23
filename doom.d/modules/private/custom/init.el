;; Disable cursor blink
(add-hook 'doom-post-init-hook (lambda () (blink-cursor-mode 0)))
(setq visible-cursor nil)
;; Disable whitespace-mode
(add-hook 'doom-post-init-hook (lambda () 
  (remove-hook 'editorconfig-custom-hooks 'doom|editorconfig-whitespace-mode-maybe)))

