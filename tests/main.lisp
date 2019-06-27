(defpackage convenience-string/tests/main
  (:use :cl
        :convenience-string
        :rove))
(in-package :convenience-string/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :convenience-string)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
