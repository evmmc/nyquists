;nyquist plug-in
;version 2
;type process
;name "Turntable Warping (v3)..."
;action "Warping audio..."
;info "by David R. Sky and Steve Daulton.\nBased on warp tutorial by Roger B. Dannenberg\nReleased under GPL v2.\n"


;; Turntable Warping (mono/stereo) by David R. Sky, December 26, 2004 
;; Turntable Warping (v3) by Steve Daulton May 2012
;; Based on warp tutorial by Roger B. Dannenberg
;; Released under terms of the GNU General Public License version 2:
;; http://www.gnu.org/licenses/old-licenses/gpl-2.0.html 


;control step0 "Initial step" int "semitones" 0 -36 36
;control amp0 "Initial amplitude" real "percent" 100 0 100
;control midtime "Change time" real "percent" 20.0 0.0 100.0
;control step1 "End step" int "semitones" -12 -36 36
;control amp1 "End amplitude" real "percent" 40 0 100

; amp values to linear
(setq amp0 (* amp0 0.01))
(setq amp1 (* amp1 0.01))

; function to stretch audio to inverse of duration
(defun newstretch (dur sig)
  (force-srate *sound-srate* 
    (stretch-abs (/ 1.0 dur) (sound sig))))

; Variable Resample function by Roger B. Dannenberg
(defun variable-resample (steps snd)
  ; p1 helps convert steps to a ratio        
  (let ((p1 (/ (log 2.0) 12)) ratio map)
    ; pitch ratio
    (setf ratio (s-exp (mult steps p1))) 
    ; map from real-time to sound time     
    (setf map (integrate ratio))
    (snd-compose snd (force-srate *sound-srate* map))))

; Compute duration after warp
; This math is an assumption of how to calculate duration after warp
(defun warptime (step midtime)
  (* midtime (expt 2.0 (/ step -24.0))))

(defun dowarp (sig)
  (let ((ampenv (pwl 0.0 amp0 midtime0 1.0 dur amp1 (+ dur pad)))
        (pitchenv (pwl 0.0 step0 midtime0 0 finish step1 finish 0)))
    (newstretch dur
      (variable-resample 
        pitchenv
        (mult ampenv (sound sig))))))

; Times in seconds
(setq dur (get-duration 1))                   ; original duration

(setq midtime0 
  (get-duration (/ midtime 100.0)))           ; effect in time

(setq midtime1 
  (get-duration (- 1.0 (/ midtime 100.0))))   ; effect out time

(setq finish                                  ; end time after stretch
  (+ (warptime step0 midtime0) 
     (warptime step1 midtime1)))

(setq pad (/ dur))                            ; 1 second padding for ampenv

; Do the time warp
(multichan-expand #'dowarp s)
