;;enable clang-format on save for projects with a .clang-format file at its root
(defun clang-format-buffer-smart ()
  "Reformat buffer if .clang-format exists in the projectile root."
  (when (f-exists? (expand-file-name ".clang-format"
                                     (projectile-project-root)))
    (clang-format-buffer)))
(defun clang-format-buffer-smart-on-save ()
  "Add auto-save hook for clang-format-buffer-smart."
  (add-hook 'before-save-hook 'clang-format-buffer-smart
            nil t))
(spacemacs/add-to-hooks 'clang-format-buffer-smart-on-save
                        '(c-mode-hook c++-mode-hook))

;; disable syntactic-indentation
(require 'cc-mode)
(add-to-list 'c-mode-common-hook
             (lambda ()
               (setq c-syntactic-indentation nil)))

;; jump handlers
(spacemacs|define-jump-handlers c++-mode)
(spacemacs|define-jump-handlers c-mode)
