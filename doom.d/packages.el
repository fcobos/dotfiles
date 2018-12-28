;; -*- lexical-binding: t; no-byte-compile: t; -*-
;; emacs-traad for python refactoring
(package! traad)
;; pkgbuild-mode
(package! pkgbuild-mode)
;; workaround evil-matchit bug
(package! evil-matchit :recipe (:fetcher github :repo "redguardtoo/evil-matchit" :commit "7d65b4167b1f0086c2b42b3aec805e47a0d355c4"))
