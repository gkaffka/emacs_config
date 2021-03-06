(require 'package) ;; You might already have this line

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

                                        ; activate all the packages (in particular autoloads)
(package-initialize)

                                        ; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

(setq package-list '(better-defaults
                     projectile
                     ruby-electric
                     seeing-is-believing
                     rbenv))


                                        ; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Removes tollbars and scrolview
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Show line numbers
(global-linum-mode)

;; Configures rbenv
(global-rbenv-mode)
(rbenv-use-corresponding)

;; Inits the delete-selection-mode
(delete-selection-mode 1)

;; you really only need one of these
(setq visible-bell nil)

;; Initializes Seeing is believing
(setq seeing-is-believing-prefix "C-.")
(add-hook 'ruby-mode-hook 'seeing-is-believing)
(add-hook 'ruby-mode-hook 'projectile-mode)
(require 'seeing-is-believing)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm-projectile helm ruby-test-mode ac-inf-ruby projectile robe enh-ruby-mode web-mode auto-complete xkcd multiple-cursors magit elpy material-theme use-package))))
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
(setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))


;;===========================================================
;; NeoTree
;;===========================================================

(add-to-list 'load-path "/Users/gabrielcarvalho/.emacs.d/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)
(setq projectile-switch-project-action 'neotree-projectile-action)

;;===========================================================
;; Ruby Test mode
;;===========================================================

(global-set-key (kbd "C-x t") 'ruby-test-run-at-point)
(global-set-key (kbd "C-x C-SPC") 'ruby-test-run)

;;===========================================================
;; Ruby Electric 
;;===========================================================

;; Autoclose paired syntax elements like parens, quotes, etc

(add-hook 'ruby-mode-hook 'ruby-electric-mode)

;;===========================================================
;; Projectile
;;===========================================================

(global-set-key (kbd "s-f") #'projectile-find-file)


;;===========================================================
;; Ido - vertical - mode
;;===========================================================

(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
