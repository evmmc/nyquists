;nyquist plug-in
;type process
;name "Echo Effect"
;version 1.0

(defun echo (sound delay amount)
  (let ((delayed-sound (mult amount (snd-abs (at-delay delay sound)))))
    (plus sound delayed-sound)))

; Apply echo with a delay of 0.5 seconds and a feedback of 0.5
(echo *track* 0.5 0.5)
