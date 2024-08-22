require "test_helper"

class Tomo::Plugin::SolidQueueTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil Tomo::Plugin::SolidQueue::VERSION
  end
end
