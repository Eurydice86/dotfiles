(setq org-html-link-org-files-as-html nil)

(custom-set-variables
 '(inhibit-startup-screen t))

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
  (beacon-mode 1))

;;; 

(use-package projectile
  :ensure t
  :config
  (setq projectile-project-search-path '("~/projects/"))
  (projectile-mode 1))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.0
        company-minimum-prefix-length 1))

(use-package dashboard
  :ensure t
  :init
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-display-icons-p t) ;; display icons on both GUI and terminal
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-icon-type 'all-the-icons) ;; use `nerd-icons' package
  (setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))
  (setq dashboard-set-navigator t)
  (setq dashboard-set-footer nil)
  :config
  (dashboard-setup-startup-hook))

(use-package affe
  :ensure t)
(global-set-key (kbd "C-x f") 'affe-find)

(setq initial-major-mode 'org-mode) ;; set startup mode to org-mode
(add-hook 'text-mode-hook 'visual-line-mode)

(global-display-line-numbers-mode)
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
  (spacious-padding-mode 1))

(set-face-attribute 'default nil :height 120)
(set-frame-font "Iosevka Nerd Font" nil t)
(use-package ef-themes
  :ensure t)
(load-theme 'ef-maris-dark)

;(set-frame-parameter (selected-frame) 'alpha '(85 50))
;(add-to-list 'default-frame-alist '(alpha 85 50))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(use-package vertico
  :ensure t
  :config
  (vertico-mode 1))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

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

;;; elisp

(use-package emacs-lisp-mode
;  :ensure t
  :hook ((emacs-lisp-mode . company-mode)))

;;; Python

(use-package python
  :ensure t
  :hook ((python-ts-mode . eglot-ensure)
	 (python-ts-mode . company-mode))
  :bind (:map python-ts-mode-map
	      ("<f5>" . compile)
	      ("<f6>" . eglot-format))
  :mode (("\\.py\\'" . python-ts-mode)))

(cl-defun pyvenv-autoload ()
  "auto activate venv directory if exists"
  (f-traverse-upwards (lambda (path)
                        (let ((venv-path (f-expand ".venv" path)))
                          (when (f-exists? venv-path)
                            (pyvenv-activate venv-path)
                            (cl-return-from pyvenv-autoload))))))

(add-hook 'python-ts-mode-hook 'pyvenv-autoload)


;;; Rust

(use-package rust-ts-mode
  :ensure t
  :hook ((rust-ts-mode . eglot-ensure)
	 (rust-ts-mode . company-mode))
  :bind (:map rust-ts-mode-map
	      ("<f5>" . compile)
	      ("<f6>" . eglot-format))
  :mode (("\\.rs\\'" . rust-ts-mode))
  :config
  (add-to-list 'exec-path "/home/nikos/.cargo/bin")
  (setenv "PATH" (concat (getenv "PATH") ":/home/nikos/.cargo/bin")))

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


;(add-hook 'sql-mode-hook 'lsp)
;(setq lsp-sqls-workspace-config-path nil)
