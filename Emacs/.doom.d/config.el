;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Clay"
      user-mail-address "15832827782@163.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
;; (setq doom-theme 'doom-one)


;; looks
(setq doom-modeline-height 40
      +doom-modeline-buffer-file-name-style 'relative-from-project
      doom-theme 'doom-dracula
      +workspaces-switch-project-function #'ignore)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:

(setq display-line-numbers-type t)
(setq confirm-kill-emacs nil)



;; Show week numbers in calendar
(setq calendar-week-start-day 1
      calendar-intermonth-text
      '(propertize
        (format "%2d"
                (car
                 (calendar-iso-from-absolute
                  (calendar-absolute-from-gregorian (list month day year)))))
        'font-lock-face 'font-lock-function-name-face))




;;
;; Command Log
(use-package! command-log-mode
  :commands global-command-log-mode
  :config
  (setq command-log-mode-auto-show t
        command-log-mode-open-log-turns-on-mode nil
        command-log-mode-is-global t
        command-log-mode-window-size 50))


;;
;; Auto-formatting
;; (add-hook 'c++-mode-hook #'+format|enable-on-save)
(add-hook 'before-save-hook (lambda ()  (when (eq major-mode 'python-mode) (lsp-format-buffer))))
(setq show-trailing-whitespace nil)




;;
;; PDF
(after! pdf-tools
  ;; customize midnight-mode colors
  (setq pdf-view-midnight-colors '("#FFFFFF" . "#000000"))
  (map!
   :map pdf-view-mode-map
   :desc "pdf-occur" :nmi "C-s" #'pdf-occur))


;;
;; load other config files
(load! "+org")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
