(defsystem "convenience-string"
  :version "0.1.0"
  :author "Masayuki Suzuki"
  :license "MIT"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "convenience-string/tests"))))

(defsystem "convenience-string/tests"
  :author "Masayuki Suzuki"
  :license "MIT"
  :depends-on ("convenience-string"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for convenience-string"
  :perform (test-op (op c) (symbol-call :rove :run c)))
