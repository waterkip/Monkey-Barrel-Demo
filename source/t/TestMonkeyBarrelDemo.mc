//
//SPDX-FileCopyrightText: 2021-2022 Wesley Schwengle <wesley@opperschaap.net>
//
//SPDX-License-Identifier: BSD-3-Clause
//
using Toybox.Test as t;

using MonkeyBarrelDemo.Demo as demo;

module MonkeyBarrelDemo {

  (:test)
    function testFoo(logger) {
      t.assertMessage(demo.foo(), "MonkeyBarrelDemo.Demo.foo() returns true");
      return true;
    }

  (:test)
    function testBar(logger) {
      t.assertEqualMessage(
        MonkeyBarrelDemo.Demo.bar(),
        false,
        "MonkeyBarrelDemo.Demo.bar() returns false"
      );
      return true;
    }
}
