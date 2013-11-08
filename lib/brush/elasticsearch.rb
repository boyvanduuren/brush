require 'httparty'
require 'multi_json'

class Brush
    module HTTP
        include HTTParty
    end
    module Elasticsearch
        def search_timestamp(uri, epoch_start, epoch_end)
            self.class::HTTP.base_uri uri

            query = {
                        :query => {
                            :filtered => {
                                :query => {
                                    :query_string => {
                                        :query => "*"
                                    }
                                },
                                :filter => {
                                    :range => {
                                        :@timestamp => {
                                            :from => "#{epoch_start}",
                                            :to => "#{epoch_end}"
                                        }
                                    }
                                }
                            }
                        }
            }
            payload = MultiJson.dump(query)

            response = self.class::HTTP.get('/_search', { :body => payload })
            hash = MultiJson.load(response.body)

            return hash
        end

        def delete_timestamp(uri, epoch_start, epoch_end)
            self.class::HTTP.base_uri uri

            query = {
                        :filtered => {
                            :query => {
                                :query_string => {
                                    :query => "*"
                                }
                            },
                            :filter => {
                                :range => {
                                    :@timestamp => {
                                        :from => "#{epoch_start}",
                                        :to => "#{epoch_end}"
                                    }
                                }
                            }
                        }
            }
            payload = MultiJson.dump(query)

            response = self.class::HTTP.delete('/_all/_query', { :body => payload })
            hash = MultiJson.load(response.body)

            return hash
        end

        def get_indices(uri)
            self.class::HTTP.base_uri uri

            response = self.class::HTTP.get('/_aliases')
            hash = MultiJson.load(response.body)

            return hash.keys
        end

        def delete_indices(uri, indices)
            self.class::HTTP.base_uri uri

            responses = Array.new

            indices.each do |index|
                response = self.class::HTTP.delete("/#{index}")
                responses << MultiJson.load(response.body)
            end

            return responses
        end
    end
end
