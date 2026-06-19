;;; -*- mode: lisp-interaction; syntax: elisp -*-
;; (global-linum-mode t)

(message "start load init.el")

(and nil
     (when (eq system-type 'darwin)
       (set-face-attribute 'default nil :family "Menlo" :height 140))
     (keyboard-translate ?\C-h ?\C-?)
     )


(setq select-enable-clipboard t)
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))

(let ((backup-dir "~/.emacs.d/backups"))
  (setq backup-directory-alist `(("." . ,backup-dir)))
  (setq auto-save-file-name-transforms `((".*" ,(concat backup-dir "/") t)))
  (setq lock-file-name-transforms `((".*" ,(concat backup-dir "/") t)))
  (let ((b-dir (expand-file-name backup-dir)))
    (unless (file-exists-p b-dir)
      (make-directory b-dir t))))

;; --- 標準機能によるセッション・履歴保存設定 ---
(savehist-mode 1)
(desktop-save-mode 1)
(save-place-mode 1)

;; desktopの確認をスキップする快適設定
(setq desktop-save t)
(setq desktop-load-locked-desktop t);; デスクトップ（セッション）保存を有効化

(global-set-key "\C-h" 'backward-delete-char)
;; (global-set-key "\C-z" 'undo)

(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

(setq initial-scratch-message "\
;+-------------------------------+
;|0         1         2         3|
;|0123456789012345678901234567890|
;|‘1234567890-=                  |
;|~!@#$%^&*()_+[]{}|’:\",./<>?    |
;|abcdefghijklmnopqrstuvwxyz     |
;|ABCDEFGHIJKLMNOPQRSTUVWXYZ     |
;|ｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴ       |
;|あいうえおあいうえおあい       |
;|+-----+------+--------+        |
;|| 123 |<<<>>>|ABC α β |        |
;|+-----+------+--------+        |
;|| 薔  | い   | う　   |        |
;||     |      | 高え   |        |
;|| お  | 　む | 麒麟児 |        |
;|+-----+------+--------+        |
;+-------------------------------+
; [U+0250-02AF] IPA拡張（国際音声記号）
; ɐ ɑ ɒ ɓ ɔ ɕ ɖ ɗ ɘ ə ɚ ɛ ɜ ɝ ɞ ɟ
; ɠ ɡ ɢ ɣ ɤ ɥ ɦ ɧ ɨ ɩ ɪ ɫ ɬ ɭ ɮ ɯ
; ɰ ɱ ɲ ɳ ɴ ɵ ɶ ɷ ɸ ɹ ɺ ɻ ɼ ɽ ɾ ɿ
; ʀ ʁ ʂ ʃ ʄ ʅ ʆ ʇ ʈ ʉ ʊ ʋ ʌ ʍ ʎ ʏ
; ʐ ʑ ʒ ʓ ʔ ʕ ʖ ʗ ʘ ʙ ʚ ʛ ʜ ʝ ʞ ʟ
; ʠ ʡ ʢ ʣ ʤ ʥ ʦ ʧ ʨ ʩ ʪ ʫ ʬ ʭ ʮ ʯ
")

(setq user-full-name "Your Name")
(setq exec-path (parse-colon-path (getenv "PATH")))
(setq-default fill-column 100)

(and (version<= "26.0.50" emacs-version )
     (display-line-numbers-mode nil)
     (global-display-line-numbers-mode)
     )
(line-number-mode 0)
(column-number-mode t)
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)
(setq mouse-yank-at-point t)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(setq-default fume-display-in-modeline-p t)

(setq completion-ignore-case t)

;; 画面縦割りでトランケートさせない
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

(message "step 1")

(setq inhibit-startup-screen t)
(set-language-environment "Japanese")
(setq gc-cons-threshold 500000)

(message "step 2")

;;
;; tab bar
;;
(tab-bar-mode +1)
(defvar my:tb-z-prefix (kbd "C-z"))
(setq my:tb-z-map (make-keymap))

(define-key global-map my:tb-z-prefix my:tb-z-map)
(define-key my:tb-z-map (kbd "C-c") 'tab-new)
(define-key my:tb-z-map (kbd "C-k") 'tab-close)
(define-key my:tb-z-map (kbd "C-n") 'tab-next)
(define-key my:tb-z-map (kbd "C-p") 'tab-previous)
(define-key tab-prefix-map (kbd "C-z") 'tab-prefix-map)
(define-key global-map [C-tab]     'tab-next)
(define-key global-map [C-S-tab]   'tab-previous)

(with-eval-after-load 'tab-bar
  ;; 現在のタブ（アクティブ）の見た目
  (set-face-attribute 'tab-bar-tab nil
                      :background "skyblue" ; 背景色（お好みの色に）
                      :foreground "#000000" ; 文字色
                      :weight 'bold         ; 太字
                      :underline t)         ; 下線

  ;; それ以外のタブ（非アクティブ）の見た目（色のメリハリをつける）
  (set-face-attribute 'tab-bar-tab-inactive nil
                      :background "darkgreen" ; 落ち着いた背景色
                      :foreground "#a7adba" ; 控えめな文字色
                      :weight 'normal
                      :underline nil))


(message "step 3")
(custom-set-variables
 '(show-paren-style (quote parenthesis))
 '(show-paren-delay 0)
 '(show-paren-mode t nil (paren))
 '(show-paren-ring-bell-on-mismatch nil)
 '(visible-bell t)
 '(c-site-default-style "bsd")
 '(global-font-lock-mode t nil (font-lock))
 '(ansi-color-names-vector ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(package-selected-packages '(package-build shut-up epl git commander f dash s))
 '(safe-local-variable-values
   '((checkdoc-minor-mode . t)
     (encoding . utf-8)
     (encoding . utf-8-unix)
     (encoding . UTF-8)
     (syntax . elisp)))
 '(session-use-package t nil (session))
 )

(setq bookmark-default-file "~/.emacs.d/.emacs.bmk")
(if (or (featurep 'meadow) window-system)
    (progn (setq find-command "fd")
           ;;           (setq grep-command "lgrep -n -As ")
           ;;           (setq igrep-program "lgrep -As")
           (setq igrep-expression-option nil)
           ))

(setq-default tab-width 2 indent-tabs-mode nil)

(message "step 4")
(setq next-line-add-newlines nil)
(setq-default tab-width '2)
(setq default-tab-width  2)
(setq bookmark-save-flag 1)
(setq-default scroll-step 1)
(setq blink-matching-paren-distance 20000)
(defadvice switch-to-buffer (before existing-buffer activate compile)
  (interactive
   (list (read-buffer "Switch to buffer: "
                      (other-buffer)
                      (null current-prefix-arg)))))
(set-buffer-modified-p (buffer-modified-p))

(add-hook 'outline-mode-hook 'highlight-changes-mode)
(and (or window-system (> emacs-major-version '21))
     (require 'dabbrev-highlight nil t))

(message "step 5")
(defvar dabbrev-expand-ad-overlay nil)
(defvar dabbrev-expand-ad-face 'highlight)


(defadvice dabbrev-expand (after dabbrev-expand-ad activate)
  (let* ((start dabbrev--last-expansion-location)
         (len (length dabbrev--last-expansion))
         (buf (or dabbrev--last-buffer (current-buffer)))
         (cbuf (current-buffer))
         (cwin (selected-window))
         end str lstart lend)
    (save-excursion
      (cond
       ((and (eq buf cbuf) (> start (point)))
        (setq end start)
        (setq start (- end len)))
       ((eq buf cbuf)
        (setq end (+ start len)))
       (t
        (set-buffer buf)
        (setq end start)
        (setq start (- end len))))
      (if (and (get-buffer-window buf)
               (select-window (get-buffer-window buf))
               (pos-visible-in-window-p start)
               (pos-visible-in-window-p end))
          (progn
            ;; overlay
            (if dabbrev-expand-ad-overlay
                (move-overlay dabbrev-expand-ad-overlay start end)
              (setq dabbrev-expand-ad-overlay (make-overlay start end)))
            (overlay-put dabbrev-expand-ad-overlay 'evaporate t)
            (overlay-put dabbrev-expand-ad-overlay 'face dabbrev-expand-ad-face))
        ;; 一行表示
        (save-excursion
          (save-restriction
            (widen)
            (goto-char start)
            (setq str (buffer-substring-no-properties start end))
            (setq lstart (progn (beginning-of-line) (point)))
            (setq lend (progn (end-of-line) (point)))
            (if (and (> emacs-major-version 20) (not (featurep 'xemacs)))
                (put-text-property 0 (length str) 'face dabbrev-expand-ad-face str)
              (setq str (concat " *" str "* ")))
            (message "%s(%d): %s%s%s"
                     (buffer-name buf)
                     (count-lines (point-min) start)
                     (buffer-substring-no-properties lstart start)
                     str
                     (buffer-substring-no-properties end lend)))))
      (select-window cwin)
      (select-window cwin)
      (add-hook 'pre-command-hook 'dabbrev-expand-ad-done))))

(defun dabbrev-expand-ad-done ()
  (remove-hook 'pre-command-hook 'dabbrev-expand-ad-done)
  (and dabbrev-expand-ad-overlay
       (delete-overlay dabbrev-expand-ad-overlay)))
(abbrev-mode t)
(if (or (featurep 'meadow) (featurep 'meadow-ntemacs) window-system)
    (global-hl-line-mode)
  )
(define-key ctl-x-map "\C-a" 'find-file-at-point)

(message "step 6")
(setq auto-autoloads-psvn nil)
(setq vc-handled-backends '(git))
(setq shell-file-name "zsh")
(setq shell-command-switch "-c")
(setq explicit-bash-args '("--login" "-i"))
(autoload 'ansi-color-for-comint-mode-on "ansi-color")
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq backup-inhibited nil)
(setq auto-save-default nil)
(setq eol-mnemonic-dos ":CRLF")
(setq eol-mnemonic-mac ":CR")
(setq eol-mnemonic-unix ":LF")
(defvar ansi-term-after-hook nil)
(add-hook 'ansi-term-after-hook
          (function
           (lambda ()
             (define-key term-raw-map "\C-t" 'shell-pop))))
(defadvice ansi-term (after ansi-term-after-advice (arg))
  "run hook as after advice"
  (run-hooks 'ansi-term-after-hook))
(ad-activate 'ansi-term)
(if (functionp 'inactivate-input-method)
    (inactivate-input-method))
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
     ("[ \t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(if (>= emacs-major-version 21)
    (progn
      (setq cursor-in-non-selected-windows nil)
      (auto-image-file-mode)
      (setq isearch-lazy-highlight-initial-delay 0)
      ))
(if (functionp 'inactivate-input-method)
    (inactivate-input-method))
(setq scalable-fonts-allowed t)

;; git clone https://github.com/powerline/fonts
;; cd fonts; ./install.sh; fc-cache
;; https://myrica.estable.jp/myricamhistry/
(and (string= system-type "darwin")
     (when window-system
       (set-face-attribute 'default nil :family "MyricaM M" :height (* 18 10))
       (setq frame-inherited-parameters '(font tool-bar-lines)))
     )

(electric-indent-mode) ;; off

(global-whitespace-mode 1)

(message "step 7")
;; スペースの定義は全角スペースとする。
(setq whitespace-space-regexp "\x3000+")
(dolist (d '(newline-mark space-mark lines space-before-tab  space-after-tab empty indentation ))
  (setq whitespace-style (delq d whitespace-style)))

(message "step 8")

(set-language-environment 'Japanese)
(set-buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

(message "step 9")

;; ibuffer でバッファを自動的にグループ分けする
(setq ibuffer-saved-filter-groups
      '(("default"
         ("Dired" (mode . dired-mode))
         ("Org" (mode . org-mode))
         ("Source Code" (or (mode . emacs-lisp-mode)
                            (mode . c-mode)
                            (mode . c++-mode)
                            (mode . python-mode)
                            (mode . web-mode))) ; 使う言語に合わせて追加
         ("Magit / Git" (name . "^\\*magit"))
         ("Emacs" (name . "^\\*.*\\*$")))))

;; ibuffer 起動時に上記のグループ化を有効にする
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;; 空のグループは表示しない
(setq ibuffer-show-empty-filter-groups nil)

(global-set-key (kbd "C-=") 'ibuffer)


;;
;; for macos
;;
(and t
     (if (version< "27.0" emacs-version)
         (set-language-info "Japanese" 'input-method "MacOSX")
       (set-language-info "Japanese" 'input-method "macOS")
       (setq default-inline-patch "macOS")
       ;;    (when (and (memq window-system '(ns nil))
       ;;             (fboundp 'mac-get-current-input-source))
       (custom-set-variables
        '(mac-default-input-source "com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese"))
       ;; (mac-input-method-mode 1)
       ;;)
       ))

(setq browse-url-generic-program "open")
(setq mac-emulate-three-button-mouse t)
(setq mac-option-key-is-meta t)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'meta)
(defun mac-selected-keyboard-input-source-change-hook-func ()
  ;; 入力モードが英語の時はカーソルの色をfirebrickに、日本語の時はpinkにする
  (set-cursor-color (if (string-match "\\.ABC$" (mac-input-source))
                        "firebrick" "pink")))
(add-hook 'mac-selected-keyboard-input-source-change-hook
          'mac-selected-keyboard-input-source-change-hook-func)

;; for emacs-mac by railwaycat
(if (functionp 'mac-auto-ascii-mode)
    (mac-auto-ascii-mode 1))

(message "end   load init.el")

