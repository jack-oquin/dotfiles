;;;
;;; $Id: guile-interface.el,v 1.1 1997/07/16 01:01:26 rmcmanus Exp $
;;;

(defun guile-send-header-forms (&optional depth)
  "go to the top of the buffer and examine top level 
forms.  send header ms to the inferior scheme process.
header forms are forms involving the guile module system
and forms to load code from slib.  quit searching when
a non-header form is encountered."
  (save-excursion
    (goto-char (point-min))
    (forward-list 1)
    (forward-list -1)
    (while (or (looking-at "(define-module")
	       (looking-at "(set-current-module")
	       (looking-at "(use-modules")
	       (looking-at "(require"))
      (let ((start (point)))
	(lisp-eval-defun)
	(goto-char start)
	(forward-list 2)
	(forward-list -1)))))

(defun guile-send-definition ()
  "Sends header forms, then the currrent definition,
to the inferior scheme process,"
  (interactive)
  (guile-send-header-forms)
  (lisp-eval-defun))

(defun guile-run-lisp ()
  "wrapper around run-lisp from inf-lisp.el, that does some
snazzy buffer switching."
  (interactive "")
  (if (not (eq (process-status "inferior-lisp") 'run))
      (let ((start-buf (current-buffer)))
	(run-lisp inferior-lisp-program)
	(switch-to-buffer start-buf))
    (let ((start-buf (current-buffer))
	  (lisp-buf (get-buffer "*inferior-lisp*")))
      (switch-to-buffer-other-window lisp-buf)
      (goto-char (point-max))
      (switch-to-buffer-other-window start-buf))))

(defun guile-procedure-documentation ()
  "get the inferior lisp process to print the doc string
of the procedure whose name is under point.  this involves
first setting the current module."
  (interactive)
  (guile-run-lisp)
  (guile-send-header-forms)
  (save-excursion
    (let ((process (get-process "inferior-lisp")))
      (backward-sexp)
      (set-mark (point))
      (forward-sexp 1)
      (let ((str (buffer-substring (point) (mark))))
	(comint-send-string 
	 process 
	 (concat
	  "(begin "
	  "  (newline)"
	  "  (display " str ")"
	  "  (newline)"
	  "  (procedure-documentation " str "))\n"))))))

;;;
;;; scheme mode customization
;;;
(setq inferior-lisp-program "/usr/local/bin/guile")
;(setq inferior-lisp-program "/usr/local/bin/guile-tcltk")
;(setq inferior-lisp-program "/home/rmcmanus/work/xl/xl")

(defvar menu-bar-my-scheme-menu (make-sparse-keymap "Scheme"))

(defun guile-install-letter-bindings ()
  (mapcar
   (lambda (pair)
     (define-key scheme-mode-map (read-kbd-macro (car pair)) (cdr pair)))
   '(("C-c x" . guile-run-lisp)
     ("C-c e" . guile-send-definition)
     ("C-c r" . lisp-eval-region-and-go)
     ("C-c z" . switch-to-lisp)
     ("C-c l" . lisp-load-file)
     ("C-c d" . guile-procedure-documentation))))

(defun guile-install-menu-bindings ()
  (define-key menu-bar-my-scheme-menu [my-scheme-eval-defun]
    '("Eval Defun" . lisp-eval-defun))
  (define-key menu-bar-my-scheme-menu [my-scheme-eval-region]
    '("Eval Region" . lisp-eval-region-and-go))
  (define-key menu-bar-my-scheme-menu [my-scheme-switch-to-lisp]
    '("Switch to Scheme" . switch-to-lisp))
  (define-key menu-bar-my-scheme-menu [my-scheme-load-file]
    '("Load File" . lisp-load-file)))

(provide 'guile-interface)