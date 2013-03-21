require File.dirname(__FILE__) + '/../../lib/support/loaders'

def path(filename)
  File.dirname(__FILE__) + "/../fixtures/#{filename}"
end

describe Importer::Loader do
  let(:data) { path('daily_planet_export.txt') }
  let(:lines) { IO.readlines(data) }

  it "should complain if no group captures" do
    expect { Importer::Loader.new(/Hi/) }.to raise_error
  end

  it "should detect the number of captures" do
    Importer::Loader.new(/(Hi)/).instance_eval("@num_of_group_captures").should == 1
    Importer::Loader.new(/(Hi)(There)/).instance_eval("@num_of_group_captures").should == 2
    Importer::Loader.new(/(Hi)(There) Nope (Again)/).instance_eval("@num_of_group_captures").should == 3
  end

  it "should pass lines with header to import" do
    # This capture does not modify the lines
    loader = Importer::Loader.new(/(.*)/)
    loader.should_receive(:import).with(lines)
    loader.parse_file(data)
  end

  it "should remove header it told to" do
    loader = Importer::Loader.new(/(.*)/)
    loader.should_receive(:import).with(lines[1..-1])
    loader.parse_file(data,true)
  end
end

describe Importer::DailyPlanetLoader do
  let(:data) { path('daily_planet_export.txt') }
  let(:lines) { IO.readlines(data) }
  let(:daily_loader) { Importer::DailyPlanetLoader.new }



end
