require 'active_support/core_ext'
require 'fileutils'

require_relative'gui/patches.rb'
require_relative'gui/server.rb'

include Rake::DSL

module Rake::Gui
  GUI_ID_LENGTH = 16

  extend self

  @@active = false
  @@id = rand(36**GUI_ID_LENGTH).to_s(36)
  @@data_directory = File.join('/tmp', 'rakeg')

  def id
    @@id
  end

  def activate
    FileUtils::mkdir_p working_directory
    @@active = true
  end

  def deactivate
    @@active = false
  end

  def active?
    @@active
  end

  def data_directory
    @@data_directory
  end

  def data_directory=(path)
    FileUtils::mkdir_p path
    @@data_directory = path
  end

  def working_directory
    File.join(@@data_directory, @@id)
  end

  def start_server
    Rake::Gui::Server.new(working_directory)
  end
end
