
;;; requires and setup

(when load-file-name
  (setq pcache-directory (expand-file-name "pcache/" (file-name-directory load-file-name)))
  (setq package-enable-at-startup nil)
  (setq package-load-list '((pcache t)
                            (persistent-soft t)))
  (when (fboundp 'package-initialize)
    (package-initialize)))

(require 'persistent-soft)
(require 'font-utils)


;;; font-utils-name-from-xlfd

(ert-deftest font-utils-name-from-xlfd-01 nil
  (should (equal "Monaco"
                 (font-utils-name-from-xlfd
                  "-apple-Monaco-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1"))))

(ert-deftest font-utils-name-from-xlfd-02 nil
  (should (equal "Handwriting_-_Dakota"
                 (font-utils-name-from-xlfd
                  "-apple-Handwriting_-_Dakota-medium-normal-normal-*-12-*-*-*-p-0-iso10646-1"))))

(ert-deftest font-utils-name-from-xlfd-03 nil
  (should (equal "Monaco"
                 (font-utils-name-from-xlfd
                  "-apple-Monaco-bold-normal-normal-*-12-*-*-*-m-0-iso10646-1"))))

(ert-deftest font-utils-name-from-xlfd-04 nil
  (should (equal "Monaco"
                 (font-utils-name-from-xlfd
                  "-apple-Monaco-demi-bold-normal-normal-*-12-*-*-*-m-0-iso10646-1"))))


;;; font-utils-create-fuzzy-matches

(ert-deftest font-utils-create-fuzzy-matches-01 nil
  (should (equal '("Monaco")
                 (font-utils-create-fuzzy-matches "Monaco"))))

(ert-deftest font-utils-create-fuzzy-matches-02 nil
  (should (equal '("Monaco-12" "Monaco")
                 (font-utils-create-fuzzy-matches "Monaco-12"))))

(ert-deftest font-utils-create-fuzzy-matches-03 nil
  (should (equal '("Monaco-12")
                 (font-utils-create-fuzzy-matches "Monaco-12" 'keep-size))))

(ert-deftest font-utils-create-fuzzy-matches-04 nil
  (should (>= 7
              (length
               (font-utils-create-fuzzy-matches "DejaVu Sans Mono")))))


;;; font-utils-lenient-name-equal

(ert-deftest font-utils-lenient-name-equal-01 nil
  (should
   (font-utils-lenient-name-equal "DejaVu Sans Mono" "dejavusansmono")))

(ert-deftest font-utils-lenient-name-equal-02 nil
  (should
   (font-utils-lenient-name-equal "DejaVu Sans Mono" "DE-JA_VU_SANS-MONO")))

(ert-deftest font-utils-lenient-name-equal-03 nil
  (should-not
   (font-utils-lenient-name-equal "DejaVu Sans Mono" "DE-JA_VU_SANS-MON0")))


;;; font-utils-load-names

(ert-deftest font-utils-load-names-01 nil
  :tags '(:interactive)
  (should (hash-table-p
           (progn
             (font-utils-load-names 'progress 'regenerate)
             font-utils-all-names))))


;;; font-utils-list-names

(ert-deftest font-utils-list-names-01 nil
  :tags '(:interactive)
  (should (< 20
             (length (font-utils-list-names)))))

(ert-deftest font-utils-list-names-02 nil
  :tags '(:interactive)
  (should (member "Courier"
                  (font-utils-list-names))))

(ert-deftest font-utils-list-names-03 nil
  :tags '(:interactive)
  (should (member "Arial"
                  (font-utils-list-names))))


;;; font-utils-first-existing-font

(ert-deftest font-utils-first-existing-font-01 nil
  :tags '(:interactive)
  (should
   (font-utils-first-existing-font '("Courier" "Arial" "Monaco" "Consolas" "DejaVu Sans"))))


;;; font-utils-read-name

(ert-deftest font-utils-read-name-01 nil
  :tags '(:interactive)
  (should (equal "Courier"
                 (let ((cursor-in-echo-area t))
                   (read-char "Press a key, then enter \"Courier\" at the next prompt (with completions).")
                   (font-utils-read-name)))))

(ert-deftest font-utils-read-name-02 nil
  :tags '(:interactive)
  (should (equal "Courier"
                 (let ((cursor-in-echo-area t))
                   (read-char "Press a key, then enter \"Courier\" at the next prompt (with ido completions).")
                   (font-utils-read-name 'ido)))))


;;; font-utils-exists-p

(ert-deftest font-utils-exists-p-01 nil
  :tags '(:interactive)
  (should
   (font-utils-exists-p "Courier")))

(ert-deftest font-utils-exists-p-02 nil
  :tags '(:interactive)
  (should-not
   (font-utils-exists-p "__nonexistent-font__")))



;;
;; Emacs
;;
;; Local Variables:
;; indent-tabs-mode: nil
;; mangle-whitespace: t
;; require-final-newline: t
;; coding: utf-8
;; byte-compile-warnings: (not cl-functions)
;; End:
;;

;;; font-utils-test.el ends here
