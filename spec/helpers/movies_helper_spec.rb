require "spec_helper"

describe MoviesHelper do
 describe "odd number return" do
  it "should return odd on odd number" do
   oddness(5).should=="odd"
  end
  it "should return even on even number" do
   oddness(6).should=="even"
  end
 end
end
