require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ColorGenerator do
  it 'should accept a seed for the pseudorandom number generator' do
    ColorGenerator.new(:saturation => 0.3, :value => 1.0, :seed => 1).create_hex.should == 'ffc3b3'
  end

  it 'should generate a random color as a hex triplet using the HSL color representation' do
    ColorGenerator.new(:saturation => 0.3, :lightness => 0.75).create_hex.should match(/\A[0-9a-f]{6}\z/)
  end

  it 'should generate a random color as a hex triplet using the HSV color representation' do
    ColorGenerator.new(:saturation => 0.3, :value => 1.0).create_hex.should match(/\A[0-9a-f]{6}\z/)
  end

  it 'should generate a random color as a decimal triplet' do
    values = ColorGenerator.new(:saturation => 0.3, :value => 1.0).create_rgb
    values.should be_an(Array)
    values.each do |value|
      value.should >= 0
      value.should <= 255
    end
  end

  it 'should use the provided hue' do
    generator = ColorGenerator.new(:saturation => 0.3, :value => 1.0, :hue => 0.5)
    generator.create_hex.should == 'ffe9b3'
    generator.hue.should == 0.1180339887498949
  end
end
