;; -*- no-byte-compile: t; -*-
;;; private/cc-lsp/packages.el

(package! lsp-mode)

;; extra stuff
(package! cmake-mode)
(package! cuda-mode)
(package! demangle-mode)
(package! disaster)
(package! modern-cpp-font-lock)
(package! opencl-mode)

(when (package! glsl-mode)
  (when (featurep! :completion company)
    (package! company-glsl)))
