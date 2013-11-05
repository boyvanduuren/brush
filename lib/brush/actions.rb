require 'httparty'
require 'multi_json'

class Brush
    module HTTP
        include HTTParty
    end
    module Actions

        def search_timestamp(uri, epoch_start, epoch_end)
            Brush::HTTP.base_uri uri

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

            response = Brush::HTTP.get('/_search', { :body => payload })
            hash = MultiJson.load(response.body)

            puts "Query returns #{hash["hits"]["total"]} hits"
        end

        def delete_timestamp(uri, epoch_start, epoch_end)
            Brush::HTTP.base_uri uri

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

            response = Brush::HTTP.delete('/_all/_query', { :body => payload })
            hash = MultiJson.load(response.body)

            if hash["ok"] then puts "Succes!" else puts "Fail!" end
        end
    end
end
