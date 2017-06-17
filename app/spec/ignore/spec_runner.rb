def run_specs_in_directory(dir_path)

  dir_contents = Dir["#{dir_path}/*"]
  dir_contents.each() do |file|
    # Store this in a file named igore so it does not call itself
    next if(file.scan(/ignore$/).length == 1)

    system("ruby #{file}") if file[-3..-1] == ".rb"

    is_dir = File.directory?(file)
    run_specs_in_directory(file) if is_dir
  end

end

# The given directory starts from the loction this file was run from
# not where it is located.
def run()
  print "Enter a directory containing ruby files to run: "
  path = gets.chomp

  path = path[0..-2] if path[-1] == "/"

  is_dir = File.directory?(path)
  run_specs_in_directory(path) if is_dir
  puts "Error, input is not a valid directory." if !is_dir
end

run()
