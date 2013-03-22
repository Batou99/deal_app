require 'spec_helper'
require File.dirname(__FILE__) + '/../../lib/support/loaders'

describe "Loaders" do
  let(:data) { fixture_path + '/daily_planet_export.txt' }
  let(:lines) { IO.readlines(data).map { |line| line.gsub(/\n$/,"") } }

  describe Importer::Loader do
    let(:loader) { Importer::Loader.new(/(.*)/) }

    it "should complain if no group captures" do
      expect { Importer::Loader.new(/Hi/) }.to raise_error
    end

    it "should detect the number of captures" do
      Importer::Loader.new(/(Hi)/).instance_eval("@num_of_group_captures").should == 1
      Importer::Loader.new(/(Hi)(There)/).instance_eval("@num_of_group_captures").should == 2
      Importer::Loader.new(/(Hi)(There) Nope (Again)/).instance_eval("@num_of_group_captures").should == 3
    end

  end

  describe Importer::DailyPlanetLoader do
    let(:daily_loader) { Importer::DailyPlanetLoader.new }

    before(:each) do
      daily_loader.parse_file(data,true)
    end

    it "should create a publisher" do
      Publisher.count.should == 1
    end

    it "should not create duplicate publishers" do
      daily_loader.parse_file(data,true)
      Publisher.count.should == 1
    end

    it "should create advertisers" do
      Advertiser.count.should == 3
    end

    it "should not duplicate advertisers" do
      daily_loader.parse_file(data,true)
      Advertiser.count.should == 3
    end

    it "should link advertisers with the publisher" do
      Advertiser.all.each { |adv|  
        adv.publisher.should == Publisher.first
      }
    end

    it "should create deals" do
      Deal.count.should == 2
    end

    it "should not duplicate deals" do
      daily_loader.parse_file(data,true)
      Deal.count.should == 2
    end
  end
end
