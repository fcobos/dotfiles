;;
;; Semantic support
;;
(def-package! semantic
  :init
  (add-hook! (c-mode c++-mode) #'+cc|init-semantic)
  :config
  ;; setup semantic
  ;; (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
  (setq srecode-map-save-file (concat doom-cache-dir "srecode-map.el"))
  (setq semanticdb-default-save-directory (concat doom-cache-dir "semanticdb/"))
  (setq semanticdb-find-default-throttle '(file local project))
  (unless (file-exists-p semanticdb-default-save-directory)
    (make-directory semanticdb-default-save-directory)))

;;
;; Srefactor support
;;
(def-package! srefactor
  :init
  (add-hook! (c-mode c++-mode) #'+cc|init-srefactor)
  ;; currently, evil-mode overrides key mapping of srefactor menu
  ;; must expplicity enable evil-emacs-state. This is ok since
  ;; srefactor supports j,k,/ and ? commands when Evil is
  ;; available
  :config
  (add-hook! 'srefactor-ui-menu-mode-hook 'evil-emacs-state))
