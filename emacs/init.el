(package-initialize nil)
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-verbose t)
(require 'use-package)
(use-package auto-compile
  :ensure t
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

; A GNU Emacs library to ensure environment variables inside Emacs look the same as in the user's shell
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode t)
(fset 'yes-or-no-p 'y-or-n-p) ;; Answer with y and n instead of yes and no
(global-auto-revert-mode 1) ;; Always reload the file if it changed on disk
(show-paren-mode 1) ;; Highlight matching parens

;; Default frame size
(setq initial-frame-alist
      '((top . 0) (left . 0) (width . 238) (height . 60)))

(setq-default show-trailing-whitespace t
      inhibit-startup-message t
      initial-scratch-message nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Always use two spaces to indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default c-basic-offset 2)
(setq css-indent-offset 2)
(setq js-indent-level 2)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-css-indent-offset 2)

;; Disable beep sound
(setq visible-bell nil)
(setq ring-bell-function (lambda () (message "*beep*")))

; Emacs's traditional method for making buffer names unique adds
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

; An architecture for building themes based on carefully chosen syntax highlighting using a base of sixteen colours
(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-ocean)
  ;(set-face-attribute 'default nil :font "Source Code Pro-13")
  (set-face-attribute 'default nil :font "Monaco-13"))

; This package is a minor mode to visualize blanks (TAB, (HARD) SPACE and NEWLINE)
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)

; The extensible vi layer for Emacs
(use-package evil
  :ensure t
  :config

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      "h" 'evil-window-left
      "j" 'evil-window-down
      "k" 'evil-window-up
      "l" 'evil-window-right
      "w" 'evil-window-delete

      ":" 'helm-M-x

      "s" 'save-buffer))

  (evil-mode 1)

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode 1))
  (use-package evil-matchit
    :ensure t
    :config
    (global-evil-matchit-mode 1)))

; zoom-window provides window zoom like tmux zoom and unzoom.
(use-package zoom-window
  :ensure t
  :config
  (setq zoom-window-mode-line-color "DarkGreen")
  (evil-leader/set-key
    "z" 'zoom-window-zoom))

; Magit is an interface to the version control system Git
(use-package magit
  :ensure t
  :config
  (setq evil-leader/no-prefix-mode-rx '("magit-.*-mode"))
  (evil-leader/set-key
    "gs" 'magit-status
    "gl" 'magit-log-all))

; Emacs incremental completion and selection narrowing framework
(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  (setq helm-M-x-fuzzy-match t
        helm-buffers-fuzzy-matching t)
  (evil-leader/set-key
    "b b" 'helm-buffers-list
    "b t" 'kill-this-buffer)
  (define-key helm-map (kbd "C-j") 'helm-next-line)
  (define-key helm-map (kbd "C-k") 'helm-previous-line)

  (add-to-list 'display-buffer-alist
                    `(,(rx bos "*helm" (* not-newline) "*" eos)
                         (display-buffer-in-side-window)
                         (inhibit-same-window . t)
                         (window-height . 0.4))))

(use-package helm-ag
  :ensure t
  :config
  (setq  helm-ag-base-command "ag --nocolor --nogroup --ignore-case"
         helm-ag-command-option "--all-text"
         helm-ag-insert-at-point 'symbol))

; Project Interaction Library for Emacs
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)

  (use-package helm-projectile
    :ensure t
    :config
    (helm-projectile-on)
    (evil-leader/set-key
      "p p" 'helm-projectile-switch-project
      "p f" 'helm-projectile-find-file
      "p b" 'helm-projectile-switch-to-buffer
      "p k" 'projectile-kill-buffers
      "/" 'helm-projectile-ag)))

(use-package goto-chg :ensure t) ;; Go to last edit

;; Advice commands to execute fullscreen, restoring the window setup when exiting
(use-package fullframe
  :ensure t
  :config
  (fullframe magit-status magit-mode-quit-window nil))

(use-package saveplace
  :ensure t
  :config
  (save-place-mode))

;; Emacs’s undo system allows you to recover any past state of a buffer.
;; It also has a tree visualization
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1))

(use-package company
  :ensure t
  :config
  (global-company-mode))

(use-package neotree
  :ensure t
  :config
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter))

(use-package web-mode
  :ensure t
  :mode
  (("\\.erb\\'" . web-mode)
   ("\\.scss\\'" . web-mode)
   ("\\.mustache\\'" . web-mode)
   ("\\.html?\\'" . web-mode)
   ("\\.ejs\\'" . web-mode)
   ("\\.js\\'" . web-mode))
  :config
  (setq
   web-mode-indent-style 2
   web-mode-markup-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-enable-current-element-highlight t))

(use-package rvm
  :ensure t
  :config
  (rvm-use-default)
  (add-hook 'ruby-mode-hook
            (lambda () (rvm-activate-corresponding-ruby))))

(use-package ruby-mode :ensure t)
(use-package ruby-end :ensure t)
(use-package robe
  :ensure t
  :config
  (setq ruby-insert-encoding-magic-comment nil)
  (add-hook 'ruby-mode-hook 'robe-mode)
  (eval-after-load 'company
    '(push 'company-robe company-backends))
  (advice-add 'inf-ruby-console-auto :before #'rvm-activate-corresponding-ruby))

(use-package haml-mode :ensure t)
(use-package slim-mode :ensure t)
(use-package sass-mode :ensure t)

(use-package rspec-mode
  :ensure t
  :config
  (setq compilation-scroll-output t
        rspec-use-rvm t))

(use-package dockerfile-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(use-package multi-term
  :ensure t
  :config
  (setq multi-term-program "/bin/bash"
	multi-term-program-switches "--login"))

(use-package markdown-mode
  :ensure t
  :mode
  (("\\.mkd\\'" . markdown-mode)
   ("\\.markdown\\'" . markdown-mode)))

(use-package yaml-mode
  :ensure t
  :mode
  (("\\.yml\\'" . yaml-mode))
  :config
  (add-hook 'yaml-mode-hook
      '(lambda ()
        (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

(use-package powerline
  :ensure t
  :config
  (setq ns-use-srgb-colorspace nil)
  (powerline-vim-theme))

(use-package git-link :ensure t)

(use-package alchemist :ensure t)

(add-to-list 'load-path "~/dotfiles/emacs/apib-mode")
(autoload 'apib-mode "apib-mode"
        "Major mode for editing API Blueprint files" t)
(add-to-list 'auto-mode-alist '("\\.apib\\'" . apib-mode))

(use-package go-mode :ensure t)
(use-package company-go
  :ensure t
  :config
  (setq company-tooltip-limit 20)                      ; bigger popup window
  (setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
  (setq company-echo-delay 0)                          ; remove annoying blinking
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
  (add-hook 'before-save-hook 'gofmt-before-save)

  (add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode))))

(use-package protobuf-mode :ensure t)

(use-package gorepl-mode :ensure t
  :config
  (add-hook 'go-mode-hook 'gorepl-mode))

(use-package graphql-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.graphqls\\'" . graphql-mode)))

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))
