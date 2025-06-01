setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$DIR/../src:$PATH"
}

@test "Check welcome message" {
    run example.sh
    assert_output --partial 'Welcome to our project!'
}

@test "Show welcome message on first invocation" {
    run example.sh
    assert_output --partial 'Welcome to our project!'

    run example.sh
    refute_output --partial 'Welcome to our project!'
}

teardown() {
    rm -f /tmp/bats-tutorial-project-ran
}

