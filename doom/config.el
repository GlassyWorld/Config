;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Editor
(setq display-line-numbers-type 'relative)

;; Font
(setq doom-font
      (font-spec :family "JetBrains Mono"
                 :size 15
                 :weight 'regular))

;; Frame
(add-to-list 'initial-frame-alist '(width . 120))
(add-to-list 'initial-frame-alist '(height . 42))

(add-to-list 'default-frame-alist '(width . 120))
(add-to-list 'default-frame-alist '(height . 42))

;; Theme
(setq doom-theme 'doom-one)
