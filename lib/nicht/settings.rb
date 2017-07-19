module Nicht
  class Settings
    FILENAME = '~/.nichtrc'.freeze

    def initialize(path)
      @path = File.expand_path path
    end

    def get_path
      raise Nicht::SettingsNotFound unless File.exist? @path
      projects_path = File.expand_path(File.read(@path))
      raise Nicht::SettingsNotValid unless File.exist? projects_path
      projects_path
    end
  end
end