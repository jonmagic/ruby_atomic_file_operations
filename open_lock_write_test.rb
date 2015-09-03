require_relative "test_helper"

AtomicFileOperationRunner.run("open-lock-write") do |path, data|
  Benchmark.realtime do
    File.open(path, File::CREAT|File::RDWR) do |file|
      file.flock(File::LOCK_EX)
      file.rewind
      file.write(data)
      file.truncate(file.pos)
    end
  end
end

# How long is the file locked while it is being written?
