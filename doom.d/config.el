;;; config.el -*- lexical-binding: t; -*-

;; set dark windows decorations
(defun get-frame-name (&optional frame)
  "Return the string that names FRAME (a frame).  Default is selected frame."
  (unless frame (setq frame  (selected-frame)))
  (if (framep frame)
      (cdr (assq 'name (frame-parameters frame)))
    (error "Function `get-frame-name': Argument not a frame: `%s'" frame)))

(defun set-selected-frame-dark ()
  (interactive)
  (let ((frame-name (get-frame-name (selected-frame))))
    (call-process-shell-command
     (concat "xprop -f _GTK_THEME_VARIANT 8u -set _GTK_THEME_VARIANT \"dark\" -name \""
             frame-name
             "\""))))
(when (display-graphic-p) (set-selected-frame-dark))

;; Set the font
(setq doom-font (font-spec :family "Iosevka SS04" :size 14)
      doom-big-font (font-spec :family "Iosevka SS04" :size 24)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans Condensed" :size 14))
(setq-default line-spacing 1)

;; Set the theme
(setq doom-theme 'doom-tomorrow-night)
;; disable solaire-mode
(solaire-mode 0)
(add-hook 'after-change-major-mode-hook (lambda ()
                                          (interactive) (solaire-mode 0)))
;; force solaire-mode
;;(solaire-mode 1)
;;(add-hook 'after-change-major-mode-hook (lambda ()
;;                                          (interactive) (solaire-mode 1)))

;; Set line numbers style
(setq display-line-numbers-type 'relative)

;; Disable cursor blink
;;(defun disable-cursor-blink ()
;;  (blink-cursor-mode -1))
;;(add-hook 'window-setup-hook #'disable-cursor-blink)

;; Disable whitespace-mode
(defun disable-white-space-mode ()
  (whitespace-mode 0))
(add-hook 'after-change-major-mode-hook #'disable-white-space-mode)

;; Enable gdb many windows.
(setq gdb-many-windows t)
;; python debugger
(setq gud-pdb-command-name "python -m pdb")

;; modeline height
(setq +doom-modeline-height 22)

;; open *rc files as conf-mode
(add-to-list 'auto-mode-alist '("\\rc$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\vimrc$" . vimrc-mode))
(add-to-list 'auto-mode-alist '("\\zshrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\bashrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("Pipfile" . toml-mode))
(add-to-list 'auto-mode-alist '("Pipfile.lock" . json-mode))
(add-to-list 'auto-mode-alist '("\\patch$" . diff-mode))

;; make postframe stop moving my mouse pointer, kthxbai
(defun disable-posframe-mouse-banish ()
  (setq posframe-mouse-banish nil))
(add-hook 'flycheck-mode-hook #'disable-posframe-mouse-banish)

;; enable rainbow delimiters for programming modes
(defun set-rainbow-max-face-count ()
  (setq rainbow-delimiters-max-face-count 4))
(add-hook 'rainbow-delimiters-mode-hook #'set-rainbow-max-face-count)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'parinfer-mode-hook 'rainbow-delimiters-mode)

;; use treemacs git deferred mode
(after! treemacs
  (treemacs-git-mode 'deferred))
;; don't use variable pitch font for treemacs
(after! doom-themes
  (setq doom-treemacs-enable-variable-pitch nil))

;; show flycheck indicators on the right side
(after! flycheck
  (setq flycheck-indication-mode 'right-fringe)
  ;; left arrow
  (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
    [16 48 112 240 112 48 16] nil nil 'center))

;; eshell maximum lines of scrollback
(setq eshell-buffer-maximum-lines 1000)
(add-hook 'eshell-output-filter-functions #'eshell-truncate-buffer)

;; modeline file name
;;(setq +modeline-buffer-path-function #'+modeline-file-name)

;; use bash for terminals
(setq multi-term-program "/bin/bash")

;; setup default indentation
(setq indent-tabs-mode 't)
(setq-default tab-width 8)
(setq default-tab-width 8)
(setq c-basic-offset 8)
(c-set-offset 'case-label '+)

;; autodetect indentation settings
(add-hook 'prog-mode-hook (lambda () (interactive) (dtrt-indent-mode 1)))

;; use eww to open urls
(setq +lookup-open-url-fn 'eww)

;; Maximize frame at startup
(when (display-graphic-p)
  (setq frame-resize-pixelwise 't)
  (add-hook 'after-init-hook (lambda ()
                               (toggle-frame-maximized))))

;;; config.el ends here
