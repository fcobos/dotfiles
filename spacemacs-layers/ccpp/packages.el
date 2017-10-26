;;; packages.el --- ccpp layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Felix M. Cobos <felix.cobos@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `ccpp-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `ccpp/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `ccpp/pre-init-PACKAGE' and/or
;;   `ccpp/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst ccpp-packages '(cc-mode irony company-irony flycheck flycheck-irony
                                  irony-eldoc company-irony-c-headers rtags
                                  helm-rtags clang-format disaster cmake-mode
                                  semantic srefactor gdb-mi)
  "The list of Lisp packages required by the ccpp layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun ccpp/init-cc-mode ()
  (use-package cc-mode
    :defer t
    :init (progn
            (add-to-list 'auto-mode-alist
                         `("\\.h\\'" . c++-mode))):config
    (progn
      (require 'compile)
      (c-toggle-auto-newline 1)
      (spacemacs/set-leader-keys-for-major-mode
        'c-mode "ga" 'projectile-find-other-file "gA"
        'projectile-find-other-file-other-window)
      (spacemacs/set-leader-keys-for-major-mode
        'c++-mode "ga" 'projectile-find-other-file
        "gA" 'projectile-find-other-file-other-window))))

(defun ccpp/post-init-company ()
  (global-company-mode t)
  ;; setup company backends
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-backends (delete 'company-clang company-backends)))

(defun ccpp/init-company-irony ()
  (use-package company-irony
    :defer t
    :init (progn
            (eval-after-load 'company
              '(add-to-list 'company-backends
                            '(company-irony))))))

(defun ccpp/init-company-irony-c-headers ()
  (use-package company-irony-c-headers
    :defer t
    :init (progn
            (eval-after-load 'company
              '(add-to-list 'company-backends
                            '(company-irony-c-headers))))))


(defun ccpp/init-semantic ()
  (use-package semantic
    :defer t
    :init (progn
            ;; setup semantic
            ;; (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
            (setq srecode-map-save-file (concat spacemacs-cache-directory "srecode-map.el"))
            (setq semanticdb-default-save-directory (concat spacemacs-cache-directory "semanticdb/"))
            (setq semanticdb-find-default-throttle '(file local project))
            (unless (file-exists-p semanticdb-default-save-directory)
              (make-directory semanticdb-default-save-directory))
            (spacemacs/add-to-hooks 'semantic-mode
                                    '(c-mode-hook c++-mode-hook))
            (semantic-mode 1))))

(defun ccpp/init-srefactor ()
  (use-package srefactor
    :defer t
    :init (progn
            (defun spacemacs/lazy-load-srefactor ()
              "Lazy load the package."
              (require 'srefactor)
              ;; currently, evil-mode overrides key mapping of srefactor menu
              ;; must expplicity enable evil-emacs-state. This is ok since
              ;; srefactor supports j,k,/ and ? commands when Evil is
              ;; available
              (add-hook 'srefactor-ui-menu-mode-hook 'evil-emacs-state))):config
    (progn
      (spacemacs/set-leader-keys-for-major-mode
        'c-mode "r" 'srefactor-refactor-at-point)
      (spacemacs/set-leader-keys-for-major-mode
        'c++-mode "r" 'srefactor-refactor-at-point))))

(defun ccpp/init-irony ()
  (use-package irony
    :defer t
    :init (progn
            ;; setup irony-mode
            (add-hook 'c++-mode-hook 'irony-mode)
            (add-hook 'c-mode-hook 'irony-mode)
            (add-hook 'objc-mode-hook 'irony-mode)
            (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))))

(defun ccpp/init-irony-eldoc ()
  (use-package irony-eldoc
    :defer t
    :init (progn
            (add-hook 'irony-mode-hook #'irony-eldoc))))

(defun ccpp/init-flycheck-irony ()
  (use-package flycheck-irony
    :defer t
    :init (progn
            (with-eval-after-load 'flycheck
              (require 'flycheck-irony)
              (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
              (flycheck-add-next-checker 'irony
                                         '(warning . c/c++-cppcheck))))))

(defun ccpp/init-rtags ()
  (use-package rtags
    :defer t
    :init (progn
            ;; setup rtags
            (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
            (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
            (add-hook 'objc-mode-hook 'rtags-start-process-unless-running)
            (rtags-enable-standard-keybindings))))

(defun ccpp/init-helm-rtags ()
  (use-package helm-rtags
    :defer t
    :init (progn
            (setq rtags-display-result-backend 'helm))))

(defun ccpp/post-init-flycheck ()
  ;; enable flycheck for c-c++
  (add-hook 'c++-mode-hook 'flycheck-mode)
  (add-hook 'c-mode-hook 'flycheck-mode))

(defun ccpp/init-cmake-mode ()
  (use-package cmake-mode
    :mode (("CMakeLists\\.txt\\'" . cmake-mode)
           ("\\.cmake\\'" . cmake-mode)):init
    (
     ;;push 'company-cmake company-backends-cmake-mode
     )))

(defun ccpp/init-disaster ()
  (use-package disaster
    :defer t
    :commands (disaster):init
    (progn
      (spacemacs/set-leader-keys-for-major-mode
        'c-mode "D" 'disaster)
      (spacemacs/set-leader-keys-for-major-mode
        'c++-mode "D" 'disaster))))

(defun ccpp/init-clang-format ()
  (use-package clang-format :defer t))

(defun ccpp/init-gdb-mi ()
  (use-package gdb-mi
    :defer t
    :init (setq
           ;; use gdb-many-windows by default when `M-x gdb'
           gdb-many-windows t
           ;; Non-nil means display source file containing the main routine at startup
           gdb-show-main t)))

;;; packages.el ends here
