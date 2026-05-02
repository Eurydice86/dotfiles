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

(use-package magit
  :ensure t)

(use-package mood-line
  :ensure t
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

;;; hideshow
(global-set-key (kbd "C-<tab>") 'hs-toggle-hiding)
(global-set-key (kbd "C-M-<tab>") 'hs-hide-all)
(global-set-key (kbd "C-M-<iso-lefttab>") 'hs-show-all)

;;; multiple cursors

(use-package multiple-cursors
  :ensure t)
(global-set-key (kbd "C-x x") 'mc/mark-next-like-this)


(use-package projectile
  :ensure t
  :config
  (setq projectile-project-search-path '("~/projects/"))
  (projectile-mode t))


(add-to-list 'projectile-globally-ignored-directories ".venv")

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
(global-auto-revert-mode)
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
  :hook ((emacs-lisp-mode . completion-preview-mode)))

;;; Python

(use-package pyvenv
  :ensure t)

(cl-defun pyvenv-autoload ()
  "auto activate venv directory if exists"
  (f-traverse-upwards (lambda (path)
                        (let ((venv-path (f-expand ".venv" path)))
                          (when (f-exists? venv-path)
                            (pyvenv-activate venv-path)
                            (cl-return-from pyvenv-autoload))))))

(use-package highlight-indent-guides
  :ensure t
  :hook ((python-ts-mode . highlight-indent-guides-mode))
  :config
  (setq highlight-indent-guides-method 'character))


(use-package python
  :ensure-system-package
  ()
  :ensure t
  :hook ((python-ts-mode . eglot-ensure)
	 (python-ts-mode . completion-preview-mode)
	 (python-ts-mode . pyvenv-autoload)
	 (python-ts-mode . hs-minor-mode))
  :mode (("\\.py\\'" . python-ts-mode)))

  (use-package realgud
    :ensure t)

;;; Rust

(use-package rust-ts-mode
  :ensure t
  :hook ((rust-ts-mode . eglot-ensure)
	 (rust-ts-mode . completion-preview-mode))
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
	 ( c++-ts-mode . completion-preview-mode))
  :mode (("\\.cpp\\'". c++-ts-mode)))

;;; Go

(use-package go-ts-mode
  :ensure t
  :hook ((go-ts-mode . eglot-ensure)
	 (go-ts-mode . completion-preview-mode))
  :mode "\\.go\\'"
  )


;;; csv

(use-package csv-mode
  :ensure t
  :mode "\\.csv\\'"
  :hook ((csv-mode . csv-highlight)
	 (csv-mode . csv-align-mode))
  )
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

;;; postgresql

(unless (package-installed-p 'pg)
   (package-vc-install "https://github.com/emarsden/pg-el" nil nil 'pg))
(unless (package-installed-p 'pgmacs)
   (package-vc-install "https://github.com/emarsden/pgmacs"))

(require 'pgmacs)

(use-package treesit
  :commands (treesit-install-language-grammar nf/treesit-install-all-languages)
  :init
  (setq treesit-language-source-alist
   '((bash . ("https://github.com/tree-sitter/tree-sitter-bash"))
     (c . ("https://github.com/tree-sitter/tree-sitter-c"))
     (cpp . ("https://github.com/tree-sitter/tree-sitter-cpp"))
     (css . ("https://github.com/tree-sitter/tree-sitter-css"))
     (cmake . ("https://github.com/uyha/tree-sitter-cmake"))
     (go . ("https://github.com/tree-sitter/tree-sitter-go"))
     (html . ("https://github.com/tree-sitter/tree-sitter-html"))
     (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
     (json . ("https://github.com/tree-sitter/tree-sitter-json"))
     (julia . ("https://github.com/tree-sitter/tree-sitter-julia"))
     (lua . ("https://github.com/Azganoth/tree-sitter-lua"))
     (make . ("https://github.com/alemuller/tree-sitter-make"))
     (ocaml . ("https://github.com/tree-sitter/tree-sitter-ocaml" "master" "ocaml/src"))
     (python . ("https://github.com/tree-sitter/tree-sitter-python"))
     (php . ("https://github.com/tree-sitter/tree-sitter-php"))
     (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
     (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src"))
     (ruby . ("https://github.com/tree-sitter/tree-sitter-ruby"))
     (rust . ("https://github.com/tree-sitter/tree-sitter-rust"))
     (sql . ("https://github.com/m-novikov/tree-sitter-sql"))
     (toml . ("https://github.com/tree-sitter/tree-sitter-toml"))
     (yaml . ("https://github.com/ikatyang/tree-sitter-yaml"))
     (zig . ("https://github.com/GrayJack/tree-sitter-zig"))))
  :config
  (defun nf/treesit-install-all-languages ()
    "Install all languages specified by `treesit-language-source-alist'."
    (interactive)
    (let ((languages (mapcar 'car treesit-language-source-alist)))
      (dolist (lang languages)
	      (treesit-install-language-grammar lang)
	      (message "`%s' parser was installed." lang)
	      (sit-for 0.75)))))
(setopt treesit-font-lock-level 3)



;(add-hook 'sql-mode-hook 'lsp)
;(setq lsp-sqls-workspace-config-path nil)

; markdown
(setq markdown-command "pandoc")

(setq org-latex-compiler "pdflatex")

(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
        "pdflatex -interaction nonstopmode -output-directory %o %f"))
         
;; if you use treesitter based typescript-ts-mode (emacs 29+)
(use-package tide
  :ensure t
  :after (company flycheck)
  :hook ((typescript-ts-mode . tide-setup)
         (tsx-ts-mode . tide-setup)
         (typescript-ts-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save))
  :mode (("\\.tsx\\'" . typescript-ts-mode)))


(use-package org-novelist
  :vc (:url "https://github.com/sympodius/org-novelist.git"
       :rev :newest)  ; Use the latest commit, rather than the latest release. For latest release, remove ":rev :newest"
  :custom
    (org-novelist-author "John Urquhart Ferguson")  ; The default author name to use when exporting a story. Each story can also override this setting
    (org-novelist-author-email "mail@johnurquhartferguson.info")  ; The default author contact email to use when exporting a story. Each story can also override this setting
    (org-novelist-automatic-referencing-p nil)  ; Set this variable to 't' if you want Org Novelist to always keep note links up to date. This may slow down some systems when operating on complex stories. It defaults to 'nil' when not set
  :bind (("C-c n n s" . org-novelist-new-story)
          :map org-novelist-mode-map
          ("C-c n n c" . org-novelist-new-chapter)
          ("C-c n d c" . org-novelist-destroy-chapter)
          ("C-c n r c" . org-novelist-rename-chapter)
          ("C-c n n a" . org-novelist-new-character)
          ("C-c n d a" . org-novelist-destroy-character)
          ("C-c n r a" . org-novelist-rename-character)
          ("C-c n n p" . org-novelist-new-prop)
          ("C-c n d p" . org-novelist-destroy-prop)
          ("C-c n r p" . org-novelist-rename-prop)
          ("C-c n n l" . org-novelist-new-place)
          ("C-c n d l" . org-novelist-destroy-place)
          ("C-c n r l" . org-novelist-rename-place)
          ("C-c n u"   . org-novelist-update-references)
          ("C-c n r s" . org-novelist-rename-story)
          ("C-c n e"   . org-novelist-export-story)
          ("C-c n l l" . org-novelist-link-to-story)
          ("C-c n l u" . org-novelist-unlink-from-story)
          ("C-c n t"   . org-novelist-toggle-automatic-referencing)))
