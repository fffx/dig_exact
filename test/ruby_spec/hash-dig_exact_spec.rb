require 'minitest_helper'
describe "Hash#dig_exact" do
  it "returns #[] with one arg" do
    h = { 0 => false, a: 1 }
    assert_equal(1, h.dig_exact(:a))
    assert_equal(false, h.dig_exact(0))
    assert_nil(h.dig_exact(1))
  end

  it "does recurse" do
    h = { foo: { bar: { baz: 1 } } }
    assert_equal(1, h.dig(:foo, :bar, :baz))
    assert_nil h.dig_exact(:foo, :bar, :nope)
    assert_nil h.dig_exact(:foo, :baz)
    assert_nil h.dig_exact(:bar, :baz, :foo)
  end

  it "raises without args" do
    assert_raises(ArgumentError) { { the: 'borg' }.dig_exact() }
  end

  it "handles type-mixed deep digging" do
    h = {}
    h[:foo] = [ { bar: [ 1 ] }, [ obj = Object.new, 'str' ] ]
    def obj.dig_exact(*args); [ 42 ] end

    assert_equal([1], h.dig_exact(:foo, 0, :bar))
    assert_equal(1, h.dig_exact(:foo, 0, :bar, 0))
    assert_equal 'str', h.dig_exact(:foo, 1, 1)
    # MRI does not recurse values returned from `obj.dig_exact`
    assert_equal [42], h.dig_exact(:foo, 1, 0, 0)
    assert_equal [42], h.dig_exact(:foo, 1, 0, 0, 10)
  end

  it "raises ni if an intermediate element does not respond to #dig_exact" do
    h = {}
    h[:foo] = [ { bar: [ 1 ] }, [ nil, 'str' ] ]
    assert_nil h.dig_exact(:foo, 0, :bar, 0, 0)
    assert_nil h.dig_exact(:foo, 1, 1, 0)
  end

  it "calls #dig_exact on the result of #[] with the remaining arguments" do
    h = { foo: { bar: { baz: 42 } } }

    #TODO? EH??
    # h[:foo].should_receive(:dig_exact).with(:bar, :baz).and_return(42)

    assert_equal 42, h.dig_exact(:foo, :bar, :baz)
  end

end