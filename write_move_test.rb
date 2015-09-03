require_relative "test_helper"

AtomicFileOperationRunner.run("write-move") do |path, data|
  temp_path = "#{path}.temp"

  File.open(temp_path, "wb") do |file|
    file.write(data)
  end

  Benchmark.realtime do
    File.rename(temp_path, path)
  end
end

# How long is the file locked while it is being written?
