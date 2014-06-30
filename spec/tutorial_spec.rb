require_relative 'spec_helper'

#noinspection RubyStringKeysInHashInspection
describe Appium::Tutorial do
  attr_reader :tutorial_root, :tutorial, :first_module_gen

  def expect_gen_exists boolean
    exists = exist? first_module_gen
    expect(exists).to eq(boolean)
  end

  def expect_html_exists boolean
    exists = exist? join first_module_gen, 'html'
    expect(exists).to eq(boolean)
  end

  def expect_markdown_exists boolean
    exists = exist? join first_module_gen, 'appium'
    expect(exists).to eq(boolean)
  end

  def delete_tutorial_path
    root = dirname tutorial_root
    path    = tutorial.tutorial_path
    message = "Tutorial path #{path} must include #{root}"
    raise message unless path.include? root
    rm_rf path if exist? path

    expect_tutorial_path_exists false
  end

  def expect_tutorial_path_exists boolean
    exists = exist? tutorial.tutorial_path
    expect(exists).to eq(boolean)
  end

  def delete_gen
    tutorial.delete_gen
    expect_gen_exists false
  end

  before do
    @tutorial_root    = join(Dir.pwd, 'modules')
    @tutorial         = Appium::Tutorial.new tutorial_root: tutorial_root
    @first_module_gen = tutorial.modules.map { |m| m.modules_gen_path }.first
  end

  it 'detects tutorials with language' do
    actual   = tutorial.tutorials
    expected = [ 'en' ]

    expect(actual).to eq(expected)
  end

  it 'populates a module with correct paths' do
    modules     = tutorial.modules
    module_path = join tutorial_root, 'en'

    actual   = modules.map { |m| m.module_root }.first
    expected = module_path
    expect(actual).to eq(expected)

    actual   = modules.map { |m| m.modules_gen_path }.first
    expected = join(module_path, 'gen')
    expect(actual).to eq(expected)

    actual   = modules.map { |m| m.modules_source_path }.first
    expected = join(module_path, 'source')
    expect(actual).to eq(expected)
  end

  it 'generates html' do
    delete_gen

    tutorial.generate_markdown
    tutorial.generate_html

    expect_gen_exists true
    expect_markdown_exists true
    expect_html_exists true
  end

  it 'generates markdown' do
    delete_gen
    tutorial.generate_markdown

    expect_gen_exists true
    expect_markdown_exists true
    expect_html_exists false
  end

  it 'deletes the generated folder' do
    mkdir_p first_module_gen unless exist? first_module_gen
    expect_gen_exists true

    tutorial.delete_gen
    expect_gen_exists false
  end

  it 'lists contents' do
    list = tutorial.list_contents

    expected_modules = 1 * 2 # name/list per module
    expect(list.length).to eq(expected_modules)

    first_module_name = list.first
    expect(first_module_name).to eq(":: /en\n")

    first_module_contents = list[1]
    expect(first_module_contents.length).to be >= 20
  end

  it 'publishes to the tutorial path' do
    delete_tutorial_path

    tutorial.publish

    expect_tutorial_path_exists true
    delete_tutorial_path
  end
end