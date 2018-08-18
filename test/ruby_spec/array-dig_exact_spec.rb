require 'minitest_helper'

describe "Array#dig_exact" do
  it "returns #at with one arg" do
    assert_equal 'a', ['a'].dig_exact(0)
    assert_nil ['a'].dig_exact(1)
  end

  it "recurses array elements" do
    a = [ [ 1, [2, '3'] ] ]
    assert_equal 1, a.dig_exact(0, 0)
    assert_equal '3', a.dig_exact(0, 1, 1)
    assert_equal 2, a.dig_exact(0, -1, 0)
  end

  it "raises without any args" do
    e = assert_raises(ArgumentError) { [10].dig_exact() }
    # jrochkind added...
    assert_match /\Awrong number of arguments/, e.message
  end

  it "calls #dig_exact on the result of #at with the remaining arguments" do
    h = [[nil, [nil, nil, 42]]]

    # We don't have the test infrastructure for should_receive
    #h[0].should_receive(:dig).with(1, 2).and_return(42)

    assert_equal 42, h.dig_exact(0, 1, 2)
  end
end