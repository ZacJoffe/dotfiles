;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq shell-file-name "/bin/bash")
(electric-pair-mode 1)

(def-package! cquery
  :init
  (setq cquery-executable "/usr/bin/cquery"))

(setq doom-font (font-spec :family "Hack" :size 20))

(map! :m "/" #'swiper)

;(debug-on-variable-change 'company-active-map)
;(define-key! company-active-map
;  "TAB" #'company-complete-selection
;  [tab] #'company-complete-selection)

(map! (:after company
        (:map company-active-map
          "TAB" #'company-complete-selection
          [tab] #'company-complete-selection))
      :m
      "C-z" #'bury-buffer
      "C-S-z" #'unbury-buffer)

(setq projectile-project-search-path '("~/Documents/Code"))

(after! smartparens (smartparens-global-mode -1))


; load doom themes
;(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

(load-theme 'doom-gruvbox t)

(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)
