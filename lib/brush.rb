require 'thor'

class Brush < Thor
    autoload :Actions, 'brush/actions'
    autoload :Timecalc, 'brush/time'
    autoload :Elasticsearch, 'brush/elasticsearch'

    include Brush::Actions
    include Brush::Timecalc
    include Brush::Elasticsearch

    desc "version", "show the version of brush"
    def version
        puts "brush v0.01"
    end

    desc "hours N <host>:<port>", "clean the elasticsearch backend, leaving N hours"
    long_desc <<-LONGDESC
        `hours N` will clean the elasticsearch backend, leaving N hours of logging intact

        sample usage:
        \x5brush hours 16 eshost:9200
    LONGDESC
    def hours(keep_hours, uri)
        purge_hours(keep_hours, uri)
    end

    desc "days N <host>:<port>", "clean the elasticsearch backend, leaving N days"
    long_desc <<-LONGDESC
        `days N` will clean the elasticsearch backend, leaving N days of logging intact

        sample usage:
        \x5brush days 7 eshost:9200
    LONGDESC
    def days(keep_days, uri)
        purge_days(keep_days, uri)
    end

    desc "space N <host>:<port>", "clean the elasticsearch backend, leaving N of space"
    long_desc <<-LONGDESC
        `space N` will clean the elasticsearch backend, leaving N of space left.

        N may be defined as:

            K for kilobytes
            \x5M for megabytes
            \x5G for gigabytes

        sample usage:
        \x5brush space 10G eshost:9200
    LONGDESC
    def space(keep_space, es_cluster)
        puts "Cleaning the backend on #{es_cluster}, leaving #{keep_space} of space."
    end
end
