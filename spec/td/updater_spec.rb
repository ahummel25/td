require 'spec_helper'
require 'td/updater'

module TreasureData::Updater

  describe 'without the TD_TOOLBELT_UPDATE_ROOT environment variable defined' do
    let :default_toolbelt_url do
      "http://toolbelt.treasuredata.com"
    end

    describe 'endpoints methods' do
      it 'use the default root path' do
        TreasureData::Updater.endpoint_root.should == default_toolbelt_url
        TreasureData::Updater.version_endpoint.should =~ Regexp.new(default_toolbelt_url)
        TreasureData::Updater.update_package_endpoint.should =~ Regexp.new(default_toolbelt_url)
      end
    end
  end

  describe 'with the TD_TOOLBELT_UPDATE_ROOT environment variable defined' do
    before do
      ENV['TD_TOOLBELT_UPDATE_ROOT'] = 'https://0.0.0.0:5000/'
    end
    describe 'endpoints methods' do
      it 'use the custom root path' do
        TreasureData::Updater.endpoint_root.should == ENV['TD_TOOLBELT_UPDATE_ROOT']
        TreasureData::Updater.version_endpoint.should =~ Regexp.new(ENV['TD_TOOLBELT_UPDATE_ROOT'])
        TreasureData::Updater.update_package_endpoint.should =~ Regexp.new(ENV['TD_TOOLBELT_UPDATE_ROOT'])
      end
    end
    after do
      ENV.delete 'TD_TOOLBELT_UPDATE_ROOT'
    end
  end
end
