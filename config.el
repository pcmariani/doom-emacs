;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Peter Mariani"
      user-mail-address "pcmariani@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; (setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 14)
     doom-variable-pitch-font (font-spec :family "Palatino" :size 14)
     doom-serif-font (font-spec :family "Luminari" :size 14))
(setq doom-font-increment 1)
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-ir-black)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; prevent annoying flycheck checkdoc in elisp mode
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; ----------------------------------------------------------------------------

;; SETTINGS
;; --------

;; https://systemcrafters.net/emacs-from-scratch/the-best-default-settings/
(global-auto-revert-mode 1) ;; Revert buffers when the underlying file has changed
(setq global-auto-revert-non-file-buffers t) ;; Revert Dired and other buffers

;; SBCL and Slime
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/opt/homebrew/bin/sbcl")

;; Projectile (this is unnecessary)
(setq projectile-project-search-path '("~/projects/"))

;; org-mode
;; (setq org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿"))
(setq org-superstar-headline-bullets-list '("⋆" "⤷" "⋆" "⋆" "⋆"))
(setq org-hide-emphasis-markers t)

;; plantuml-mode
(setq plantuml-jar-path "/Users/petermariani/.local/lib/plantuml-1.2023.4.jar")
(setq plantuml-default-exec-mode 'jar)
(setq plantuml-indent-level 4)
(add-to-list 'auto-mode-alist '("\\.\\(p\\(lant\\)?\\)?uml\\'" . plantuml-mode))
(with-eval-after-load 'flycheck
  (require 'flycheck-plantuml)
  (flycheck-plantuml-setup))
(use-package diagram-preview
  :load-path "/Users/petermariani/.local/lib/diagram-preview"
  :ensure nil
  :hook ((graphviz-dot-mode plantuml-mode mermaid-mode pikchr-mode d2-mode) . diagram-preview-mode))


;; HOOKS
;; -----

;; Restore the s and S keys to their default vim behavior
(remove-hook 'doom-first-input-hook #'evil-snipe-mode)

;; auto enable skewer mode for js/processing
(add-hook! 'js2-mode-hook 'skewer-mode)
(add-hook! 'css-mode-hook 'skewer-css-mode)
(add-hook! 'html-mode-hook 'skewer-html-mode)

;; MAPPINGS
;; --------

;; Make movement keys work like they should
;; https://stackoverflow.com/questions/20882935/how-to-move-between-visual-lines-and-move-past-newline-in-evil-mode
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
; Make horizontal movement cross lines
(setq-default evil-cross-lines t)

(map! :nvi "C-h" #'evil-window-left)
(map! :nvi "C-j" #'evil-window-down)
(map! :nvi "C-k" #'evil-window-up)
(map! :nvi "C-l" #'evil-window-right)

(map! :nv ";" #'evil-ex)
(map! :nv ":" #'evil-snipe-repeat)

;; (map! :n [tab] #'next-buffer)
;; (map! :n [S-tab] #'previous-buffer)

(map! :nv "M-j" #'drag-stuff-down)
(map! :nv "M-k" #'drag-stuff-up)
(map! :n "M-h" #'drag-stuff-left)
(map! :n "M-l" #'drag-stuff-right)

(map! :n "C-5" #'evil-jump-item)

(map! :nv "R" #'evil-multiedit-match-all)

;; Leader Mappings
(map! :leader
      :desc "Query Replace at Cursor"
      :n "r" #'anzu-query-replace-at-cursor)

(map! :leader
      :desc "Query Replace Regexp"
      :n "R" #'anzu-query-replace-regexp)

(map! :leader
      :desc "Send !! to vterm"
      "v" #'term-send-last )

(map! :leader
      :desc "C-x C-e"
      :after skewer-mode
      :map skewer-mode-map
      "e" #'skewer-eval-last-expression)

;; FUNCTIONS
;; ---------
(defun term-send-last ()
  (interactive)
  "Send !! to term"
  (save-buffer)
  ;; (with-current-buffer "*doom:vterm-popup:main*"
  (with-current-buffer "*vterm*"
    (term-send-raw-string "!!\n\n")))

(defvar current-counter-value 0)
(setq run-commands '(
                     ("boomi" "groovy ~/projects/BoomiTestBed/BoomiTestBed.groovy")
                     ))




;; ----------------------------------------------------------------------------
;; (defun vim-cycle-visual ()
;;   (interactive)
;;   "Cycle visual mode states"
;;        ;; ((eq evil-this-type '))))
;;   (cond
;;    ((eq evil-state 'normal) (evil-visual-char))
;;    ((eq evil-state 'visual)
;;     (cond
;;      ((eq evil-this-type 'inclusive) (evil-visual-line))
;;      ((eq evil-this-type 'line) (evil-visual-char))
;;      ;; ((eq evil-this-type 'block) (evil-visual-char))
;;      )
;;     )
;;    )
;;   )

;; (map! :leader
;;       :desc "Cycle visual modes states"
;;       :nv
;;       "v" #'vim-cycle-visual )
