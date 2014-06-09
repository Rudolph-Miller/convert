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
		do (let ((p (assoc chr *conv-list*)))
				 (if p
					 (push (cdr p) result)
					 (push chr result)))
		do (setq acc chr))
	(concatenate 'string (nreverse result))))


