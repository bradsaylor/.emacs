;; **************************
;; ******** PACKAGES ********
;; **************************

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;;	     '("melpa" . "http://melpa.milkbox.net/packages/") t))

(setq TeX-PDF-mode t)
(setq cursor-type 'box)



;; ************************
;; ******** EDITOR ********
;; ************************

;; blue color scheme
;; (add-to-list 'default-frame-alist '(foreground-color . "#E0DFDB"))
;; (add-to-list 'default-frame-alist '(background-color . "#102372"))

;; load solarized dark color scheme
(load-theme 'solarized-dark t)

;; pink cursor
(set-cursor-color "#FF33B4")

;; blink cursor forever
;; (blink-cursor-blinks 0)

;; <f1> -> man lookup on current word
(global-set-key  [(f1)]  (lambda () (interactive) (manual-entry (current-word))))

;; auto close bracket insertion
(electric-pair-mode 1)

;; show matching parentheses
(setq show-paren-delay 0)
(show-paren-mode 1)

;;
;;(global-set-key ("kbd M-p") 'paragraph-backward)
;;(global-set-key ("kbd M-n") 'paragraph-forward)

;; OSX bindings: function key -> CTRL, command key -> META, 
(setq ns-function-modifier 'control)
(setq mac-command-modifier 'meta)

;; no emacs welcome screen on startup
(setq inhibit-startup-screen t)

;; scroll one line at a time (less "jumpy" than defaults)    
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; default to truncated lines
(set-default 'truncate-lines t)

;; autocomplete cofiguration
(ac-config-default)

;; change backup file locaion to ~/.saves 
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; show column and row numbers by default
(setq column-number-mode t)



;; **************************
;; ******** ORG-MODE ********
;; **************************

;; auto initialize org-mode for .org files
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; org-mode key bindings: CNTRL-C l -> store link, CNTRL-C a -> agendaq
(global-set-key "\C-c l" 'org-store-link)
(global-set-key "\C-c a" 'org-agenda)

;; fontify code in code blocks
(setq org-src-fontify-natively t)




;; *****************************
;; ******** PROGRAMMING ********
;; *****************************

; from enberg on #emacs
(setq compilation-finish-function
  (lambda (buf str)
    (if (null (string-match ".*exited abnormally.*" str))
        ;;no errors, make the compilation window go away in a few seconds
        (progn
          (run-at-time
           ".1 sec" nil 'delete-windows-on
           (get-buffer-create "*compilation*"))
          (message "No Compilation Errors!")))))
(defun my-c-mode-hook ()
  ;; show line numbers for c files
  (linum-mode t)
  (flycheck-mode)
  (hs-minor-mode))
(add-hook 'c-mode-hook 'my-c-mode-hook)
1
(setq c-default-style "linux"
      c-basic-offset 5)

;; preferred programming window layout
(defun programming-layout ()
  (interactive)
  (split-window-right)
  (other-window 1)
  (split-window-below)
  (previous-buffer)
  (other-window 1)
  (execute-extended-command nil "term")
  (enlarge-window -10)
  (term-line-mode)
  (other-window 1))
(global-set-key (kbd "C-c p") 'programming-layout)

(global-set-key (kbd "C-;") 'compile)

;; auto-complete
(ac-config-default)
(add-to-list 'ac-modes 'c-mode)

;; irony-mode
(add-hook 'c-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)




;; **********************************
;; ******** CUSTOM VARIABLES ********
;; **********************************

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(package-selected-packages
   (quote
    (company-irony-c-headers flycheck-irony cdlatex latex-extra org-edit-latex auctex flycheck solarized-theme auto-complete irony company-irony magit)))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; ************************
;; ******** ACUTEX ********
;; ************************

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'latex-extra-mode)


(eval-after-load 'latex-extra 
  '(define-key latex-extra-mode-map (kbd "TAB") #'latex/hide-show))
