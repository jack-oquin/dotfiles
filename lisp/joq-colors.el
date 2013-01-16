;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;	File:	joq-colors.el
;;;	Author:	Jack O'Quin (joq@joq.us)
;;;
;;;	Set default face colors.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'joq-colors)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	interactive command to set default background color.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun joq-set-background-color (bg)
  "Set background color name to BG.  Null selects the X resources default."
  (interactive "_sNew background color: ")

  (let ((def (color-name (face-background 'default)))
	(faces (face-list)))
    (while faces
      (let ((obg (face-background (car faces))))
	(if (and obg (equal def (color-name obg)))
	    (set-face-background (car faces) bg)))
      (setq faces (cdr faces)))))
