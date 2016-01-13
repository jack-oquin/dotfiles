;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	.xemacs/init.el for joq@sulphur.joq.us
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	emacs version-specific initialization
;;;
;;;	This .emacs file is intended to handle both GNU emacs and
;;;	Lucid Xemacs, with major version numbers of 19, 20 or 21.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Add personal stuff to the standard load path.  It seems safer to
;; append these things to the end, but I want to override the standard
;; xemacs21 distribution's version of comint.el with a different
;; version.  **no longer doing that**
(setq load-path
      (cons (expand-file-name "~/lisp/") load-path))

;;; Function keys common to both emacs versions:
(global-set-key [f1]
		'(lambda () (interactive) (switch-to-buffer "*shell*")))
;;(global-set-key [f2]
;;		'(lambda () (interactive) (switch-to-buffer "*shell*<2>")))
;;(global-set-key [f3]
;;		'(lambda () (interactive) (switch-to-buffer "*shell*<3>")))
(global-set-key [f7] 'toggle-truncate-lines)
(global-set-key [f8] 'shell)

(setenv "PAGER" "/bin/cat")
(setenv "EDITOR" "/usr/bin/emacsclient")
;; start emacsclient server
(server-start)

;; some general settings:
(setq default-major-mode		'indented-text-mode
      dired-compression-method		'gzip
      find-file-visit-truename		t
      backup-by-copying-when-mismatch	t
      backup-by-copying-when-linked	t
      require-final-newline		t
      scroll-step			2)
(setq garbage-collection-messages	t
      gc-cons-threshold			4000000)
(setq efs-generate-anonymous-password	"jack.oquin@gmail.com")
(setq tex-dvi-print-command		"dvips"
      tex-dvi-view-command		"xdvi")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	X window system initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (eq window-system 'x)
    (progn
      ;;(global-set-key "\C-x\C-c" nil)	; avoid annoying typos
      ;;(global-set-key "\C-z" nil)	; (best to disable C-z with X)
      ;;(global-set-key "\C-x\C-z" nil)	; (disable C-x C-z, too)
      ;;(setq x-symbol-default-coding 'iso-8859-1)

      ;; use X clipboard for cut, copy and paste
      (global-set-key "\C-w" 'clipboard-kill-region)
      (global-set-key "\M-w" 'clipboard-kill-ring-save)
      (global-set-key "\C-y" 'clipboard-yank)

      (if (eq 0 (user-uid))	; running as "root"?
          (progn (set-background-color "wheat")
                 (set-foreground-color "navyblue")))
      (transient-mark-mode t)

      (scroll-bar-mode 1)
      (setq scroll-preserve-screen-position t)
      ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	ILISP initialization for CMU Common Lisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(autoload 'run-ilisp "ilisp" "Select a new inferior LISP." t)
;;(autoload 'clisp     "ilisp" "Inferior generic Common LISP." t)
;;(autoload 'cmulisp   "ilisp" "Inferior CMU Common LISP." t)
;;(autoload 'clisp-hs  "ilisp" "Inferior Haible/Stoll CLISP Common LISP." t)
;;(autoload 'gcl "ilisp" "Inferior GNU Common LISP." t)
;;
;;(setq cmulisp-program "/usr/bin/lisp")
;;(setq cmulisp-local-source-directory "/usr/src/cmucl/src/")
;;(setq cmulisp-source-directory-regexp "\\/usr\\/src\\/cmu\\/")
;;(setq gcl-program "gcl")
;;
;;;;; This makes reading a lisp file load in ilisp.
;;(set-default 'auto-mode-alist
;;	     (append '(("\\.lisp$" . lisp-mode)) auto-mode-alist))
;;(setq lisp-mode-hook '(lambda ()
;;			(if (eq window-system 'x)
;;			    (setq lisp-font-lock-keywords
;;				  lisp-font-lock-keywords-2))
;;			(require 'ilisp)))
;;
;;;;; Sample load hook
;;(add-hook 'ilisp-load-hook 
;;	  (function
;;	   (lambda ()
;;	     ;; Change default key prefix to C-c
;;	     (setq ilisp-prefix "\C-c")
;;
;;	     ;; Make sure that you don't keep popping up the 'inferior
;;	     ;; lisp' buffer window when this is already visible in
;;	     ;; another frame. Actually this variable has more impact
;;	     ;; than that. Watch out.
;;	     ;;(setq pop-up-frames t)
;;
;;	     (message "Running ilisp-load-hook")
;;	     ;; Define LispMachine-like key bindings, too.
;;	     ;; (ilisp-lispm-bindings) Sample initialization hook.
;;
;;	     ;; Set the inferior LISP directory to the directory of
;;	     ;; the buffer that spawned it on the first prompt.
;;	     (add-hook 'ilisp-init-hook
;;		       (function
;;			(lambda ()
;;			  (default-directory-lisp ilisp-last-buffer))))
;;	     )))
;;
;;(add-hook 'ilisp-site-hook
;;	  (function
;;	   (lambda ()
;;	     (setq ilisp-init-binary-extension "x86f")
;;	     (setq ilisp-init-binary-command "(progn \"x86f\")"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	ediff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'ediff-buffers "ediff" "Visual interface to diff" t)
(autoload 'ediff  "ediff"  "Visual interface to diff" t)
(autoload 'ediff-files "ediff" "Visual interface to diff" t)
(autoload 'epatch  "ediff"  "Visual interface to patch" t)
(autoload 'ediff-patch-file "ediff" "Visual interface to patch" t)
(autoload 'ediff-patch-buffer "ediff" "Visual interface to patch" t)
(autoload 'epatch-buffer "ediff" "Visual interface to patch" t)
(autoload 'vc-ediff "ediff"
  "Interface to diff & version control via vc.el" t) 
(autoload 'rcs-ediff "ediff"
  "Interface to diff & version control via rcs.el" t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	handle specific file types
;;;	(these go last so other stuff can't easily override them)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'text-mode-hook '(lambda () (auto-fill-mode 1)))
(add-hook 'python-mode-hook
          '(lambda ()
             (highlight-lines-matching-regexp ".\\{80\\}" 'hi-yellow)
             (setq comment-column 40)
             (setq show-trailing-whitespace t)
             (column-number-mode t)
             (flyspell-prog-mode)))
(add-hook 'c-mode-hook
	  '(lambda ()
	     (setq c-tab-always-indent	t
		   parens-require-spaces nil
		   comment-column 40)
             (column-number-mode t)
             (flyspell-prog-mode)
             (highlight-lines-matching-regexp ".\\{80\\}" 'hi-yellow)
	     (c-set-style "gnu")))	; for JAMin use "stroustrup"
(setq c++-mode-hook c-mode-hook)	; use same options for C++
;;(setq browse-url-new-window-p t)	; always use a new window for URLs
;;(setq find-file-hooks			; display full file name on modeline
;;      (cons '(lambda ()
;;	       (setq modeline-buffer-identification (list "%f")))
;;	    find-file-hooks))
;;(setq auto-mode-alist (cons '("\\.pl$" . perl-mode) auto-mode-alist))
(setq shell-multiple-shells t)		; allow multiple shell windows

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	subversion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'psvn "svn-status" "Subversion command interface" t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	autoloads, global key definitions, disabled functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'joq-date "joq-date"
  "Insert present date and time after point in current buffer." t)
(autoload 'joq-date-heading "joq-date"
  "Insert present date as a heading after point in current buffer." t)
(autoload 'joq-sign-and-date "joq-date"
  "Insert my name and the date at end of current buffer." t)
(autoload 'joq-bksp "joq-bksp"
  "Exchange keyboard translations for C-h and DEL.
Useful for terminals with backspace set to C-h" t)

(define-key global-map "\C-c\C-e" 'ediff-buffers)
(define-key global-map "\C-c\C-p" 'bbdb-complete-name)
(define-key global-map "\M-\C-c" 'compile)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Robot Operating System tools -- requires environment 
(if (getenv "ROS_ROOT")
  (progn
    (if (version< emacs-version "24.3")
        ;; for emacs 23
        (if (require 'rosemacs "rosemacs" t)
            (invoke-rosemacs))
      (progn
        ;; else emacs 24.3 or newer
	(setq site-lisp-path (concat "/opt/ros/"
				     (getenv "ROS_DISTRO")
				     "/share/emacs/site-lisp"))
	(if (file-readable-p site-lisp-path)
	    ;; rosemacs is installed
	    (progn
	      (add-to-list 'load-path site-lisp-path)
	      (require 'rosemacs-config))
	  (message "rosemacs is not installed"))))

    (global-set-key "\C-x\C-r" ros-keymap)
    (add-to-list 'auto-mode-alist '("\\.bmr$" . python-mode))
    (add-to-list 'auto-mode-alist '("\\.test$" . xml-mode))
    (add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))
    (if (require 'slime "slime" t)
        (slime-setup '(slime-fancy slime-asdf slime-ros)))
    ))

(setq inhibit-startup-message t)
(message "Emacs personalization completed ")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  End of personal settings --
;;;	Stuff from here on was written by various versions of emacs...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; the 'disabled function put these here
(put 'eval-expression 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(dired-recursive-deletes (quote top))
 '(indent-tabs-mode nil)
 '(parens-require-spaces nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "grey80" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
