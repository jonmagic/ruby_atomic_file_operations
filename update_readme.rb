require "csv2md"

File.open("README.md", "w") do |file|
  readme = ["# Atomic file operations in Ruby"]

  readme << "This is just a quick experiment to see how long it takes to do [atomic](https://en.wikipedia.org/wiki/Atomicity_(database_systems)) file operations in Ruby."
  readme << "## Running the experiment"
  readme << "```bash\n$ rake\n```"
  readme << "## Results"

  Dir["*.csv"].each do |file_name|
    csv2md = Csv2md.new(File.read(file_name))
    readme << "### #{file_name}"
    readme << csv2md.gfm
  end

  file.write(readme.join("\n\n"))
end
