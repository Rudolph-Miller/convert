(load "~/quicklisp/setup.lisp")
(require :clack)
(require :ningle)

(load "test")

(defvar *app* (make-instance 'ningle:<app>))

(defun home ()
	(format nil
					(concatenate 'string 
											 "<form action=\"/result\" method=\"POST\">"
											 "<textarea id=\"inputText\" name=\"q\" rows=\"10\" cols=\"30\" style=\"width:460px;height:300px\">"
											 "</textarea></br>"
											 "<input type=\"submit\" value=\"変換\" />"
											 "</form>")))


(defun html-format (str)
	(let ((result nil)
				(acc nil))
		(loop
			for chr in (coerce str 'list)
			do (push chr acc)
			when (eql #\NewLine chr) 
			do (progn (push (nreverse acc) result)
								(setq acc nil)))
		(push (nreverse acc) result)
		(apply #'concatenate 
			'string
			(mapcar #'(lambda (item)
									(append (coerce "<p>" 'list) item (coerce "</p>" 'list)))
							(nreverse result)))))

(setf (ningle:route *app* "/")
			(home))

(setf (ningle:route *app* "/result" :method :POST)
			#'(lambda (params)
					(let ((q (getf params :|q|)))
							(html-format (convert q)))))

(clack:clackup *app*)
