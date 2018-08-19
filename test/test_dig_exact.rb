require 'minitest_helper'

class TestDigRb < Minitest::Test


  # https://github.com/ruby/ruby/blob/a837be87fdf580ac4fd58c4cb2f1ee16bab11b99/test/ruby/test_array.rb#L2655
  def test_array
    h = Array[Array[{a: 1}], 0]
    assert_equal(1, h.dig_exact(0, 0, :a))
    assert_nil h.dig_exact(2, 0)

    # return nil if value not respond_to :dig_exact
    assert_nil h.dig_exact(1, 0)
  end

  def test_array_examples
    a = [[1, [2, 3]]]
    assert_equal(3, a.dig_exact(0, 1, 1))
    assert_nil a.dig_exact(1, 2, 3)

    assert_nil a.dig_exact(0, 0, 0)

    assert_equal(:bar, [42, {foo: :bar}].dig_exact(1, :foo))
  end

  def test_hash
    h = Hash[a: Hash[b: [1, 2, 3]], c: 4]
    assert_equal(1, h.dig_exact(:a, :b, 0))
    assert_nil(h.dig_exact(:b, 1))
    assert_nil h.dig_exact(:c, 1)
    o = Object.new
    def o.dig_exact(*args)
      {dug: args}
    end
    h[:d] = o
    assert_equal({dug: [:foo, :bar]}, h.dig_exact(:d, :foo, :bar))
  end

  def test_hash_examples
    h = { foo: {bar: {baz: 1}}}
    assert_equal(1, h.dig_exact(:foo, :bar, :baz))
    assert_nil(h.dig_exact(:foo, :zot, :xyz))

    g = { foo: [10, 11, 12] }
    assert_equal(11,  g.dig_exact(:foo, 1))
  end

  def test_struct
    klass = Struct.new(:a)
    o = klass.new(klass.new({b: [1, 2, 3]}))
    assert_equal(1, o.dig_exact(:a, :a, :b, 0))
    assert_nil(o.dig_exact(:b, 0))
  end

  def test_struct_examples
    klass = Struct.new(:a)
    o = klass.new(klass.new({b: [1, 2, 3]}))

    assert_equal(1, o.dig_exact(:a, :a, :b, 0))
    assert_nil(o.dig_exact(:b, 0))
  end

  # Not covered by any tests, but actual behavior.
  # https://github.com/jrochkind/dig_rb/issues/5
  def test_struct_supports_array_access
    klass = Struct.new(:a, :b)
    o = klass.new(:first, :second)

    assert_equal(:second, o.dig_exact(1))
    assert_nil(o.dig_exact(2))

    assert_raises(TypeError) { o.dig_exact(Object.new) }
  end

  def test_ostruct
    os1 = OpenStruct.new
    os2 = OpenStruct.new
    os1.child = os2
    os2.foo = :bar
    os2.child = [42]
    assert_equal :bar, os1.dig_exact("child", :foo)
    assert_nil os1.dig_exact("parent", :foo)

    e = assert_raises(TypeError) { os1.dig_exact("child", 0) }
    # tested in 2.3.0:
    assert_equal("0 is not a symbol nor a string", e.message)
  end

  def test_ostruct_examples
    address = OpenStruct.new('city' => "Anytown NC", 'zip' => 12345)
    person = OpenStruct.new('name' => 'John Smith', 'address' => address)

    assert_equal(12345, person.dig_exact(:address, 'zip'))
    assert_nil(person.dig_exact(:business_address, 'zip'))


  end


end
