require 'spec_helper'

describe Brush do
    before :each do
        @brush = Brush.new
        @testtime = Time.new(2013, 11, 9, 22, 40, 17)
    end

    describe "#calculate_enddate" do
        it "returns the correct end date" do
            @brush.calculate_enddate(5, @testtime).should eql "2013.11.04"
        end
    end

    describe "#calculate_epochms" do
        it "returns epoch time in milliseconds minus hours" do
            @brush.calculate_epochms(3, 'hours', @testtime).should eql 1384022417000
        end
    end

    describe "#purgeable_indices" do
        it "returns logstash indices to purge" do
            indices_in =  [ 'logstash-2013.11.02', 'logstash-2013.11.03',
                            'logstash-2013.11.04', 'logstash-2013.11.05',
                            'logstash-2013.11.06', 'logstash-2013.11.07',
                            'logstash-2013.11.08', 'logstash-2013.11.09' ]

            indices_out = [ 'logstash-2013.11.02', 'logstash-2013.11.03',
                            'logstash-2013.11.04', 'logstash-2013.11.05' ]

            @brush.purgeable_indices(4, indices_in, @testtime).should eql indices_out
        end
    end
end
