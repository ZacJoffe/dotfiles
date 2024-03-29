;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; manually set the shell
(setq shell-file-name "/bin/bash")
;(setq shell-file-name "/usr/bin/zsh")

;; add stuff to path
(add-to-list 'exec-path "~/.cargo/bin")
(add-to-list 'exec-path "~/go/bin")

(electric-pair-mode 1)
(add-hook 'after-change-major-mode-hook (lambda() (electric-pair-mode -1)))

; hook for flyspell in org/markdown mode
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'markdown-mode-hook 'flyspell-mode)

;; (use-package! cquery
;;   :init
;;   (setq cquery-executable "/usr/bin/cquery"))

; (setq doom-font (font-spec :family "Hack" :size 22 :weight 'semi-light))
; (setq doom-font (font-spec :family "DejaVu Sans Mono" :size 22 :weight 'light))
; (setq doom-font (font-spec :family "Roboto Mono" :size 22 :weight 'semi-light))
(setq doom-font (font-spec :family "Iosevka Fixed" :size 26 :weight 'light)
      doom-variable-pitch-font (font-spec :family "Iosevka" :size 26 :weight 'light))

(map! :m "?" #'consult-line)

;(debug-on-variable-change 'company-active-map)
;(define-key! company-active-map
;  "TAB" #'company-complete-selection
;  [tab] #'company-complete-selection)

(map! (:after company
        (:map company-active-map
          "TAB" #'company-complete-selection
          [tab] #'company-complete-selection))
      :m
      "C-a" #'bury-buffer
      "C-S-a" #'unbury-buffer)
(map! :m "C-z" #'buffer-menu)

(setq projectile-project-search-path '("~/Documents/Code"))

;(after! smartparens (smartparens-global-mode -1)) ; no long correct https://github.com/hlissner/doom-emacs/blob/develop/docs/faq.org#how-to-disable-smartparensautomatic-parentheses-completion
;(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

; load doom themes
;(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

(load-theme 'doom-dracula t)
(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

;(require 'lsp)
;(add-hook 'd-mode-hook #'lsp)
;(lsp-register-client
;    (make-lsp-client
;        :new-connection (lsp-stdio-connection '("/home/zac/.dub/packages/.bin/dls-latest/dls"))
;        :major-modes '(d-mode)
;        :server-id 'dls))

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
;(require 'sublimity)
;(require 'sublimity-scroll)
;(sublimity-mode 1)

; vim-like relative line numbers
(setq display-line-numbers-type 'relative)

;; (require 'company-lsp)
;; (push 'company-lsp company-backends)

; company fuzzy matching
(with-eval-after-load 'company
  (company-flx-mode +1))

; use clangd as lsp client for c/c++
; (after! lsp-clients
  ; (set-lsp-priority! 'clangd 1)
  ; (setq lsp-clients-clangd-args '("--log" "verbose" "--query-driver=/usr/bin/clang++")))

(setq ccls-executable "/usr/bin/ccls")

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

; (defun clang-format-buffer-smart-on-save ()
; (interactive)
;   "Add auto-save hook for clang-format-buffer-smart."
;   (add-hook 'before-save-hook 'clang-format-buffer-smart nil t))

; (add-hook! (c-mode c++-mode cc-mode) #'clang-format-buffer-on-save)

;(after! lsp-clients
;  (set-lsp-priority! 'clangd 1))  ; ccls has priority 0

; zoom in all buffers
;(defadvice text-scale-increase (around all-buffers (arg) activate)
;  (dolist (buffer (buffer-list))
;    (with-current-buffer buffer
;      ad-do-it)))

; pdf dark mode hook
(add-hook 'pdf-tools-enabled-hook 'pdf-view-midnight-minor-mode)

(setq org-directory "~/Documents/Google/org")
(setq org-roam-directory "~/Documents/Google/org/roam")
(setq deft-directory org-roam-directory)
(setq org-agenda-files '("~/Documents/Google/org/roam/agenda")) ; https://stackoverflow.com/a/11384907

; https://www.reddit.com/r/emacs/comments/e72m9j/evilsurround_shortcuts_in_doom_coming_from/f9uvh9t/
(after! evil-surround
  (let ((pairs '((?g "$" . "$")
                 (?h "(" . ")")
                 (?j "[" . "]")
                 (?k "{" . "}")
                 (?l "<" . ">")
                 (?ø "'" . "'")
                 (?æ "\"" . "\""))))
    (prependq! evil-surround-pairs-alist pairs)
    (prependq! evil-embrace-evil-surround-keys (mapcar #'car pairs))))

; autosave org mode buffers https://emacs.stackexchange.com/a/38068
;(add-hook 'auto-save-hook 'org-save-all-org-buffers) ; escapes insert mode?


; (defun open-org-agenda-files ()
;   "Browse your `org-agenda-files' dir."
;   (interactive)
;   (unless (file-directory-p org-agenda-files)
;     (make-directory org-agenda-files t))
;   (doom-project-browse org-agenda-files))

(after! org
  (setq org-agenda-span 10) ; https://stackoverflow.com/a/32426234
  (setq org-agenda-start-on-weekday nil)
  (setq org-todo-keywords
    '((sequence "TODO(t)" "EXAM(e)" "WAIT(w)" "|" "DONE(d)" "KILL(k)" "SKIPPED(s)" "LATE(s)"))))

;(setq display-line-numbers-mode 1) ; always show line numbers
;(global-display-line-numbers-mode)

; syntax highlighting with minted for org latex exports
; https://stackoverflow.com/a/21007117
(setq org-latex-listings 'minted)
(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

; override doom's default (jk)
(setq evil-escape-key-sequence "ESC")
