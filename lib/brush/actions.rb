class Brush
    module Actions
        def purge_days(keep_days, uri)
            if keep_days == 0 then
                epoch_end = Time.now().to_i * 1000
            else
                epoch_end = calculate_epochms(keep_days, 'days')
            end

            query_results = search_timestamp(uri, 0, epoch_end)

            puts "Cleaning elasticsearch, leaving #{keep_days} days of history" unless options[:silent]
            puts "Deleting #{query_results['hits']['total']} entries" unless options[:silent]

            if options[:yes]
                delete_indices(uri, purgeable_indices(keep_days.to_i, get_indices(uri).sort))
            else
                if ask_confirmation then delete_indices(uri, purgeable_indices(keep_days.to_i, get_indices(uri).sort)) end
            end
        end

        def purge_hours(keep_hours, uri)
            if keep_hours == 0 then
                epoch_end = Time.now().to_i * 1000
            else
                epoch_end = calculate_epochms(keep_hours, 'hours')
            end

            query_results = search_timestamp(uri, 0, epoch_end)

            puts "Cleaning elasticsearch, leaving #{keep_hours} hours of history" unless options[:silent]
            puts "Deleting #{query_results['hits']['total']} entries" unless options[:silent]

            if options[:yes]
                delete_timestamp(uri, 0, epoch_end)
            else
                if ask_confirmation then delete_timestamp(uri, 0, epoch_end) end
            end
        end

        def ask_confirmation
            print "Enter 'yes' to confirm: "
            if STDIN.gets.chomp == 'yes' then
                return true
            else
                return false
            end
        end
    end
end
