require 'spec_helper'

RSpec.describe Nicht do
  it 'has a version number' do
    expect(Nicht::VERSION).not_to be nil
  end

  it 'has a settings file name' do
    expect(Nicht::Settings::FILENAME).not_to be nil
  end

  describe 'read .nichtrc for projects path' do
    context 'settings not exist' do
      let(:not_existing_path) { build_path '.not_existing_file' }
      let(:result) { Nicht.run not_existing_path }

      it 'show message that settings not exist' do
        expect { result }.to output(/Settings not found. You should create .nichrc with settings in your home directory./).to_stdout
      end
    end

    context 'settings doesn\'t contain valid path' do
      let(:empty_file) { build_path '.not_valid_file' }
      let(:result) { Nicht.run empty_file }

      it 'show message that path invalid' do
        expect { result }.to output(/Settings are not valid./).to_stdout
      end
    end

    context 'with valid path' do
      let(:settings) { build_path '.nichtrc' }
      let(:result) { Nicht.run settings, 'sinatra' }

      it 'render stats' do
        expect { result }.to output(/sinatra/).to_stdout
      end
    end
  end

  private

  def build_path(path)
    [File.expand_path('../support/settings', __FILE__), path].join '/'
  end
end
