def add_to_file(file, after, content)
  contents = IO.read(file)
  contents.sub! after, "\\1\n#{content}\n"
  File.open(file, 'w') { |file| file.write(contents) }
end
