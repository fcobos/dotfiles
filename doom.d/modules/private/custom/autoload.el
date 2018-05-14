;;;###autoload
(defun +cc|init-semantic ()
  (when (memq major-mode '(c-mode c++-mode))
    (require 'semantic)
    (semantic-mode 1)))

;;;###autoload
(defun +cc|init-srefactor ()
  (when (memq major-mode '(cmode c++-mode))
    (require 'srefactor)))

