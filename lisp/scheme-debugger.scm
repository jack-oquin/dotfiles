;;; installed-scm-file

;;;; 	Copyright (C) 1996 Tom Lord
;;;; 
;;;; This program is free software; you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; either version 2, or (at your option)
;;;; any later version.
;;;; 
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;; 
;;;; You should have received a copy of the GNU General Public License
;;;; along with this software; see the file COPYING.  If not, write to
;;;; the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
;;;; 



(define-module #/dbg
  :use-module #/ice-9/slib)
(require 'pretty-print)


;; Most familiar entry points:
;;

(define (debug-on-entry! proc)
  (cancel-debug-on-entry! proc)
  (let ((code (closure-code proc)))
    (set-cdr! code `((,!!!breakpoint (begin ,@ (cdr code)))))))

(define (cancel-debug-on-entry! proc)
  (let ((code (closure-code proc)))
    (and (list? (cdr code))
	 (= 1 (length (cdr code)))
	 (list? (cadr code))
	 (= 2 (length (cadr code)))
	 (eq? !!!breakpoint (caadr code))
	 (list? (cadr (cadr code)))
	 (< 1 (length (cadr (cadr code))))
	 (set-cdr! code (cdadr (cadr code))))))


(define-public (debug-print . args) (apply print args))
(define-public (debug-abort) (throw 'abort))
(define-public (debug-return value) (throw 'debug-return value))
(define-public (debug-continue) (throw 'debug-continue (cadr (debug-exp)) (debug-env)))
(define-public (debug-finish)
  (let ((exp-val (!!!eval (cadr (debug-exp)) (debug-env))))
    (display "debug-expression => ")
    (pretty-print exp-val)
    (set! dbg-expression `(,!!!breakpoint (begin (quote ,exp-val))))))
(define-public (debug-local-eval exp) (!!!eval (copy-tree exp) (debug-env)))
(define-public (debug-descend)
  (if (not (list? (cadr (debug-exp))))
      (debug-finish)
      (!!!eval (cons (caadr (debug-exp))
		     (map (lambda (x) `(,!!!breakpoint ,x)) (cdadr (debug-exp))))
	       (debug-env))))

(define-public dbg-input-port (current-input-port))
(define-public dbg-output-port (current-output-port))
(define-public dbg-error-port (current-error-port))

(define-public dbg-saved-input-port (current-input-port))
(define-public dbg-saved-output-port (current-output-port))
(define-public dbg-saved-error-port (current-error-port))

(define-public (with-dbg-ports thunk)
  (set! dbg-saved-input-port (current-input-port)
	dbg-saved-output-port (current-output-port)
	dbg-saved-error-port (current-error-port))
  (with-input-from-port dbg-input-port
    (lambda ()
      (with-output-to-port dbg-output-port
	(lambda ()
	  (with-error-to-port dbg-error-port
	    thunk))))))

(define dbg-expression #f)
(define dbg-environment #f)
(define dbg-depth 0)

(define-public (debug-exp) dbg-expression)
(define-public (debug-env) dbg-environment)

(define-public (debug expression . opts)
  (let ((environment (and opts (car opts))))
    (catch 'debug-continue
	   (lambda () 
	     (let ((saved-exp #f)
		   (saved-env #f))
	       (dynamic-wind
		(lambda () (set! saved-exp dbg-expression
				 dbg-expression expression
				 saved-env dbg-environment
				 dbg-environment environment
				 dbg-depth (+ 1 dbg-depth)))
		debug-repl
		(lambda () (set! expression dbg-expression
				 dbg-expression saved-exp
				 environment dbg-environment
				 dbg-environment saved-env
				 dbg-depth (+ -1 dbg-depth))))))
	   (lambda (tag exp env)
	     (!!!eval exp env)))))

(define !!!breakpoint (procedure->syntax debug))

(define-public (debug-repl)
  (catch '%%system-error
	 (lambda ()
	   (catch 'debug-return
		  (lambda ()
		    (repl debug-read debug-eval debug-print))
		  (lambda thrown
		    (and thrown (cdr thrown) (cadr thrown)))))
	 (lambda ign (debug-repl))))

(define-public (debug-read . args) (apply read args))
(define-public (debug-eval . args) (apply eval args))
(define-public debug-prompt " debug> ")

(define-public (debug-read . opts)
  (let ((port (or (and opts (car opts)) (current-input-port))))
    (if scm-repl-prompt
	(begin
	  (pk 'debug-expression)
	  (pretty-print (cadr (debug-exp)))
	  (display (list dbg-depth))
	  (display debug-prompt)
	  (force-output)
	  (repl-report-reset)))
    (let ((val (read port #t read-sharp)))
      (if (eof-object? val)
	  (begin
	    (if scm-repl-verbose
		(begin
		  (newline)
		  (display ";;; EOF -- quitting")
		  (newline)))
	    (quit 0)))
      val)))

(define (fact x) (if (= 0 x) 1 (* x (fact (- x 1)))))


