;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq shell-file-name "/bin/bash")
(electric-pair-mode 1)

(def-package! cquery
  :init
  (setq cquery-executable "/usr/bin/cquery"))

(setq doom-font (font-spec :family "Fira Mono" :size 18))
