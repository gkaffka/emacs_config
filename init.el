(require 'package) ;; You might already have this line

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-initialize) ;; You might already have this line

;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/.emacs.d/lisp/")

;;Removes tollbars and scrolview
(tool-bar-mode -1)
(scroll-bar-mode -1)

(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))
(require 'use-package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ac-inf-ruby projectile robe enh-ruby-mode web-mode auto-complete xkcd multiple-cursors magit elpy material-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package material-theme :ensure t :init (load-theme 'material :no-confirm))

;; y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;;============================================================
;; Elpy
;;============================================================

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;;===========================================================
;; Magit
;;============================================================

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))


;;===========================================================
;; Pretty bullets
;;============================================================

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;;============================================================
;; Multiple Cursors
;;============================================================

(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-w" . mc/mark-all-like-this))
  )

;;===========================================================
;; El-get
;;===========================================================

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)


;;===========================================================
;; Adds more sites to webjump 
;;===========================================================

(require 'webjump)
   (global-set-key "\C-cj" 'webjump)
   (setq webjump-sites
         (append '(
    ("StackOverflow" .
     [simple-query "http://stackoverflow.com"
		   "http://stackoverflow.com/search?q=" ""])

		   )
                 webjump-sample-sites))

;;===========================================================
;; Auto-complete for Ruby
;;===========================================================

(eval-after-load 'auto-complete
  '(add-to-list 'ac-modes 'inf-ruby-mode))
(add-hook 'inf-ruby-mode-hook 'ac-inf-ruby-enable)


;;===========================================================
;; Puts the Backup Files in a different directory
;;===========================================================

(setq backup-directory-alist `(("." . "~/.saves")))

;;===========================================================
;; Robe Mode
;;===========================================================

(add-hook 'ruby-mode-hook 'robe-mode)

;;===========================================================
;; NeoTree
;;===========================================================

(add-to-list 'load-path "/Users/gabrielcarvalho/.emacs.d/neotree")
  (require 'neotree)
  (global-set-key [f8] 'neotree-toggle)
  (setq neo-smart-open t)
  (setq projectile-switch-project-action 'neotree-projectile-action)
