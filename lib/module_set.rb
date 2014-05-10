require_relative 'support/requires'

=begin
Sample module set en/1.0.0 that contains one module
named `01_native_ios_automation`

.
└── modules
    └── en
        └── 1.0.0
            ├── gen
            │   └── appium
            │       └── 01_native_ios_automation
            │           ├── 01_getting_started_with_appium
            │           ├── 02_appium_ruby_console
            │           ├── 03_writing_your_first_test
            │           ├── 04_running_tests
            │           └── 05_conclusion
            └── source
                ├── appium
                │   └── 01_native_ios_automation
                │       ├── 01_getting_started_with_appium
                │       ├── 02_appium_ruby_console
                │       ├── 03_writing_your_first_test
                │       ├── 04_running_tests
                │       └── 05_conclusion
                ├── common
                │   ├── css
                │   └── font-awesome-4.0.3
                │       ├── css
                │       └── fonts
                └── java_android
                    └── src
=end
module Appium
  class ModuleSet
    include Appium::Helpers
    attr_reader :module_root, :modules_gen_path, :modules_source_path,
                :tutorial_root, :name

    def initialize opts={}
      _init_module_root opts[:module_root]
      _init_tutorial_root opts[:tutorial_root]

      @name = module_root.gsub tutorial_root, ''

      @modules_gen_path    = join module_root, 'gen'
      @modules_source_path = join module_root, 'source'
    end

    # must call first in initialize before using module_root
    # @private
    def _init_module_root module_root
      @module_root = expand_path module_root if module_root
      if @module_root.nil? || @module_root.empty? || !directory?(@module_root)
        raise "Module root directory must be set. Invalid value: #{@module_root}"
      end
    end

    # @private
    def _init_tutorial_root tutorial_root
      @tutorial_root = expand_path tutorial_root if tutorial_root
      if @tutorial_root.nil? || @tutorial_root.empty? || !directory?(@tutorial_root)
        raise "Tutorial root directory must be set. Invalid value: #{@tutorial_root}"
      end
    end

    def common_exists file_path, file
      path = join modules_source_path, file

      return false unless file[0] == '/' && extname(file) == '.md'

      exists?(path) ? path : exit_with("Invalid local include\n#{file_path}\n\nlinks to\n\n#{file}\n#{path}")
    end

    # TODO: Write tests
    # valid on disk file should be replaced
    # invalid non-local file should remain the same
    def process_include file_path, markdown
      # replace standard markdown link with file content
      # if it matches an on disk file.
      markdown.gsub(/!?\[[^\[]*\]\(([^)]+)\)/m) do |full|
        result = nil

        if $1[0] == '/' && extname($1) == '.png'
          result = "![](#{basename($1)})"
        end

        path   = common_exists file_path, $1
        result ||= path ? "\n" + process_include("nested #{file_path}", File.read(path)) + "\n" : full
        result
      end
    end

    # process all include tags contained within the markdown
    def generate_markdown
      src_path = join modules_source_path, 'appium', '**', '*.md'

      Dir.glob(src_path) do |md|
        new_path = join(modules_gen_path, md.gsub(modules_source_path, ''))
        mkdir_p dirname new_path # ensure full path exists
        data = process_include(md, File.read(md))
        File.open(new_path, 'w') { |f| f.write data }
      end
    end

    def all_modules path
      modules_root = join path, 'appium'
      Dir.glob(join(modules_root, '*')).select { |path| directory? path }
    end

    def chapters_in_module section_root # chapters
      Dir.glob(join(section_root, '*')).select { |path| directory? path }
    end

    def lessons_in_chapter chapter_root
      Dir.glob(join(chapter_root, '*')).select { |path| file? path }
    end

    def generate_html
      base_dest = join modules_gen_path, 'html'

      # glob each section into one html file
      all_modules(modules_gen_path).each do |module_root|
        data = "\n"
        chapters_in_module(module_root).each do |chapter|
          lessons_in_chapter(chapter).each do |lesson|
            data += "\n" + File.read(lesson) + "\n\n"
          end
        end
        data = data + "\n"

        html      = wrap_html markup.render_default "[[_TOC_]]\n" + data
        html_path = join(base_dest, basename_no_ext(module_root) + '.html')
        mkdir_p dirname html_path
        File.open(html_path, 'w') { |f| f.write html }

        # all in one markdown file used for Slate
        markdown_path = join(base_dest, basename_no_ext(module_root) + '.md')
        prefix = <<PREFIX
---
title: Tutorial
search: false

language_tabs:
  - ruby: Ruby
  - java: Java
---

PREFIX
        # remove empty space from code blocks
        data.gsub!("<code>\n", "<code>")
        File.open(markdown_path, 'w') { |f| f.write prefix + data.strip }
      end

      # copy images
      common_path = join modules_source_path, 'common', '**', '*.png'
      Dir.glob(common_path) { |img| copy img, base_dest }
    end

    def delete_gen
      rm_rf modules_gen_path
    end

    def list_contents
      def get_number path
        basename(path).match(/^\d+/).to_s
      end

      numbers = []

      all_modules(modules_source_path).each do |_module|
        module_number = get_number _module
        chapters_in_module(_module).each do |chapter|
          chapter_number = get_number chapter
          lessons_in_chapter(chapter).each do |lesson|
            lesson_number = get_number lesson
            numbers << [module_number, chapter_number, lesson_number].join('.')
          end
        end
      end

      numbers
    end

    def publish publish_temp_path
      delete_gen
      generate_markdown
      generate_html

      # random, en/1.0.0
      publish_temp_path = join publish_temp_path, name
      mkdir_p publish_temp_path

      html_path = join modules_gen_path, 'html'
      copy_entry html_path, publish_temp_path
    end
  end
end