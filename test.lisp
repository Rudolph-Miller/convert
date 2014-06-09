;;;key -> converted key
;;;(list ( . )..)
(defvar *conv-list*
	'((#\１ . #\1) 
		(#\２ . #\2)
		(#\３ . #\3)
		(#\４ . #\4)
		(#\５ . #\5)
		(#\６ . #\6)
		(#\７ . #\7)
		(#\８ . #\8)
		(#\９ . #\9)
		(#\０ . #\0)))

(defun convert (str)
	(let ((result nil)
				(acc))
	(loop
		for chr in (coerce str 'list)
		do (if (and (eql acc #\Cr) (eql chr #\Lf))
				 (progn (pop result)
								(push #\NewLine result)))
		do (let ((p (assoc chr *conv-list*))
						 (code (char-code chr)))
				 (cond 
					 ((and (<= 65345 code) (<= code 65370))
						(push (code-char (- code 65248)) result))
					 (p (push (cdr p) result))
					 (t (push chr result))))
		do (setq acc chr))
	(concatenate 'string (nreverse result))))

(defvar *group1*
	'("です。" "ます。" "ございます。" "ません。"))

(defvar *group2*
	'("ある。" "ない。"))

(defun same-group-p (str)
	(let ((group1 nil)
				(group2 nil))
		(mapc #'(lambda (key) (if (include key str)
														(setq group1 t)))
					*group1*)
		(mapc #'(lambda (key) (if (include key str)
														(setq group2 t)))
					*group2*)
		(cond
			((and group1 group2)
			 nil)
			(group1 t)
			(group2 t)
			(t t))))

(defun include (key str)
	(let ((flag nil)
				(len1 (length str))
				(len2 (length key)))
		(loop
			for i from 0 to (- len1 len2)
			do (if (string= key str :start2 i :end2 (+ i len2))
					 (setq flag t))
			until flag)
		flag))

