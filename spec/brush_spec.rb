require 'spec_helper'

describe Brush do
    before :each do
        @brush = Brush.new
    end

    describe "#calculate_enddate" do
        it "returns the correct end date" do
            @brush.calculate_enddate(5).should eql (Time.now() - (5 * (24 * 60 * 60))).strftime('%Y.%m.%d')
        end
    end
end
