;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; manually set the shell
;; (setq shell-file-name "/bin/bash")
(setq shell-file-name "/usr/bin/zsh")

;; add stuff to path
(add-to-list 'exec-path "~/.cargo/bin")
(add-to-list 'exec-path "~/go/bin")

(electric-pair-mode 1)
(add-hook 'after-change-major-mode-hook (lambda() (electric-pair-mode -1)))
(add-hook 'prog-mode-hook 'tab-jump-out-mode)

;; (use-package! cquery
;;   :init
;;   (setq cquery-executable "/usr/bin/cquery"))

; (setq doom-font (font-spec :family "Hack" :size 20))
(setq doom-font (font-spec :family "Hack" :size 22))

; (map! :m "/" #'swiper)
(map! :m "/" #'counsel-grep-or-swiper)
(map! :m "?" #'+default/search-project)

; use rg instead of grep for counsel grp
(setq counsel-grep-base-command
 "rg -i -M 120 --no-heading --line-number --color never '%s' %s")

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

;; (load-theme 'doom-gruvbox t)
(load-theme 'doom-material t)

(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/Documents/Code/tab-jump-out")

;; load the packaged named xyz.
(load "tab-jump-out") ;; best not to include the ending “.el” or “.elc”

;; (defvar-local tab-jump-out-delimiters '(";" "(" ")" "[" "]" "{" "}" "|" "'" "\"" "`" "\\" "<" ">")
;;   "The delimiters indicate `tab-jump-out' should jump out.")

;; (defun tab-jump-out (arg)
;;   "Use tab to jump out."
;;   (interactive "P")
;;   (if (and (char-after)
;;            (-contains? tab-jump-out-delimiters (char-to-string (char-after))))
;;       (forward-char arg)
;;     (tab-jump-out-fallback)))

;; (global-set-key [remap indent-for-tab-command]
;;   'tab-jump-out)


(require 'lsp)
(add-hook 'd-mode-hook #'lsp)
(lsp-register-client
    (make-lsp-client
        :new-connection (lsp-stdio-connection '("/home/zac/.dub/packages/.bin/dls-latest/dls"))
        :major-modes '(d-mode)
        :server-id 'dls))

(defun my-backward-kill-word ()
  "Kill words backward my way."
  (interactive)
  (if (bolp)
      (backward-delete-char 1)
    (if (string-match "^\\s-+$" (buffer-substring (point-at-bol) (point)))
        (kill-region (point-at-bol) (point))
      (backward-kill-word 1))))

(defun my-backward-kill-line ()
  "Easy formatting!"
  (interactive)
  (my-backward-kill-word)
  (backward-delete-char 1)
  ;; (c-electric-backspace 1)
  (insert " "))

(global-set-key [C-backspace] 'my-backward-kill-word)
(global-set-key (kbd "<M-backspace>") 'my-backward-kill-line)


;; recenter when jumping
;; (setq mouse-wheel-scroll-amount '(1 ((shift) . 3) ((control)))
;;       scroll-conservatively 3
;;       scroll-margin 3
;;       maximum-scroll-margin 0.2)

;; (setq-hook! 'intero-repl-mode-hook scroll-margin 0)
;; (setq-hook! 'term-mode-hook scroll-margin 0)


; show trailing whitespace
(setq-default show-trailing-whitespace nil)

(add-hook! (prog-mode text-mode conf-mode)
  (defun doom-enable-show-trailing-whitespace-h ()
    (setq show-trailing-whitespace t)))

; smoother scrolling
(require 'sublimity)
(require 'sublimity-scroll)
(sublimity-mode 1)

; vim-like relative line numbers
(setq display-line-numbers-type 'relative)

(require 'company-lsp)
(push 'company-lsp company-backends)

; company fuzzy matching
(with-eval-after-load 'company
  (company-flx-mode +1))

; use clangd as lsp client for c/c++
(after! lsp-clients
  (set-lsp-priority! 'clangd 1)
  (setq lsp-clients-clangd-args '("--log" "verbose" "--query-driver=/usr/bin/clang++")))

; org roam
(after! org-roam
        (map! :leader
            :prefix "n"
            :desc "org-roam" "l" #'org-roam
            :desc "org-roam-insert" "i" #'org-roam-insert
            :desc "org-roam-switch-to-buffer" "b" #'org-roam-switch-to-buffer
            :desc "org-roam-find-file" "f" #'org-roam-find-file
            :desc "org-roam-show-graph" "g" #'org-roam-show-graph
            :desc "org-roam-capture" "c" #'org-roam-capture))

(use-package! org-journal
  :config
  (setq org-journal-dir "~/org/roam/"))

; display superscripts/subscripts normally
(setq font-latex-fontify-script nil)

;; Make movement keys work like they should
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
; Make horizontal movement cross lines
(setq-default evil-cross-lines t)

; https://dotdoom.rgoswami.me/config.html#org94a9690
(defun clang-format-buffer-smart ()
(interactive)
  "Reformat buffer if .clang-format exists in the projectile root."
  (when (f-exists? (expand-file-name ".clang-format" (projectile-project-root)))
    (+format/buffer)))

(defun clang-format-buffer-smart-on-save ()
(interactive)
  "Add auto-save hook for clang-format-buffer-smart."
  (add-hook 'before-save-hook 'clang-format-buffer-smart nil t))

(add-hook! (c-mode c++-mode cc-mode) #'clang-format-buffer-on-save)

