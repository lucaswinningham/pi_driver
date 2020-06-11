# frozen_string_literal: true

require 'pi_driver/file_system'

RSpec.describe PiDriver::FileSystem do
  before(:all) do
    @test_filepath = File.expand_path(
      File.join(RSpec.project_root, 'tmp/spec/file_system_spec_file')
    )

    dir, = File.split @test_filepath
    FileUtils.mkdir_p dir
    FileUtils.touch @test_filepath
  end

  after(:all) { FileUtils.rm @test_filepath }

  let(:test_filepath) { @test_filepath }

  before { File.open(test_filepath, File::TRUNC) { |file| file.flock File::LOCK_EX } }

  describe '::read_file' do
    it 'reads contents from a file' do
      contents = 'contents'
      File.open(test_filepath, 'w') { |file| file.write contents }
      expect(subject.read_file(test_filepath).chomp).to eq contents
    end

    it 'passes mode to File::open' do
      mode = File::CREAT | File::EXCL
      expect { subject.read_file(test_filepath, mode: mode) }.to(
        raise_error(Errno::EEXIST)
      )
    end
  end

  describe '::write_file' do
    it 'writes contents to a file' do
      contents = 'contents'
      expect { subject.write_file(test_filepath, contents: contents) }.to(
        change { File.read(test_filepath) }.to(contents)
      )
    end

    it 'passes mode to File::open' do
      mode = File::CREAT | File::EXCL
      expect { subject.write_file(test_filepath, contents: '', mode: mode) }.to(
        raise_error(Errno::EEXIST)
      )
    end

    it 'provides a callback for when writing is finished' do
      callback_called = false
      subject.write_file(test_filepath, contents: '') { callback_called = true }

      expect(callback_called).to be true
    end
  end

  describe '::on_file_change' do
    it 'listens to file change'
    # it 'listens to file change and calls callback with file' do
    #   contents = 'contents'
    #   callback_called = false

    #   subject.on_file_change(test_filepath) do |file|
    #     file.flock File::LOCK_EX
    #     expect(file.read.chomp).to eq contents
    #     callback_called = true
    #   end

    #   File.write(test_filepath, contents)

    #   expect(callback_called).to be true
    # end
  end

  describe '::dir' do
    it { expect(subject.dir).to be PiDriver::FileSystem::Dir }
  end
end
