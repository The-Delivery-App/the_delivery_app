Testing
=======

This section covers how the application was tested, the tools used, and how to run the tests locally.

Test Plan
---------

The test plan covers 81 test cases mapped to all user requirements (UR1--UR9.2) and non-functional requirements (NFR-1 to NFR-13). It includes:

- Code unit traceability mapping every ``.dart`` file to its test cases
- Input partition analysis with valid, invalid, and boundary cases
- Reliability and error scenarios derived from use case error cases
- Acceptance criteria for every functional and non-functional requirement

Test Methodology
----------------

Test cases were identified using four approaches:

**Spec-based testing** -- every user requirement (UR1--UR9.2) maps to at least one valid and one invalid test case.

**Input partition analysis** -- inputs are split into valid, invalid, and boundary partitions. Boundary values were derived directly from source code logic, for example the £14.99/£15.00 delivery fee threshold in ``OrderService._calculatePricing()``, and the 2 vs 3 character query length threshold in ``SearchViewModel.search()``.

**Code unit traceability** -- every non-empty ``.dart`` file across the Flutter client and Serverpod backend was mapped to at least one test case.

**Interface-based mock injection** -- every testable class depends on an injected interface (e.g. ``IBasketRepository``, ``IFoodRepository``). Tests supply hand-written fake implementations, isolating the class under test from the network and database entirely.

Test Types
----------

+-------------+---------------------------------------------------------------+
| Type        | Description                                                   |
+=============+===============================================================+
| Unit        | Tests a single class or method in isolation using fakes.      |
|             | No UI, network, or database required.                         |
+-------------+---------------------------------------------------------------+
| Widget      | Renders a screen in the Flutter test environment and checks   |
|             | font sizes, tap targets, and layout overflow.                 |
+-------------+---------------------------------------------------------------+
| Integration | Runs the full app on a real device or emulator end-to-end.    |
+-------------+---------------------------------------------------------------+
| Performance | Measures execution time against NFR thresholds using          |
|             | stopwatch timers inside integration tests.                    |
+-------------+---------------------------------------------------------------+
| Security    | Verifies passwords are hashed and JWT tokens are signed.      |
+-------------+---------------------------------------------------------------+

Test Dependencies
-----------------

The following packages are required under ``dev_dependencies`` in ``the_delivery_app_flutter/pubspec.yaml``::

    flutter_test:
      sdk: flutter
    mockito: ^5.4.4
    build_runner: ^2.4.9

Test Structure
--------------

All tests live inside ``the_delivery_app_flutter/test/``::

    test/
    ├── unit/
    │   ├── view_models/       # BasketViewModel, FeedViewModel, SearchViewModel, etc.
    │   ├── services/          # OrderService pricing and discount logic
    │   ├── repositories/      # FoodRepository, OrderRepository
    │   ├── views/             # Checkout pricing, filter/sort, reviews, favourites
    │   ├── auth/              # Authentication and JWT security tests
    │   └── placeholders/      # Skipped tests requiring emulator or real device
    └── widget_test.dart

Running the Tests
-----------------

From the ``the_delivery_app_flutter/`` directory::

    flutter test

To run a specific file::

    flutter test test/unit/view_models/basket_view_model_test.dart

Test Results
------------

Running the full suite produces the following results::

    +64 ~14: All tests passed!

- **64 tests passing** across all unit, widget, and security test files
- **14 tests skipped** -- these require a real device or emulator (integration,
  performance, and cross-platform NFR tests)
- **0 failures**

Skipped tests are documented with a reason and grouped in ``test/unit/placeholders/``.
They cover NFR-5 through NFR-13 timing and platform tests that require
``integration_test`` with a connected device to run properly.