require 'thor'

class Brush < Thor
    autoload :Actions, 'brush/actions'
    autoload :Timecalc, 'brush/time'
    autoload :Elasticsearch, 'brush/elasticsearch'

    include Brush::Actions
    include Brush::Timecalc
    include Brush::Elasticsearch

    class_option :silent, :type => :boolean
    class_option :yes, :type => :boolean

    desc "hours N <host>:<port>", "clean the elasticsearch backend, leaving N hours"
    def hours(keep_hours, uri)
        purge_hours(keep_hours, uri)
    end

    desc "days N <host>:<port> [index_format]",
        "clean the elasticsearch backend, leaving N days. index_format is in strftime"
    def days(keep_days, uri, index_format='logstash-%Y.%m.%d')
        purge_days(keep_days, uri, index_format)
    end

    desc "space N <host>:<port>", "clean the elasticsearch backend, leaving N of space"
    def space(keep_space, uri)
        puts "Not implemented yet"
    end
end
