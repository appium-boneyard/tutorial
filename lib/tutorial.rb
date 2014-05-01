require_relative 'support/requires'

# Every module is considered to be part of the tutorial
module Appium
  class Tutorial
    include Appium::Helpers

    attr_reader :tutorial_root, :tutorials, :modules, :tutorial_path
=begin
  The following directory layout is expected

    tutorial
    └── modules
        └── en
            ├── gen
            └── source

  Modules is the tutorial root.
  en is the language code for english.
  gen contains all the generated files. These are ignored by git on the master branch.
    The generated files are published to the gh-pages branch.
  source contains all the source material such as markdown and example code.

  tutorial/modules/en/1.0.0/ - This is an example path to a module set

  opts - Hash of options
    tutorial_root - must be set. The root folder containing all tutorials
=end
    def initialize opts={}
      _init_tutorial_root opts[:tutorial_root]
      # keep tutorial output outside of modules folder.
      @tutorial_path = join tutorial_root, '..', 'tutorials'

      _init_modules
      populate_modules
    end

    # @private
    def _init_tutorial_root tutorial_root
      @tutorial_root = expand_path tutorial_root if tutorial_root
      if @tutorial_root.nil? || @tutorial_root.empty? || !directory?(@tutorial_root)
        raise "Tutorial root directory must be set. Invalid value: #{@tutorial_root}"
      end
    end

    # @private
    # must _init_tutorial_root before updating modules
    def _init_modules
      #  { language: ['1.0.0', '1.2.0'] }
      @tutorials    = []
      language_glob = join @tutorial_root, '*'
      Dir.glob(language_glob) do |language_path|
        next unless directory? language_path

        language = basename language_path

        @tutorials << language
      end
    end

    def populate_modules
      @modules = []
      @tutorials.each do |language|
        module_root = join tutorial_root, language
        @modules << Appium::ModuleSet.new(tutorial_root: tutorial_root, module_root: module_root)
      end

      @modules
    end

    def all_modules method_name, *args
      @modules.each { |m| m.send method_name, *args }
      nil
    end

    #
    # Rake tasks
    #

    def generate_html
      all_modules :generate_html
    end

    def generate_markdown
      all_modules :generate_markdown
    end

    def delete_gen
      all_modules :delete_gen
    end

    def list_contents
      results = []
      @modules.each do |m|
        results << ":: #{m.name}\n"
        results << m.list_contents
      end
      results
    end

    def _publish tmpdir
      all_modules :publish, tmpdir
    end

    def publish
      rm_rf tutorial_path
      mkdir_p tutorial_path

      puts "Publishing to: #{tutorial_path}"
      _publish tutorial_path # all modules are now in tutorial_path

      # copy css for entire tutorial (all modules)
      # copy font awesome + css
      css = join tutorial_root, '..', 'css'
      copy_entry css, join(tutorial_path, 'css')
    end
  end
end