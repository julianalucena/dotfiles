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
  :init (auto-compile-on-load-mode t))
(setq load-prefer-newer t)

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)))

(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq ns-use-native-fullscreen nil)
(toggle-frame-fullscreen)

(setq-default indent-tabs-mode nil
      show-trailing-whitespace t
      inhibit-startup-message t
      initial-scratch-message nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-tomorrow-night)
  (set-face-attribute 'default nil :font "Source Code Pro-13"))

(global-linum-mode t)

(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)

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

(use-package zoom-window
  :ensure t
  :config
  (setq zoom-window-mode-line-color "DarkGreen")
  (evil-leader/set-key
    "z" 'zoom-window-zoom))

(use-package magit
  :ensure t
  :config
  (setq evil-leader/no-prefix-mode-rx '("magit-.*-mode"))
  (evil-leader/set-key
    "gs" 'magit-status
    "gl" 'magit-log-all))

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

(use-package web-mode
  :ensure t
  :mode
  (("\\.erb\\'" . web-mode)
   ("\\.scss\\'" . web-mode)
   ("\\.mustache\\'" . web-mode)
   ("\\.html?\\'" . web-mode)
   ("\\.ejs\\'" . web-mode))
  :config
  (setq
   web-mode-indent-style 2
   web-mode-markup-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-enable-current-element-highlight t))

(use-package coffee-mode
  :ensure t
  :config
  (custom-set-variables '(coffee-indent-like-python-mode t)))

(use-package handlebars-mode :ensure t)

(use-package rvm
  :ensure t
  :config
  (rvm-use-default))

(use-package ruby-end :ensure t)
(use-package inf-ruby
  :ensure t
  :config
  (add-hook 'after-init-hook 'inf-ruby-switch-setup))

(use-package enh-ruby-mode
  :ensure t
  :mode
  (("Capfile" . enh-ruby-mode)
   ("Gemfile" . enh-ruby-mode)
   ("Rakefile" . enh-ruby-mode)
   ("\\.rb" . enh-ruby-mode)
   ("\\.ru" . enh-ruby-mode))
  :interpreter "ruby"
  :config
  (setq enh-ruby-deep-indent-paren nil
        enh-ruby-check-syntax nil
        enh-ruby-add-encoding-comment-on-save nil)
  (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode))

(use-package haml-mode :ensure t)
(use-package slim-mode :ensure t)
(use-package sass-mode :ensure t)

(use-package rspec-mode
  :ensure t
  :config
  (setq compilation-scroll-output t
        rspec-use-rvm t))

(use-package company
  :ensure t
  :config
  (global-company-mode))

(use-package dockerfile-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(use-package multi-term
  :ensure t
  :config
  (setq multi-term-program "/bin/bash"
	multi-term-program-switches "--login"))

(use-package restclient :ensure t)

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

(use-package org
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
  (setq org-agenda-files (list "~/org"
                               "~/journal")
        org-agenda-file-regexp "\\`[^.].*\\.org\\'\\|[0-9]+")

  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (sh . t)
     (ruby . t)
     ))
  (tags "REFILE" ((org-agenda-overriding-header "REFILE"))))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-journal
  :ensure t
  :config
  (setq org-journal-dir "~/journal/"))


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
