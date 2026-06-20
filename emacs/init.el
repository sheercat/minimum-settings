;;; -*- mode: lisp-interaction; syntax: elisp -*-

(message "[init] init.el を読み込みます")

;;; 起動と基本環境

(setq inhibit-startup-screen t
      select-enable-clipboard t
      user-full-name "Your Name"
      exec-path (parse-colon-path (getenv "PATH"))
      gc-cons-threshold 500000)

(set-language-environment 'Japanese)
(set-buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

(when (functionp 'inactivate-input-method)
  (inactivate-input-method))

(message "[init] 起動と日本語設定を読み込みました")

;;; ファイル、セッション、履歴

(let* ((backup-dir "~/.emacs.d/backups")
       (expanded-backup-dir (expand-file-name backup-dir)))
  (setq backup-directory-alist `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,(concat backup-dir "/") t))
        lock-file-name-transforms `((".*" ,(concat backup-dir "/") t)))
  (unless (file-exists-p expanded-backup-dir)
    (make-directory expanded-backup-dir t)))

(setq backup-inhibited nil
      auto-save-default nil
      desktop-save t
      desktop-load-locked-desktop t
      bookmark-default-file "~/.emacs.d/.emacs.bmk"
      bookmark-save-flag 1)

(savehist-mode 1)
(desktop-save-mode 1)
(save-place-mode 1)

(message "[init] ファイル履歴とセッション設定を読み込みました")

;;; 基本 UI

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode 1))

(line-number-mode 0)
(column-number-mode t)
(global-hl-line-mode 1)

;; 縦分割したウィンドウでも長い行を折り返して表示する。
(setq truncate-lines nil
      truncate-partial-width-windows nil
      uniquify-buffer-name-style 'post-forward-angle-brackets
      scalable-fonts-allowed t
      cursor-in-non-selected-windows nil
      isearch-lazy-highlight-initial-delay 0)

(auto-image-file-mode 1)

;; 日常的に見たい空白だけを whitespace-mode で強調する。
(global-whitespace-mode 1)
(setq whitespace-space-regexp "\x3000+")
(dolist (style '(newline-mark space-mark lines space-before-tab space-after-tab empty indentation))
  (setq whitespace-style (delq style whitespace-style)))

(message "[init] UI 設定を読み込みました")

;;; 編集の既定値

(setq-default fill-column 100
              indent-tabs-mode nil
              tab-width 2
              scroll-step 1
              fume-display-in-modeline-p t)

(setq indent-tabs-mode nil
      default-tab-width 2
      mouse-yank-at-point t
      completion-ignore-case t
      next-line-add-newlines nil
      blink-matching-paren-distance 20000)

(electric-indent-mode -1)
(abbrev-mode 1)

(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

(message "[init] 編集の既定値を読み込みました")

;;; scratch バッファの表示サンプル

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

;;; custom-set-variables

(custom-set-variables
 '(show-paren-style 'parenthesis)
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
 '(session-use-package t nil (session)))

;;; キーバインドと移動

(global-set-key "\C-h" 'backward-delete-char)
(global-set-key (kbd "C-=") 'ibuffer)
(define-key ctl-x-map "\C-a" 'find-file-at-point)

;; prefix 引数なしでは既存バッファを優先して切り替える。
(defadvice switch-to-buffer (before existing-buffer activate compile)
  (interactive
   (list (read-buffer "Switch to buffer: "
                      (other-buffer)
                      (null current-prefix-arg)))))

(set-buffer-modified-p (buffer-modified-p))

;;; タブバー

(tab-bar-mode 1)

(defvar my:tb-z-prefix (kbd "C-z"))
(defvar my:tb-z-map (make-keymap))

(define-key global-map my:tb-z-prefix my:tb-z-map)
(define-key my:tb-z-map (kbd "C-c") 'tab-new)
(define-key my:tb-z-map (kbd "C-k") 'tab-close)
(define-key my:tb-z-map (kbd "C-n") 'tab-next)
(define-key my:tb-z-map (kbd "C-p") 'tab-previous)
(define-key tab-prefix-map (kbd "C-z") 'tab-prefix-map)
(define-key global-map [C-tab] 'tab-next)
(define-key global-map [C-S-tab] 'tab-previous)

(with-eval-after-load 'tab-bar
  ;; タブの動作は変えず、アクティブなタブだけ視認性を上げる。
  (set-face-attribute 'tab-bar-tab nil
                      :background "skyblue"
                      :foreground "#000000"
                      :weight 'bold
                      :underline t)
  (set-face-attribute 'tab-bar-tab-inactive nil
                      :background "darkgreen"
                      :foreground "#a7adba"
                      :weight 'normal
                      :underline nil))

(message "[init] キーバインドとタブバー設定を読み込みました")

;;; ibuffer

(setq ibuffer-saved-filter-groups
      '(("default"
         ("Dired" (mode . dired-mode))
         ("Org" (mode . org-mode))
         ("Source Code" (or (mode . emacs-lisp-mode)
                            (mode . c-mode)
                            (mode . c++-mode)
                            (mode . python-mode)
                            (mode . web-mode)))
         ("Magit / Git" (name . "^\\*magit"))
         ("Emacs" (name . "^\\*.*\\*$"))))
      ibuffer-show-empty-filter-groups nil)

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;;; シェル、端末、VC

(setq auto-autoloads-psvn nil
      vc-handled-backends '(git)
      shell-file-name "zsh"
      shell-command-switch "-c"
      explicit-bash-args '("--login" "-i")
      eol-mnemonic-dos ":CRLF"
      eol-mnemonic-mac ":CR"
      eol-mnemonic-unix ":LF")

(autoload 'ansi-color-for-comint-mode-on "ansi-color")
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defvar ansi-term-after-hook nil)
(add-hook 'ansi-term-after-hook
          (lambda ()
            (define-key term-raw-map "\C-t" 'shell-pop)))

(defadvice ansi-term (after ansi-term-after-advice (arg))
  "Run `ansi-term-after-hook' after starting ansi-term."
  (run-hooks 'ansi-term-after-hook))
(ad-activate 'ansi-term)

(when (or (featurep 'meadow) window-system)
  (setq find-command "fd"
        igrep-expression-option nil))

(message "[init] ibuffer、シェル、VC 設定を読み込みました")

;;; 補完と強調表示

(add-hook 'outline-mode-hook 'highlight-changes-mode)

(when (or window-system (> emacs-major-version 21))
  (require 'dabbrev-highlight nil t))

(defvar dabbrev-expand-ad-overlay nil)
(defvar dabbrev-expand-ad-face 'highlight)

;; dabbrev の展開元が見えていれば強調し、見えていなければ一行で表示する。
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
            (if dabbrev-expand-ad-overlay
                (move-overlay dabbrev-expand-ad-overlay start end)
              (setq dabbrev-expand-ad-overlay (make-overlay start end)))
            (overlay-put dabbrev-expand-ad-overlay 'evaporate t)
            (overlay-put dabbrev-expand-ad-overlay 'face dabbrev-expand-ad-face))
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
  (when dabbrev-expand-ad-overlay
    (delete-overlay dabbrev-expand-ad-overlay)))

(defface my-face-b-1 '((t (:background "gray98"))) nil)
(defface my-face-b-2 '((t (:background "beige"))) nil)
(defface my-face-w-1 '((t (:background "gray93"))) nil)
(defface my-face-u-1 '((t (:foreground "chocolate" :underline t))) nil)

(defun my-insert-whitespace-keywords ()
  (font-lock-add-keywords
   nil ; 第一引数を nil にすると「現在のバッファ（モード）」に適用されます
   '(("\t" 0 'my-face-b-2 append)
     (" " 0 'my-face-b-1 append)
     ("[　 \t]+$" 0 'my-face-u-1 append)
     ("　" 0 'my-face-w-1 append)
     )
   ))

;; font-lock-mode がONになったときに、上記の関数を実行する
(add-hook 'font-lock-mode-hook 'my-insert-whitespace-keywords)

(message "[init] 補完と強調表示の設定を読み込みました")

;;; macOS

(when (eq system-type 'darwin)
  (when window-system
    ;; git clone https://github.com/powerline/fonts
    ;; cd fonts; ./install.sh; fc-cache
    ;; https://myrica.estable.jp/myricamhistry/
    (set-face-attribute 'default nil :family "MyricaM M" :height (* 18 10))
    (setq frame-inherited-parameters '(font tool-bar-lines)))

  (if (version< "27.0" emacs-version)
      (set-language-info "Japanese" 'input-method "MacOSX")
    (set-language-info "Japanese" 'input-method "macOS")
    (setq default-inline-patch "macOS")
    (custom-set-variables
     '(mac-default-input-source "com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese")))

  (setq browse-url-generic-program "open"
        mac-emulate-three-button-mouse t
        mac-option-key-is-meta t
        mac-command-key-is-meta t
        mac-command-modifier 'meta
        mac-option-modifier 'meta)

  (defun mac-selected-keyboard-input-source-change-hook-func ()
    (set-cursor-color (if (string-match "\\.ABC$" (mac-input-source))
                          "firebrick"
                        "pink")))

  (add-hook 'mac-selected-keyboard-input-source-change-hook
            'mac-selected-keyboard-input-source-change-hook-func)

  ;; railwaycat 版 emacs-mac 用。
  (when (functionp 'mac-auto-ascii-mode)
    (mac-auto-ascii-mode 1)))

(message "[init] init.el の読み込みが完了しました")
