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
        context "default index_format" do
            it "returns logstash indices to purge" do
                indices_in =  [ 'logstash-2013.11.02', 'logstash-2013.11.03',
                                'logstash-2013.11.04', 'logstash-2013.11.05',
                                'logstash-2013.11.06', 'logstash-2013.11.07',
                                'logstash-2013.11.08', 'logstash-2013.11.09' ]

                indices_out = [ 'logstash-2013.11.02', 'logstash-2013.11.03',
                                'logstash-2013.11.04', 'logstash-2013.11.05' ]

                @brush.purgeable_indices(4, indices_in,
                    'logstash-%Y.%m.%d', @testtime).should eql indices_out
            end
        end

        context "non-default index_format" do
            it "returns logstash indices to purge" do
                indices_in =  [ 'foo-11.02_bar', 'foo-11.03_bar',
                                'foo-11.04_bar', 'foo-11.05_bar',
                                'foo-11.06_bar', 'foo-11.07_bar',
                                'foo-11.08_bar', 'foo-11.09_bar' ]

                indices_out = [ 'foo-11.02_bar', 'foo-11.03_bar',
                                'foo-11.04_bar', 'foo-11.05_bar' ]

                @brush.purgeable_indices(4, indices_in,
                    'foo-%m.%d_bar', @testtime).should eql indices_out
            end
        end
    end
end
