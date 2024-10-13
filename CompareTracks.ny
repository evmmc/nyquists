;nyquist plug-in
;version 1
;type process
;name "Compare Two Tracks for Signal Loss"
;action "Comparing tracks..."
;control track1 "Track 1" file ""
;control track2 "Track 2" file ""

; Function to calculate RMS level
(defun rms (snd)
  (let ((rms-value (rms snd)))
    rms-value))

; Load the two audio tracks
(setf track1 (snd-fetch track1))
(setf track2 (snd-fetch track2))

; Calculate RMS levels for both tracks
(setf rms1 (rms track1))
(setf rms2 (rms track2))

; Compare RMS levels
(format t "RMS Level of Track 1: ~a~%" rms1)
(format t "RMS Level of Track 2: ~a~%" rms2)

; Calculate signal loss percentage
(setf signal-loss (if (> rms1 rms2)
                     (/ (- rms1 rms2) rms1)
                     (/ (- rms2 rms1) rms2)))

(format t "Signal Loss Percentage: ~a%~%" (* signal-loss 100))

; Output the results
(format t "Comparison complete.")
