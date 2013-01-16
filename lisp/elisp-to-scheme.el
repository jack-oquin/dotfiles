
;;; elisp functions for converting elisp source to R4RS scheme
;;;
;;;	joq@austin.ibm.com -- Sun Dec 18 19:19:58 CST 1994

(provide 'elisp-to-scheme)

(defun elisp-to-scheme ()
  "*Convert the following elisp token to its scheme equivalent (if any)."
  (interactive)
  (let (token)
    (forward-sexp 1)
    (forward-sexp -1)
    (mark-sexp 1)
    (setq token (buffer-substring (point) (mark)))
    (cond
     ((string= token "nil")	(kill-region (point) (mark)) (insert "#f"))
     ((string= token "t")	(kill-region (point) (mark)) (insert "#t"))
     ((string= token "setq")	(kill-region (point) (mark)) (insert "set!"))
     ((string= token "null")	(kill-region (point) (mark)) (insert "null?"))
     ((string= token "progn")	(kill-region (point) (mark)) (insert "begin"))
     ((string= token "nconc")	(kill-region (point) (mark)) (insert "append!"))
     ((string= token "nreverse")(kill-region (point) (mark)) (insert "reverse!"))
     ((string= token "aref")	(kill-region (point) (mark)) (insert "vector-ref"))
     ((string= token "aset")	(kill-region (point) (mark)) (insert "vector-set!"))
     ((string= token "setcar")	(kill-region (point) (mark)) (insert "setcar!"))
     ((string= token "setcdr")	(kill-region (point) (mark)) (insert "setcdr!"))
     ((string= token "eq")	(kill-region (point) (mark)) (insert "eq?"))
     ((string= token "zerop")	(kill-region (point) (mark)) (insert "zero?"))
     ((string= token "/")	(kill-region (point) (mark)) (insert "quotient"))
     ((string= token "%")	(kill-region (point) (mark)) (insert "remainder"))
     ((string= token "interactive") (kill-sexp 1))
     ((string= token "nth")
      (kill-region (point) (mark)) (insert "list-ref")
      (forward-sexp 1) (transpose-sexps 1))

     ;; otherwise, skip this expression and raise an error
     (t (forward-sexp 1)
	(error "Conversion for this e-lisp expression unavailable.")))))

(defun search-for-non-scheme ()
  "*Search for the next non-scheme-looking token."
  (interactive)
  (if (search-forward-regexp
       "[( ]\\(nil\\|t\\|setq\\|setcar\\|aref\\|aset\\|setcdr\\|eq\\|null\\|nconc\\|nreverse\\|interactive\\|zerop\\|%\\|/\\|progn\\|nth\\|log..*\\|?..*\\)[ )]"
       nil t)
      (forward-sexp -1)
    (error "No more non-scheme tokens left.")))
