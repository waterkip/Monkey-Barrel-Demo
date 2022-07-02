//
//SPDX-FileCopyrightText: 2022 Wesley Schwengle <wesley@opperschaap.net>
//
//SPDX-License-Identifier: BSD-3-Clause
//

using Toybox.Lang;

module MonkeyBarrelDemo {

    (:foo)
    module Demo {

      function foo() {
        return true;
      }

      function bar() {
        return false;
      }
    }

}
