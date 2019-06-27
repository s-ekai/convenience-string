;; ------HOW TO USE-------
;; (setf hoge 'apple)
;; #S"this is an {{hoge}}"
;; => "this is an apple"
;;
;; Unfortunately, convenience-string can't access the value of a lexical variable,
;; so you have to declare a special variable if you want to use.
;; (let ((hoge 'apple))
;;        (declare (special hoge))
;;        #S"this is an {{hoge}}")

(defpackage convenience-string
  (:use :cl
        :cl-ppcre)
  (:export :enable))
(in-package :convenience-string)

(defmacro enable ()
  '(eval-when (:compile-toplevel :load-toplevel :execute)
    (%enable-convenience-string)))

(defun %enable-convenience-string ()
  (setf *readtable* (copy-readtable))
  (set-dispatch-macro-character #\# #\S #'convenience-string))

(defun convenience-string (stream char2 n)
  (declare (ignorable char2 n))
  (let ((expression (read stream t nil t))
        (string (gensym))
	(variables (gensym))
	(replaced-string (gensym)))
    `(let* ((,string ,expression)
            (,variables (variable-symbol-list ,string))
            (,replaced-string (replace-bracket-variable ,string)))
       (apply #'format nil ,replaced-string ,variables)
      )))

(defun replace-bracket-variable (string)
  (ppcre:regex-replace-all "{{([^}]+)}}" string "~a")
)

(defun variable-symbol-list (string)
   (let ((variables (variable-string-list string)))
     (mapcar #'symbol-value (mapcar #'convert-string-to-symbol variables))
   )
)

(defun convert-string-to-symbol (string)
  (read-from-string string)
)

(defun bracket-variable-list (string)
  (ppcre:all-matches-as-strings "{{[^}]+}}" string)
)

(defun variable-string-list (string)
  (let ((matched-variables (bracket-variable-list string)))
    (mapcar (lambda (s) (ppcre:regex-replace-all "[{|}]" s "")) matched-variables)
  )
)
