require 'rubygems'
require 'bundler/setup'
require "benchmark"
require "fileutils"
require "pathname"
require "posix/spawn"

class AtomicFileOperationRunner
  def self.run(test_name, &block)
    new(test_name, &block).run
  end

  TEST_SIZES = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512]

  def initialize(test_name, &block)
    @test_name = test_name
    @block = block
    @path = Pathname(File.expand_path(File.dirname(__FILE__)))
  end

  attr_reader :test_name, :block, :path

  def run
    setup
    csv_path = "#{test_name}-results.csv"

    File.open(csv_path, "wb") do |file|
      file.write("test_name,MB,ms")

      TEST_SIZES.each do |mb|
        path = fixture_path(mb)
        data = File.read(path)
        GC.start(full_mark: true, immediate_sweep: true)

        realtime = block.call(path, data)

        file.write("\n#{test_name},#{mb},#{(realtime*1000).round}")
      end
    end

    puts csv_path
    teardown
  end

  def fixture_path(mb)
    path.join("tmp", "#{mb}.fixture")
  end

  def setup
    FileUtils.mkdir_p(path.join("tmp"))

    TEST_SIZES.each do |mb|
      of = "of=#{fixture_path(mb)}"
      bs = "bs=#{mb}m"
      child = POSIX::Spawn::Child.new("dd", "if=/dev/zero", of, bs, "count=1")
    end
  end

  def teardown
    FileUtils.rm_rf(path.join("tmp"))
  end
end
