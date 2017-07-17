require 'awesome_print'

module Nicht
  class Stats
    def initialize(path, search = nil)
      @path = path + '/Gemfile'
      @search = search
      @stats = { per_project: {}, per_gem: {} }
    end

    def render
      Dir[@path].each do |path|
        scan_project path
      end
      output
    end

    private
    
    def scan_record(line, project_name)
      candidate = line.split(',').shift.split ' '
      gem_name = candidate.last
      return unless candidate.first == 'gem' || %w[* #].include?(gem_name[0])
      add_stat(gem_name, project_name)
    end

    def add_stat(gem_name, project_name)
      gem_name.delete!('\'')
      gem_name.delete!('"')
      @stats[:per_project][project_name] << gem_name
      @stats[:per_gem][gem_name] ||= []
      @stats[:per_gem][gem_name] << project_name
    end

    def scan_project(path)
      project_name = path.split('/')
      project_name = project_name[project_name.size - 2]
      File.open(path, 'r') do |f|
        @stats[:per_project][project_name] = []
        f.each_line do |line|
          scan_record(line, project_name)
        end
      end
    end

    def output
      if @search.nil?
        ap @stats[:per_project]
      else
        dump_gems = @stats[:per_gem][@search] ? @stats[:per_gem][@search] : @stats[:per_gem].select { |k, v| k.include? @search }
        if dump_gems.empty?
          puts "No matches found for '#{@search}'"
        else
          ap dump_gems
        end
      end
    end
  end
end