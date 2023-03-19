(setq user-full-name "Aleksandr Zakharov")
(setq user-mail-address "aleksandrzakharov91@gmail.com")

;;Save
(setq auto-save-default t)

;;Backups
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq auto-save-list-file-name nil)

(defalias 'yes-or-no-p 'y-or-n-p)

;;Setup package
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
;;(package-refresh-contents)
(package-initialize)
(require 'use-package)

;;UI
(scroll-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(global-display-line-numbers-mode 1)
(global-visual-line-mode t)
(set-face-attribute 'default nil :family "JetBrains Mono" :height 120)


(use-package apropospriate-theme
  :ensure t
  :config 
  (load-theme 'apropospriate-dark t))

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

;;Reverse-im
(use-package reverse-im
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


;;Dev
(use-package flycheck
  :ensure t
  :hook ((emacs-lisp-mode clojure-mode) . flycheck-mode))

(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

(use-package projectile
  :config
  (projectile-global-mode 1))

(use-package company :ensure t)

;;Clojure
(use-package cider
  :ensure t)
(use-package paredit :ensure t)

;;Terminal
(use-package vterm)


;;(set-face-attribute 'mode-line nil
;;:background ""
;;:foreground ""
;;:box '(:line-width 8 :color "")
;; :overline nil
;; :underline nil
;;)

;;(set-face-attribute 'mode-line-inactive nil
;;:background ""
;;foreground ""
;; :box '(:line-width 8 :color "")
;; :overline nil
;; :underline nil
;;)
