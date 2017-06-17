def run_specs_in_directory(dir_path)

  dir_contents = Dir["#{dir_path}*"]
  dir_contents.each() do |file|
    system("ruby #{file}") if file[-3..-1] == ".rb"

    is_dir = File.directory?(file)
    run_specs_in_directory(file) if is_dir
  end

end

def run()
  # print "Enter a directory containing ruby files to run: "
  # path = gets.chomp
  #
  # path += "/" if path[path.length-1] != "/"

  path = "./"
  is_dir = File.directory?(path)
  run_specs_in_directory(path) if is_dir
  puts "Error, input is not a valid directory." if !is_dir
end

run()
