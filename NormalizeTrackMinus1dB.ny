;nyquist plug-in
;type process
;name "Normalize to -1dB"
;version 1.0

(defun normalize (sound target-db)
  (scale (db-to-linear target-db) sound))

; Normalize to -1 dB
(normalize *track* -1)
