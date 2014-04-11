module Appium
  module Helpers
    #
    # File/FileUtils wrapper methods
    #

    # File.exist?
    def exist? *args
      File.exist? *args
    end

    # File.exists?
    def exists? *args
      File.exists? *args
    end

    # File.dirname
    def dirname *args
      File.dirname *args
    end

    # File.basename
    def basename *args
      File.basename *args
    end

    # File.basename path, '.*'
    #
    # Basename with ext removed
    #
    # File.basename('/a/b/c.txt', '.*')
    # => "c"
    def basename_no_ext path
      File.basename path, '.*'
    end

    # File.extname(path).downcase
    def extname *args
      File.extname(*args).downcase
    end

    # File.expand_path
    def expand_path *args
      File.expand_path *args
    end

    # File.file?
    def file? *args
      File.file? *args
    end

    # File.directory?
    def directory? *args
      File.directory? *args
    end

    # FileUtils.mkdir_p
    def mkdir_p *args
      FileUtils.mkdir_p *args
    end

    # FileUtils.rm_rf
    def rm_rf *args
      FileUtils.rm_rf *args
    end

    # FileUtils.copy
    def copy *args
      FileUtils.copy *args
    end

    # FileUtils.copy_entry
    def copy_entry *args
      FileUtils.copy_entry *args
    end

    # File.expand_path File.join
    #
    # Always expand path after joining or the paths may not be valid.
    # Deleting an unexpanded path will fail for example.
    def join *paths
      File.expand_path File.join(*paths)
    end
  end
end