;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;	File:	joq-date.el
;;;	Author:	Jack O'Quin (joq@io.com)
;;;	Date:	Fri Jan 26 18:40:24 CST 1996
;;;
;;;	Put current date and time at point
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'joq-date)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	interactive command to insert current time and date in a buffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun joq-date ()
  "Insert present date and time after point in current buffer."
  (interactive)
  (shell-command "date" '4)		; insert date output in buffer
  (exchange-point-and-mark)		; remove the newline at the end
  (delete-backward-char 1))

(defun joq-date-heading (days-ago)
  "Insert a date heading in the current buffer.  This will be today's
date unless an optional prefix argument, DAYS-AGO, specifies some number 
more than one day before the present.  For example: an argument of 2
prints yesterday's date, 3 the day before, etc."
  (interactive "p")
  (setq days-ago (1- days-ago))
  (insert-char ?\n 2)
  (shell-command
   (if (= days-ago 0)
       "date +'%A, %-d %B %Y'"		; use today's date
     (format "date --date '%d days ago' +'%%A, %%-d %%B %%Y'"
	     days-ago))
   '4)
  (exchange-point-and-mark)		; move to the end (after newline)
  (insert-char ?= (- (point) (mark) 1))
  (insert-char ?\n 2))

(defun joq-sign-and-date ()
  "Insert my name and the date at end of current buffer."
  (interactive)
  (goto-char (point-max))		; go to end of buffer
  (insert "\n\n\t\t\t\t\tJack O'Quin\n\t\t\t\t\t")
  ;; insert today's date:
  (shell-command "date +'%-d %B %Y'" '4))
