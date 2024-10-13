;nyquist plug-in
;type generate
;name "Increase Volume by 1dB"
;version 1.0

(defun increase-volume (sound gain)
  (mult (db-to-linear gain) sound))

; Apply 1 dB gain
(increase-volume *track* 1)
