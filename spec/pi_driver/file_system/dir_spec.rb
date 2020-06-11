# frozen_string_literal: true

require 'pi_driver/file_system/dir'

RSpec.describe PiDriver::FileSystem::Dir do
  let(:default_sysfs) { '/sys/class' }

  after { subject.reset }

  describe '::DEFAULT_SYSFS' do
    it { expect(subject::DEFAULT_SYSFS).to eq default_sysfs }
  end

  describe '::reset' do
    it 'resets ::sysfs' do
      default = subject.sysfs
      custom = '/foo'
      subject.sysfs = custom

      expect { subject.reset }.to change { subject.sysfs }.from(custom).to(default)
    end
  end

  describe '::sysfs' do
    it 'defaults to rpi gpio sysfs dir' do
      expect(subject.sysfs).to eq default_sysfs
    end

    it 'is writeable' do
      custom_sysfs = '/bar'
      subject.sysfs = custom_sysfs
      expect(subject.sysfs).to eq custom_sysfs
    end
  end

  describe '::gpio' do
    it 'is sysfs + /gpio' do
      expect(subject.gpio).to eq "#{default_sysfs}/gpio"

      custom_sysfs = '/baz'
      subject.sysfs = custom_sysfs
      expect(subject.gpio).to eq "#{custom_sysfs}/gpio"
    end
  end

  describe '::project_root' do
    it 'is project root' do
      expect(subject.project_root).to eq RSpec.project_root
    end
  end
end
