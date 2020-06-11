# frozen_string_literal: true

require 'pi_driver/cpu_info'

RSpec.describe PiDriver::CPUInfo do
  before(:all) do
    @test_cpu_info_filepath = File.expand_path(
      File.join(RSpec.project_root, 'tmp/spec/cpu_info')
    )

    @test_hardware = 'BCM2709'
    @test_revision = 'a02082'

    dir, = File.split @test_cpu_info_filepath
    FileUtils.mkdir_p dir
    FileUtils.touch @test_cpu_info_filepath

    cpu_info = <<~TXT
      Hardware  : #{@test_hardware}
      Revision  : #{@test_revision}
    TXT

    File.write(@test_cpu_info_filepath, cpu_info)
  end

  after(:all) { FileUtils.rm @test_cpu_info_filepath }

  let(:test_cpu_info_filepath) { @test_cpu_info_filepath }
  let(:test_hardware) { @test_hardware }
  let(:test_revision) { @test_revision }

  let(:default_cpu_info_filepath) { '/proc/cpu_info' }

  let(:mock_cpu_info) { subject.cpu_info_filepath = test_cpu_info_filepath }

  after { subject.reset }

  describe '::DEFAULT_CPU_INFO_FILEPATH' do
    it { expect(subject::DEFAULT_CPU_INFO_FILEPATH).to eq default_cpu_info_filepath }
  end

  describe '::reset' do
    it 'resets ::cpu_info_filepath' do
      default = subject.cpu_info_filepath
      custom = '/foo/cpu_info'
      subject.cpu_info_filepath = custom

      expect { subject.reset }.to change { subject.cpu_info_filepath }.from(custom).to(default)
    end

    it 'resets ::hardware' do
      mock_cpu_info

      default = subject.hardware
      custom = 'FOO8080'
      subject.hardware = custom

      expect { subject.reset }.to change { subject.hardware }.from(custom).to(default)
    end

    it 'resets ::revision' do
      mock_cpu_info

      default = subject.revision
      custom = 'afoo1'
      subject.revision = custom

      expect { subject.reset }.to change { subject.revision }.from(custom.to_i(16)).to(default)
    end
  end

  describe '::cpu_info_filepath' do
    it 'defaults to rpi cpu_info filepath' do
      expect(subject.cpu_info_filepath).to eq default_cpu_info_filepath
    end

    it 'is writeable' do
      custom_cpu_info_filepath = '/bar/cpu_info'
      subject.cpu_info_filepath = custom_cpu_info_filepath
      expect(subject.cpu_info_filepath).to eq custom_cpu_info_filepath
    end
  end

  describe '::hardware' do
    context 'with custom cpu_info_filepath' do
      before { mock_cpu_info }

      it 'gives the hardware defined in the cpu_info file' do
        expect(subject.hardware).to eq test_hardware
      end
    end

    it 'is writeable' do
      custom_hardware = 'BAR1776'
      subject.hardware = custom_hardware
      expect(subject.hardware).to eq custom_hardware
    end
  end

  describe '::revision' do
    context 'with custom cpu_info_filepath' do
      before { mock_cpu_info }

      it 'gives the revision defined in the cpu_info file' do
        expect(subject.revision).to eq test_revision.to_i(16)
      end
    end
  end

  describe '::revision=' do
    it 'converts given revision to hexedecimal number' do
      custom_revision = '9020e0'
      subject.revision = custom_revision
      expect(subject.revision).to eq custom_revision.to_i(16)
    end
  end
end
