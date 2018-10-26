;;; packages.el --- boyang layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Boyang Yan <yanboyang713@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `boyang-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `boyang/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `boyang/pre-init-PACKAGE' and/or
;;   `boyang/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst boyang-packages
  '(
    mu4e
    )
)
(defun boyang/init-gud-lldb ()
  (use-package gud-lldb
    :init
    (add-hook 'gud-mode-hook 'lldb-mode-hook)
    ))


(defun boyang/post-init-mu4e ()
  :init
  (progn
;;; Set up some common mu4e variables
    (setq mu4e-maildir "~/.mail"
          mu4e-trash-folder "/Trash"
          mu4e-refile-folder "/Archive"
          mu4e-get-mail-command "mbsync -a"
          mu4e-update-interval 300
          mu4e-compose-signature-auto-include nil
          mu4e-view-show-images t
          mu4e-view-show-addresses t)

;;; Mail directory shortcuts
    (setq mu4e-maildir-shortcuts
          '(("/gmail/INBOX" . ?g)
            ))

;;; Bookmarks
    (setq mu4e-bookmarks
          `(("flag:unread AND NOT flag:trashed" "Unread messages" ?u)
            ("date:today..now" "Today's messages" ?t)
            ("date:7d..now" "Last 7 days" ?w)
            ("mime:image/*" "Messages with images" ?p)
            (,(mapconcat 'identity
                         (mapcar
                          (lambda (maildir)
                            (concat "maildir:" (car maildir)))
                          mu4e-maildir-shortcuts) " OR ")
             "All inboxes" ?i)))
    ;; init commands
    (setq mu4e-account-alist t)
    (setq mu4e-account-alist
          '(("gmail"
             ;; Under each account, set the account-specific variables you want.
             (mu4e-sent-messages-behavior delete)
             (mu4e-trash-folder  "gmail/trash")    ;; trashed messages
             (mu4e-refile-folder "/gmail/archive") ;; saved messages
             (mu4e-sent-folder "/gmail/[Gmail].Sent Mail")
             (mu4e-drafts-folder "/gmail/[Gmail].Drafts")
             (user-mail-address "yanboyang713@gmail.com")
             (user-full-name "Boyang Yan"))
            ))
    
    )
  :config
  (progn
    ;; config commands (after init)
    (setq mu4e-enable-notifications t)

    (with-eval-after-load 'mu4e-alert
      ;; Enable Desktop notifications
      (mu4e-alert-set-default-style 'notifications)) ; For linux
    ;; (mu4e-alert-set-default-style 'libnotify))  ; Alternative for linux
    ;; (mu4e-alert-set-default-style 'notifier))   ; For Mac OSX (through the
                                        ; terminal notifier app)
    ;; (mu4e-alert-set-default-style 'growl))      ; Alternative for Mac OSX
    )
  (setq mu4e-enable-mode-line t)
  )
