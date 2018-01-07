require "nicht/exceptions"
require "nicht/settings"
require "nicht/stats"
require "nicht/version"

module Nicht
  class << self
    def run(path, search = nil)
      settings = Nicht::Settings.new path
      begin
        projects_path = settings.get_path
      rescue Nicht::SettingsNotFound
        puts "Settings not found. You should create .nichtrc with settings in your home directory."
      rescue Nicht::SettingsNotValid
        puts "Settings are not valid."
      else
        render_results(projects_path, search)
      end
    end

    def render_results(projects_path, search)
      stats = Nicht::Stats.new projects_path, search
      stats.render
    end
  end
end
