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

(defconst ccpp-packages
  '(
    irony
    company-irony
    flycheck
    flycheck-irony
    irony-eldoc
    company-irony-c-headers
    rtags
    helm-rtags
    clang-format
    disaster
    cmake-mode
    semantic
    srefactor
    realgud
    )
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

(defun ccpp/post-init-company ()
      (global-company-mode t)
      ;; setup company backends
      (add-hook 'after-init-hook 'global-company-mode)
      (setq company-backends (delete 'company-clang company-backends))
      )

(defun ccpp/init-company-irony ()
  (use-package company-irony
    :config
    (progn
    (eval-after-load 'company
      '(add-to-list 'company-backends '(company-irony)))
    )
    )
  )

(defun ccpp/init-company-irony-c-headers ()
  (use-package company-irony-c-headers
    :config
    (progn
    (eval-after-load 'company
      '(add-to-list 'company-backends '(company-irony-c-headers)))
    )
    )
  )


(defun ccpp/init-semantic ()
  (use-package semantic
    :defer t
    :config
    (progn
      ;; setup semantic
      ;; (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
      (setq srecode-map-save-file (concat spacemacs-cache-directory "srecode-map.el"))
      (setq semanticdb-default-save-directory (concat spacemacs-cache-directory "semanticdb/"))
      (setq semanticdb-find-default-throttle '(file local project))
      (unless (file-exists-p semanticdb-default-save-directory)
        (make-directory semanticdb-default-save-directory))
      (semantic-mode 1)
      )
    )
  )

(defun ccpp/init-srefactor ()
  (use-package srfactor
    :defer t))

(defun ccpp/init-irony ()
  (use-package irony
    :config
    (progn
      ;; setup irony-mode
      (add-hook 'c++-mode-hook 'irony-mode)
      (add-hook 'c-mode-hook 'irony-mode)
      (add-hook 'objc-mode-hook 'irony-mode)
      (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
      )))

(defun ccpp/init-irony-eldoc ()
  (use-package irony-eldoc
    :config
    (progn
      (add-hook 'irony-mode-hook #'irony-eldoc))))

(defun ccpp/init-flycheck-irony ()
  (use-package flycheck-irony
    :config
    (progn
      (with-eval-after-load 'flycheck
        (require 'flycheck-irony)
        (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
        (flycheck-add-next-checker 'irony '(warning . c/c++-cppcheck))))))

(defun ccpp/init-rtags ()
  (use-package rtags
    :config
    (progn
  ;; setup rtags
  (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
  (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
  (add-hook 'objc-mode-hook 'rtags-start-process-unless-running)
  (rtags-enable-standard-keybindings)
  )))

(defun ccpp/init-helm-rtags ()
  (use-package helm-rtags
    :config
    (progn
      (setq rtags-display-result-backend 'helm))))

(defun ccpp/post-init-flycheck ()
  ;; enable flycheck for c-c++
  (add-hook 'c++-mode-hook 'flycheck-mode)
  (add-hook 'c-mode-hook 'flycheck-mode)
  )

(defun ccpp/init-realgud ()
  (use-package realgud
    :defer t))

(defun ccpp/init-cmake-mode ()
  (use-package cmake-mode
    :defer t))

(defun ccpp/init-disaster ()
  (use-package disaster
    :defer t
      ))

(defun ccpp/init-clang-format ()
  (use-package clang-format
    :defer t))

;;; packages.el ends here
