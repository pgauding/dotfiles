;;(package-initialize)

;; Not necessary in Emacs 27
;;(server-start)

;; Remove annoying warning in Emacs 27
;;(setq byte-compile warnings '(cl-functions))

(pdf-tools-install)
(add-hook 'prog-mode-hook 'linum-on)

(desktop-save-mode 1)
;; Need to have to to ensure title-bar can be read with desktop-save-mode enabled
;;(add-to-list 'frameset-filter-alist '(ns-transparent-titlebar . :never))
(add-to-list 'frameset-filter-alist '(ns-appearance . :never))

(setq load-prefer-newer t)

;;;;Org mode configuration

;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen
(setq org-log-done 'time)
(setq org-todo-keywords
      '((sequence "TODO" "IN PROGRESS" "WAITING" "FEEDBACK" "|" "DONE" "DELEGATED" "CANCELED")))
(setq org-todo-keyword-faces
      '(;;("TODO" . (:foreground "#FA8072" :weight bold))
	("IN PROGRESS" . "#E35DBF")
	("WAITING" . "#e6e600")
	("FEEDBACK" . "#cccc00")
	("DELEGATED" . "#4dffff")
	("CANCELED" . "#008080")))
(setq org-indent-indentation-per-level 1)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(blink-cursor-mode nil)
 '(cua-auto-tabify-rectangles nil)
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes '(wombat))
 '(custom-safe-themes
   '("9685cefcb4efd32520b899a34925c476e7920725c8d1f660e7336f37d6d95764" "3860a842e0bf585df9e5785e06d600a86e8b605e5cc0b74320dfe667bcbe816c" default))
 '(elpy-rpc-python-command "python3")
 '(global-linum-mode nil)
 '(line-number-mode nil)
 '(markdown-command "/usr/local/bin/pandoc")
 '(menu-bar-mode t)
 '(ns-auto-hide-menu-bar nil)
 '(org-agenda-files
   '("~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/TODO.org"))
 '(org-babel-load-languages '((emacs-lisp . t) (R . t)))
 '(org-confirm-babel-evaluate nil)
 '(package-selected-packages
   '(org-roam org-ref deft linum-relative pdf-tools tablist company-jedi jedi elpy iedit python-mode exec-path-from-shell org-pomodoro helm-R helm company-auctex auctex company ess binder vterm use-package magit neotree org-cua-dwim org-beautify-theme org-bullets mbsync offlineimap engine-mode anaconda-mode synosaurus god-mode gnu-elpa-keyring-update poly-R poly-markdown polymode julia-shell julia-repl julia-mode markdown-mode ein stan-snippets stan-mode ace-window grandshell-theme))
 '(python-guess-indent nil)
 '(python-indent 4)
 '(python-indent-guess-indent-offset nil)
 '(python-indent-offset 4)
 '(scroll-bar-mode nil)
 '(send-mail-function 'mailclient-send-it)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(button ((t nil))))

(add-hook 'after-init-hook (lambda () (load-theme 'wombat t)))
(setq ring-bell-function 'ignore)

(global-set-key (kbd "M-p") 'ace-window)

(require 'magit)

(setq column-number-mode t)

;; for .srt files
(use-package subed
  ;; Tell emacs where to find subed
  :load-path "~/.emacs.d/elisp/"
  :config
  ;; Disable automatic movement of point by default
  (add-hook 'subed-mode-hook 'subed-disable-sync-point-to-player)
  ;; Remember cursor position between sessions
  (add-hook 'subed-mode-hook 'save-place-local-mode)
  ;; Break lines automatically while typing
  (add-hook 'subed-mode-hook 'turn-on-auto-fill)
   ;; Break lines at 40 characters
  (add-hook 'subed-mode-hook (lambda () (setq-local fill-column 40))))

;; (use-package pdf-tools
;;   :config
;;   (linum-mode -1))

;; Paul Johnson
;; 2015-10-01
;;
;; This version? 2015-10-01?
;; I ran into some trouble swapping various versions of ESS in
;; my user directory, so I started tearing this apart. Cutting out
;; stuff I don't remember.
;;
;; My init file alters user interaction with R via ESS. Most
;; importantly
;; 1. *R* should start in its own frame
;; 2. S-[Return] is hot key to send line to *R*. This replaces
;;    now default C-[Return].  I need this to protect CUA
;;    mode rectangle selection
;; 3. General Emacs settings discourage "frame splitting" that
;;    the usual Emacs users seem to like.
;; 4. Slight simplification of the menu under File. I don't see
;;    need for separate "create" and "open" choices. So I put them
;;    together
;; 5. See next paragraph about the MELPA package manager
;;
;; See my companion lecture
;; "Emacs Has No Learning Curve"
;; http://pj.freefaculty.org/guides/Rcourse
;;
;; 2015-03-02
;; Following allows use of Emacs24 package manager.
;; To use, run emacs, then do
;; M-x list-packages
;; To see everything available at that moment on melpa.
;; After that, seriously consider installing ess-smart-underscore.
;; M-x package-refresh-contents
(when (>= emacs-major-version 24)
  (require 'package)
  (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
  )
;; (package-initialize)
;;   (package-initialize)
;;   (add-to-list 'package-archives
;; 	       '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; )

;; (require 'package)
;; (add-to-list 'package-archives
;;              '("elpy" . "http://jorgenschaefer.github.io/packages/" t))
;; (add-to-list 'package-archives
;; 	     '("melpa" . "http://melpa.org/packages/") t))

(require 'stan-mode)

;; Some python things I use, you may not need
(setq python-shell-interpreter "ipython3")
(setq py-python-command "python3")

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; (package-initialize)
;;(elpy-enable)
;; Deprecated
;;(elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
;; (require py-autopep8)
;; (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(require 'ess-site)
;; soft require: no error if package not found
(require 'ess-smart-underscore nil 'noerror)

(add-to-list 'auto-mode-alist '("\\..md" . poly-markdown-mode))
;;(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))



;; Org-mode with R doesn't work without this
;; http://orgmode.org/worg/org-contrib/babel/how-to-use-Org-Babel-for-R.html


(setq default-tab-width 4)

;; Section II. Keyboard and mouse customization
;; Mouse and cursor in the usual Mac/Windows way
(delete-selection-mode t)
;; http://stackoverflow.com/questions/13036155/how-to-to-combine-emacs-primary-clipboard-copy-and-paste-behavior-on-ms-windows
(setq select-active-regions t)
;; Trying to make mouse middle-click only paste from primary
;; X11 selection, not clipboard and kill ring:
(global-set-key [mouse-2] 'mouse-yank-primary)
;; highlight does not alter Kill ring:
(setq mouse-drag-copy-region nil)
;; windows style binding C-x, C-v, C-c, C-z:
(cua-mode t)
;; Don't tabify after rectangle commands:
(setq cua-auto-tabify-rectangles nil)

;; Section III. Programming conveniences:
;; light-up matching parens:
(show-paren-mode t)
;; turn on syntax highlighting:
(global-font-lock-mode t)
;; Auto fill is TRUE in text modes:
(setq text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))


;; Section IV. ESS Emacs Statistics

(setq inferior-ess-r-program "R")
;;(setq inferior-R-program-name "/Applications/R.app"

;; start R in current working directory, don't let R ask user:
(setq ess-ask-for-ess-directory nil)

;; Change shortcut "run this line" to use Shift-Return
;; Suggested by Vitalie Spinu 2013-09-30 to co-exist with Windows Emacs
(eval-after-load "ess-mode"
 '(progn
   (define-key ess-mode-map [(control return)] nil)
   (define-key ess-mode-map [(shift return)] 'ess-eval-region-or-line-and-step))
)

;; Help in frames? Consider
;; 1) create a new frame for each help instance
;; (setq ess-help-own-frame t)
;; or 2) If you want all help buffers to go into one frame do:
(setq ess-help-own-frame 'one)

;; I want the *R* process in its own frame
(setq inferior-ess-own-frame t)
(setq inferior-ess-same-window nil)

;; Section V. Frames oriented Emacs
;; Discourage Emacs from horizontal splitting:
;; http://www.gnu.org/software/emacs/elisp/html_node/Choosing-Window.html
;;(setq split-window-preferred-function nil)

;; (setq pop-up-windows nil)

;; Make files opened from the menu bar appear in their own
;; frames. Adapted from Emacs menu-bar.el
(defun menu-find-existing ()
  "Edit the existing file FILENAME."
  (interactive)
  (let* ((mustmatch (not (and (fboundp 'x-uses-old-gtk-dialog)
                              (x-uses-old-gtk-dialog))))
         (filename (car (find-file-read-args "Find file: " mustmatch))))
    (if mustmatch
        (find-file-other-frame filename)
      (find-file filename))))
(define-key menu-bar-file-menu [new-file]
  '(menu-item "Open/Create" find-file-other-frame
	      :enable (menu-bar-non-minibuffer-window-p)
	      :help "Create a new file"))
(define-key menu-bar-file-menu [open-file]
  '(menu-item ,(purecopy "Open File...") menu-find-existing
              :enable (menu-bar-non-minibuffer-window-p)
              :help ,(purecopy "Read an existing file into an Emacs buffer")))


;; Open directory list in new frame.
(define-key menu-bar-file-menu [dired]
  '(menu-item "Open Directory..." dired-other-frame
	      :help "Read a directory; operate on its files (Dired)"
	      :enable (not (window-minibuffer-p (frame-selected-window menu-updating-frame)))))




;; Section VI: Miscellaneous convenience
;; Remove Emacs "splash screen" http://fuhm.livejournal.com/
(defadvice command-line-normalize-file-name
  (before kill-stupid-startup-screen activate)
  (setq inhibit-startup-screen t))
(setq inhibit-splash-screen t)

;; Show file name in title bar
;; http://www.thetechrepo.com/main-articles/549
(setq frame-title-format "%b - Emacs")

;; Make Emacs scroll smoothly with down arrow key.
;; faq 5.45 http://www.gnu.org/s/emacs/emacs-faq.html#Modifying-pull_002ddown-menus
(setq scroll-conservatively most-positive-fixnum)

;; adjust the size of the frames, uncomment this, adjust values
(setq default-frame-alist '((width . 90) (height . 65)))


;; Remember password when connected to remote sites via Tramp
;; http://stackoverflow.com/questions/840279/passwords-in-emacs-tramp-mode-editing
;; Emacs "tramp" service (ssh connection) constantly
;; asks for the log in password without this
(setq password-cache-expiry nil)


;; Emacs shells work better
;; http://snarfed.org/why_i_run_shells_inside_emacs
(setq ansi-color-for-comint-mode 'filter)
(setq comint-prompt-read-only t)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)





;; A stata stanza from Brendan Halpin

;; Stata equivalent of ess-eval-region

(defun delimit-do (start end toggle &optional clear message)
  "Send the current region to the inferior ESS process, Stata do-editor style.
Creates a temporary file, \"do\"-es it, deletes it.
With prefix argument toggle the meaning of `ess-eval-visibly-p';
this does not apply when using the S-plus GUI, see `ess-eval-region-ddeclient'."
  (interactive "r\nP")
  (ess-force-buffer-current "Process to use: ")
  (message "Starting evaluation...")
  (setq message (or message "Eval region"))

  (save-excursion
    ;; don't send new lines (avoid screwing the debugger)
    (goto-char start)
    (skip-chars-forward "\n\t ")
    (setq start (point))

    (unless mark-active
      (ess-blink-region start end))

    ;; don't send new lines at the end (avoid screwing the debugger)
    (goto-char end)
    (skip-chars-backward "\n\t ")
    (setq end (point)))

  (let* (delimit
         (commands (buffer-substring-no-properties start end))
         (delimit-do-file (make-temp-file "delimit-do" nil ".do"))
         (proc (get-process ess-local-process-name))
         (visibly (if toggle (not ess-eval-visibly-p) ess-eval-visibly-p))
         (dev-p (process-get proc 'developer))
         (tb-p  (process-get proc 'tracebug)))
    ;; Go to the start of the section and look back for #delimit
    ;; if found set delimit unless the delimiter is not ";"
    (save-excursion
      (goto-char start)
      (setq delimit (re-search-backward "^#delimit +\\(.+\\)$" nil t))
      (if delimit
          (if (not (string-match ";" (match-string 1))) (setq delimit nil))))

    (with-temp-buffer
      (if clear (insert "clear\n"))
      (if delimit (insert "#delimit ;\n"
                          commands
                          "\n#delimit cr\n")
        (insert commands "\n"))
      (write-file delimit-do-file nil)
      (kill-buffer (current-buffer)))

    (process-send-string
     (get-ess-process ess-current-process-name)
     (format "do %s\nrm %s\n" delimit-do-file delimit-do-file))
    )
  (if (and (fboundp 'deactivate-mark) ess-eval-deactivate-mark)
      (deactivate-mark))
  ;; return value
  (list start end))

;; Trying to set up a Zettelkasen type system
;; https://rgoswami.me/posts/org-note-workflow/

(setq
   org_notes (concat (getenv "HOME") "/GIT/paper-notes")
   zot_bib (concat (getenv "HOME") "/Documents/research/dissertation/bib/gauding-diss.bib")
   org-directory org_notes
   deft-directory org_notes
   org-roam-directory org_notes
   )

(use-package deft
  :commands deft
  :init
  (setq deft-default-extension "org"
        ;; de-couples filename and note title:
        deft-use-filename-as-title nil
        deft-use-filter-string-for-filename t
        ;; disable auto-save
        deft-auto-save-interval -1.0
        ;; converts the filter string into a readable file-name using kebab-case:
        deft-file-naming-rules
        '((noslash . "-")
          (nospace . "-")
          (case-fn . downcase)))
  :config
  (add-to-list 'deft-extensions "tex")
  )

(setq
 bibtex-completion-notes-path (concat (getenv "HOME") "/GIT/paper-notes")
 bibtex-completion-bibliography (concat (getenv "HOME") "/Documents/research/dissertation/bib/gauding-diss.bib")
;; bibtex-completion-library-path "~/Zotero/"
 bibtex-completion-pdf-field "file"
 bibtex-completion-notes-template-multiple-files
 (concat
  "#+TITLE: ${=key=}: ${title}\n"
  "#+ROAM_KEY: cite:${=key=}\n"
  "* TODO Notes\n"
  ":PROPERTIES:\n"
  ":Custom_ID: ${=key=}\n"
  ;;  ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
  ":NOTER_DOCUMENT: ${file}"
  ":AUTHOR: ${author-abbrev}\n"
  ":JOURNAL: ${journal}\n"
  ":VOLUME: ${volume}\n"
  ":ISSUE: ${number}\n"
  ":DATE: ${date}\n"
  ":YEAR: ${year}\n"
  ":DOI: ${doi}\n"
  ":URL: ${url}\n"
  ":END:\n\n"
  )
 )

(use-package org-ref
    :config
    (setq
         org-ref-completion-library 'org-ref-ivy-cite
         org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
         org-ref-default-bibliography (list  (concat (getenv "HOME") "/Documents/research/dissertation/bib/gauding-diss.bib"))
         org-ref-bibliography-notes  (concat (getenv "HOME") "/GIT/paper-notes/bibnotes.org")
         org-ref-note-title-format "* TODO %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
         org-ref-notes-directory (concat (getenv "HOME") "/GIT/paper-notes")
         org-ref-notes-function 'orb-edit-notes
    ))

(use-package org-roam
  :hook (org-load . org-roam-mode)
  :commands (org-roam-buffer-toggle-display
             org-roam-find-file
             org-roam-graph
             org-roam-insert
             org-roam-switch-to-buffer
             org-roam-dailies-date
             org-roam-dailies-today
             org-roam-dailies-tomorrow
             org-roam-dailies-yesterday)
  :preface
  ;; Set this to nil so we can later detect whether the user has set a custom
  ;; directory for it, and default to `org-directory' if they haven't.
  (defvar org-roam-directory nil)
  :init
  :config
  (setq org-roam-directory (expand-file-name (or org-roam-directory "roam")
                                             org-directory)
        org-roam-verbose nil  ; https://youtu.be/fn4jIlFwuLU
        org-roam-buffer-no-delete-other-windows t ; make org-roam buffer sticky
        org-roam-completion-system 'default
)

  ;; Normally, the org-roam buffer doesn't open until you explicitly call
  ;; `org-roam'. If `+org-roam-open-buffer-on-find-file' is non-nil, the
  ;; org-roam buffer will be opened for you when you use `org-roam-find-file'
  ;; (but not `find-file', to limit the scope of this behavior).
  (add-hook 'find-file-hook
    (defun +org-roam-open-buffer-maybe-h ()
      (and +org-roam-open-buffer-on-find-file
           (memq 'org-roam-buffer--update-maybe post-command-hook)
           (not (window-parameter nil 'window-side)) ; don't proc for popups
           (not (eq 'visible (org-roam-buffer--visibility)))
           (with-current-buffer (window-buffer)
             (org-roam-buffer--get-create)))))

  ;; Hide the mode line in the org-roam buffer, since it serves no purpose. This
  ;; makes it easier to distinguish among other org buffers.
  (add-hook 'org-roam-buffer-prepare-hook #'hide-mode-line-mode))


;; Since the org module lazy loads org-protocol (waits until an org URL is
;; detected), we can safely chain `org-roam-protocol' to it.
(use-package org-roam-protocol
  :after org-protocol)


(use-package company-org-roam
  :after org-roam
  :config
  (set-company-backend! 'org-mode '(company-org-roam company-yasnippet company-dabbrev)))

 (use-package org-roam-bibtex
  :after (org-roam)
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (setq org-roam-bibtex-preformat-keywords
   '("=key=" "title" "url" "file" "author-or-editor" "keywords"))
  (setq orb-templates
        '(("r" "ref" plain (function org-roam-capture--get-point)
           ""
           :file-name "${slug}"
           :head "#+TITLE: ${=key=}: ${title}\n#+ROAM_KEY: ${ref}

- tags ::
- keywords :: ${keywords}

\n* ${title}\n  :PROPERTIES:\n  :Custom_ID: ${=key=}\n  :URL: ${url}\n  :AUTHOR: ${author-or-editor}\n  :NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n  :NOTER_PAGE: \n  :END:\n\n"

           :unnarrowed t))))

(use-package org-noter
  :after (:any org pdf-view)
  :config
  (setq
   ;; The WM can handle splits
   org-noter-notes-window-location 'other-frame
   ;; Please stop opening frames
   org-noter-always-create-frame nil
   ;; I want to see the whole file
   org-noter-hide-other nil
   ;; Everything is relative to the main notes file
   org-noter-notes-search-path (list org_notes)
   )
  )

;; Actually start using templates
(after! org-capture
  ;; Firefox and Chrome
  (add-to-list 'org-capture-templates
               '("P" "Protocol" entry ; key, name, type
                 (file+headline +org-capture-notes-file "Inbox") ; target
                 "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?"
                 :prepend t ; properties
                 :kill-buffer t))
  (add-to-list 'org-capture-templates
               '("L" "Protocol Link" entry
                 (file+headline +org-capture-notes-file "Inbox")
                 "* %? [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]\n"
                 :prepend t
                 :kill-buffer t))
)
