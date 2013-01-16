;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;	Some string matching functions.
;;;
;;;	Wed Jan 20 22:40:00 CST 1999
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'joq-match)

(defun joq-match-alternates (first &rest rest)
  "Generate a regexp that matches one or more alternative strings."
  (if rest
      (concat first "\\|" (apply 'joq-match-alternates rest))
    first))

(defun joq-match-list (list)
  "Generate a regexp that matches an alternative string in LIST."
  (concat "\\(" (apply 'joq-match-alternates list) "\\)"))

