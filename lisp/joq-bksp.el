;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;	File:	joq-bksp.el
;;;	Author:	Jack O'Quin (joq@austin.ibm.com)
;;;	Date:	Sun Jan 09 15:48:09 1994
;;;
;;;	lisp function to exchange keyboard translations for C-h and DEL
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'joq-bksp)

(defun joq-bksp ()
  "Exchange keyboard translations for C-h and DEL.
Useful for terminals with backspace set to C-h"
  (interactive)

  ;; Translate `C-h' to DEL
  (keyboard-translate ?\C-h ?\C-?)
  ;; Translate DEL to `C-h'.
  (keyboard-translate ?\C-? ?\C-h))

