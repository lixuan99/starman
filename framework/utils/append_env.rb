module Utils
  def append_path path
    ENV['PATH'] = "#{path}:#{ENV['PATH'].gsub(path, '') if ENV['PATH']}"
  end

  def append_ld_library_path path
    ENV[OS.ld_library_path] = "#{path}:#{ENV[OS.ld_library_path].gsub(path, '') if ENV[OS.ld_library_path]}"
  end

  def append_manpath path
    ENV['MANPATH'] = "#{path}:#{ENV['MANPATH'].gsub(path, '') if ENV['MANPATH']}"
  end
end
