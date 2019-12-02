;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq shell-file-name "/bin/bash")
(electric-pair-mode 1)
(add-hook 'prog-mode-hook 'tab-jump-out-mode)

(use-package! cquery
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

;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/Documents/Code/george-mode")
;; (add-to-list 'load-path "~/Documents/Code/tab-jump-out")

;; load the packaged named xyz.
(load "george-mode") ;; best not to include the ending “.el” or “.elc”
;; (load "tab-jump-out") ;; best not to include the ending “.el” or “.elc”

(defvar-local tab-jump-out-delimiters '(";" "(" ")" "[" "]" "{" "}" "|" "'" "\"" "`" "\\" "<" ">")
  "The delimiters indicate `tab-jump-out' should jump out.")

(defun tab-jump-out (arg)
  "Use tab to jump out."
  (interactive "P")
  (if (and (char-after)
           (-contains? tab-jump-out-delimiters (char-to-string (char-after))))
      (forward-char arg)
    (tab-jump-out-fallback)))

(global-set-key [remap indent-for-tab-command]
  'tab-jump-out)
