(add-to-list 'load-path user-emacs-directory)

;; session
(require 'init-sessions)

;; tomorrow theme
(add-to-list 'load-path "~/.emacs.d/el-get/color-theme/")
(require 'color-theme)
(load "~/.emacs.d/el-get/color-theme-tomorrow/GNU Emacs/color-theme-tomorrow.el")
(eval-after-load "color-theme"
  '(progn
      (color-theme-tomorrow-night)))


;; ----------------------------- 
;; 防止鼠标滚动太快
(setq mouse-wheel-scroll-amount '(2 ((shift) . 2)((control)))
mouse-wheel-progressive-speed nil
scroll-step 2)


;; ibuffer
(setq ibuffer-filter-group-name-face 'font-lock-doc-face)
(global-set-key (kbd "C-x C-b") 'ibuffer)


;; 显示行号
(global-linum-mode 1)


;; % 跳到匹配的括号(仅圆括号)
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))


;; 做个记号
(global-set-key [(control ?\.)] 'ska-point-to-register)
(global-set-key [(control ?\,)] 'ska-jump-to-register)
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register. 
Use ska-jump-to-register to jump back to the stored 
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))
(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
        (jump-to-register 8)
        (set-register 8 tmp)))


;; browse kill ring
(add-to-list 'load-path "~/.emacs.d/el-get/browse-kill-ring/")
(require 'browse-kill-ring)
(global-set-key [(control c)(k)] 'browse-kill-ring)
;; (browse-kill-ring-default-keybindings)


;; last change pos
(defvar feng-last-change-pos nil)
(defun feng-buffer-change-hook (beg end len)
  (when (and (> end beg) (buffer-file-name))
    (setq feng-last-change-pos (cons (buffer-file-name) end))))
(defun feng-goto-last-change ()
  (interactive)
  (if feng-last-change-pos
      (let ((file (car feng-last-change-pos)))
        (unless (eq (buffer-file-name) file)
          (let* ((buffer (find-file-noselect file))
                 (win (get-buffer-window buffer)))
            (if win
                (select-window win)
              (find-file file))))
        (goto-char (cdr feng-last-change-pos))
        (message "Last Edit Location"))
    (message "No Change")))



;; el-get 
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)



;; coffee mode
(define-key coffee-mode-map (kbd "C-M-x") 'coffee-compile-file)
