;nyquist plug-in
;name "Change Tempo and Preserve Key"
;action "Changing the tempo of the track while preserving the key"
;type process
;author "Your Name"

(defun change-tempo-and-preserve-key (sound tempo-factor)
  (if (<= tempo-factor 0)
      (error "Tempo factor must be positive.")
    (stretch tempo-factor sound)))

; Get the new tempo factor from the user
; Example: 1.0 means no change, 2.0 means double tempo, 0.5 means half tempo
(setq tempo-factor (get-real "Tempo Factor" 1.0))

; Apply the change-tempo-and-preserve-key function
(change-tempo-and-preserve-key *track* tempo-factor)
