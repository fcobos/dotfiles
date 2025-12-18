;; -*- no-byte-compile: t; -*-
;;; ../dotfiles/doom.d/packages.el
(package! basic-mode
  :recipe (:host github :repo "fcobos/basic-mode" :files ("*.el" "src/*.el")))
(package! platformio-mode)
(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))
