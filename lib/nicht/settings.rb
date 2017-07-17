# require 'nicht/exceptions'

module Nicht
  class Settings
    FILENAME = '~/.nichtrc'.freeze

    def initialize(path)
      @path = path
    end

    def valid?
      raise Nicht::SettingsNotFound unless File.exist? @path
      projects_path = File.expand_path(File.read(@path))
      raise Nicht::SettingsNotValid unless File.exist? projects_path
      projects_path
    end
  end
end