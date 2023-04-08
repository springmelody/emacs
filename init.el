(setq user-full-name "Aleksandr Zakharov")
(setq user-mail-address "aleksandrzakharov91@gmail.com")

;;Save
(setq auto-save-default t)

;;Backups
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq auto-save-list-file-name nil)

;;Y-N
(defalias 'yes-or-no-p 'y-or-n-p)

;;Evil

(use-package evil																		    ;;
  :ensure t																				    ;;
  :init																					    ;;
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default. ;;
  (setq evil-want-keybinding nil)														    ;;
  :config																				    ;;
  (evil-mode 1))																			    ;;
																							    ;;
(use-package evil-collection																    ;;
  :after evil																			    ;;
  :ensure t																				    ;;
  :config																				    ;;
  (evil-collection-init))																    ;;

 

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


;;UI
(scroll-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq-default tab-width          4)
(setq-default c-basic-offset     4)
(setq-default standart-indent    4)
(setq-default lisp-body-indent   2)
(setq lisp-indent-function  'common-lisp-indent-function)
(column-number-mode)
(global-display-line-numbers-mode t)
(setq next-line-add-newlines t)
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
		vterm-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(set-face-attribute 'default nil :family "JetBrains Mono" :height 120)
;;(load-theme 'zenburn t)
(use-package doom-themes
  :init (load-theme 'doom-nova t))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))


(use-package all-the-icons)

(use-package dashboard
  :init       (dashboard-setup-startup-hook)
  :bind ("C-c d" . dashboard-open)
  :config
  (require 'dashboard)
  (setq dashboard-center-content nil)
  (setq dashboard-startup-banner "~/.config/emacs/img/gnu.png") 
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3))))

;;Open project
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/dev")
    (setq projectile-project-search-path '("~/dev")))
  (setq projectile-switch-project-action #'projectile-dired))

;;Vertico
(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

;;Avy
(use-package avy)
(global-set-key (kbd "M-j") 'avy-goto-char-timer)

;;Orderless
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;;Consult(default)
(use-package consult
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  :hook (completion-list-mode . consult-preview-at-point-mode)

  :init
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any))

  (setq consult-narrow-key "<"))

;;Ace-window
(use-package ace-window
  :ensure t
  :bind
  (("M-o" . ace-window)))

;;Reverse-im
(use-package reverse-im
  :ensure t
  :config
  (reverse-im-activate "russian-computer"))

;;Which-key
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(setq which-key-idle-delay 0.5)
(setq which-key-idle-secondary-delay 0)


;;Magit
(use-package magit
  :ensure t
  :bind
  (("C-c g" . magit-status)))

; ==================DEV==================
(use-package flycheck
  :ensure t
  :hook ((emacs-lisp-mode clojure-mode) . flycheck-mode))

(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

(use-package company :ensure t)

;;Clojure
(use-package cider
  :ensure t)
(use-package paredit
  :ensure t
  :init
  (paredit-mode))

;;Terminal
(use-package vterm)

;;Common Lisp
(use-package sly :ensure t)

;;Frontend
(use-package prettier-js :ensure t)
(use-package yaml-mode :ensure t)
(use-package json-mode :ensure t)
;;Rss
(use-package elfeed
    :ensure t
    :config
    (setq elfeed-feeds
          '("https://planet.emacslife.com/atom.xml"
            "https://sachachua.com/blog/feed/"
            "https://hnrss.org/frontpage")))
