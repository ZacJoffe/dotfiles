;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq shell-file-name "/bin/bash")
(electric-pair-mode 1)

(def-package! cquery
  :init
  (setq cquery-executable "/usr/bin/cquery"))

(setq doom-font (font-spec :family "Fira Mono" :size 18))

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
