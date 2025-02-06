(setq org-html-link-org-files-as-html nil)

(custom-set-variables
 '(inhibit-startup-screen t)
 '(compilation-scroll-output t))


(setq backup-directory-alist
      `(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-save-list/" t)))
(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file t)

;;; Require melpa
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)


(use-package mood-line
  :config
  (mood-line-mode)
  :custom
  (mood-line-glyph-alist mood-line-glyphs-unicode))

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package golden-ratio
  :ensure t
  :config
  (golden-ratio-mode t))

(use-package f
  :ensure t)

(defadvice split-window (after split-window-after activate)
  (other-window 1))

(use-package beacon
  :ensure t
  :config
  (beacon-mode t))


(keymap-global-set "<f5>" 'compile)
(keymap-global-set "<f6>" 'eglot-format)

;;; 

(use-package multiple-cursors
  :ensure t)
(global-set-key (kbd "C-x x") 'mc/mark-next-like-this)

(use-package projectile
  :ensure t
  :config
  (setq projectile-project-search-path '("~/projects/"))
  (projectile-mode t))


(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.0
        company-minimum-prefix-length 1))


(setq plstore-cache-passphrase-for-symmetric-encryption t)

(use-package hardtime
  :init
  (unless (package-installed-p 'hardtime)
    (package-vc-install
     '(hardtime
       :vc-backend Git
       :url "https://github.com/ichernyshovvv/hardtime.el"
       :branch "master")))
  :config
  (hardtime-mode))


(use-package dashboard
  :ensure t
  :init
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-display-icons-p t) ;; display icons on both GUI and terminal
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-icon-type 'nerd-icons) ;; use `nerd-icons' package
  ;(setq dashboard-week-agenda t)
  ;(setq dashboard-agenda-sort-strategy '(time-up ts-up))
  (setq dashboard-items '((recents  . 5)
					;(bookmarks . 5)
                          (projects . 5)
			  ;(agenda . 15)
					;(registers . 5)
			  ))
  (setq dashboard-set-navigator t)
  (setq dashboard-set-footer nil)
  (setq dashboard-projects-backend 'projectile)
  :config
  (dashboard-setup-startup-hook))

(use-package reformatter
  :ensure t)

(use-package consult
  :ensure t)
(global-set-key (kbd "C-x f") 'consult-find)

(setq initial-major-mode 'org-mode) ;; set startup mode to org-mode
(add-hook 'text-mode-hook 'visual-line-mode)

(global-display-line-numbers-mode)
(global-tab-line-mode)
;(setq display-line-numbers-type 'relative)

(use-package denote
  :ensure t)

(use-package spacious-padding
  :ensure t
  :config
  (setq spacious-padding-widths
      '( :internal-border-width 15
         :header-line-width 4
         :mode-line-width 6
         :tab-width 4
         :right-divider-width 30
         :scroll-bar-width 8))
  (spacious-padding-mode t))

(set-face-attribute 'default nil :height 120)
(set-frame-font "Iosevka Nerd Font" nil t)
(use-package ef-themes
  :ensure t
  :config
  (load-theme 'ef-elea-dark))


;(set-frame-parameter (selected-frame) 'alpha '(85 50))
;(add-to-list 'default-frame-alist '(alpha 85 50))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(use-package vertico
  :ensure t
  :config
  (vertico-mode t))

(use-package vertico-posframe
  :ensure t
  :config
  (vertico-posframe-mode t))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode t))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic)))

;;; org-mode

(use-package org-appear
  :ensure t
  :hook
  (org-mode . org-appear-mode))

(use-package org-modern
  :ensure t
  :hook (org-mode . global-org-modern-mode))

(use-package org-preview-html
  :ensure t)

;(add-hook 'org-mode-hook 'org-preview-html-mode)

;;; elisp

(use-package emacs-lisp-mode
;  :ensure t
  :hook ((emacs-lisp-mode . company-mode)))

;;; Python

(cl-defun pyvenv-autoload ()
  "auto activate venv directory if exists"
  (f-traverse-upwards (lambda (path)
                        (let ((venv-path (f-expand ".venv" path)))
                          (when (f-exists? venv-path)
                            (pyvenv-activate venv-path)
                            (cl-return-from pyvenv-autoload))))))



(use-package python
  :ensure t
  :hook ((python-ts-mode . eglot-ensure)
	 (python-ts-mode . company-mode)
	 (python-ts-mode . pyvenv-autoload))
  :mode (("\\.py\\'" . python-ts-mode)))



;;; Rust

(use-package rust-ts-mode
  :ensure t
  :hook ((rust-ts-mode . eglot-ensure)
	 (rust-ts-mode . company-mode))
  :mode (("\\.rs\\'" . rust-ts-mode))
  :config
  (add-to-list 'exec-path "/home/nikos/.cargo/bin")
  (setenv "PATH" (concat (getenv "PATH") ":/home/nikos/.cargo/bin")))


;;; Godot
(use-package gdscript-mode
  :ensure t
  :hook ((gdscipt-mode . eglot-ensure)
	 (gdscript-mode . company-mode)
	 add-to-list 'company-backends 'company-godot-gdscript)
  :custom (gdscript-eglot)
  :mode (("\\.gd\\'". gdscript-mode)))


;;; C and C++
;; (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
;; (add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
;; (add-to-list 'major-mode-remap-alist
;;              '(c-or-c++-mode . c-or-c++-ts-mode))

;;(add-hook 'eglot-ensure 'c++-ts-mode)

(use-package lsp-mode
  ;:ensure t
  :hook ((c++-ts-mode . eglot-ensure)
	 ( c++-ts-mode . company-mode))
  :mode (("\\.cpp\\'". c++-ts-mode)))

;;; Go

(use-package go-ts-mode
  :ensure t
  :hook ((go-ts-mode . eglot-ensure)
	 (go-ts-mode . company-mode))
  :mode "\\.go\\'"
  )


;;; csv

(require 'color)

(defun csv-highlight (&optional separator)
  (interactive (list (when current-prefix-arg (read-char "Separator: "))))
  (font-lock-mode 1)
  (let* ((separator (or separator ?\,))
         (n (count-matches (string separator) (point-at-bol) (point-at-eol)))
         (colors (cl-loop for i from 0 to 1.0 by (/ 2.0 n)
                       collect (apply #'color-rgb-to-hex 
                                      (color-hsl-to-rgb i 0.3 0.5)))))
    (cl-loop for i from 2 to n by 2 
          for c in colors
          for r = (format "^\\([^%c\n]+%c\\)\\{%d\\}" separator separator i)
          do (font-lock-add-keywords nil `((,r (1 '(face (:foreground ,c)))))))))

(add-hook 'csv-mode-hook 'csv-highlight)
(add-hook 'csv-mode-hook 'csv-align-mode)


;;; postgresql

(unless (package-installed-p 'pg)
   (package-vc-install "https://github.com/emarsden/pg-el" nil nil 'pg))
(unless (package-installed-p 'pgmacs)
   (package-vc-install "https://github.com/emarsden/pgmacs"))

(require 'pgmacs)



;(add-hook 'sql-mode-hook 'lsp)
;(setq lsp-sqls-workspace-config-path nil)

;; ellama 

(use-package ellama
  :ensure t
  :init
  (require 'llm-ollama)
  (setopt ellama-provider
  	  (make-llm-ollama
  	   ;; this model should be pulled to use it
  	   ;; value should be the same as you print in terminal during pull
  	   :chat-model "deepseek-r1"))
  )
