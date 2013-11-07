class Brush
    module Actions
        def purge_days(keep_days, uri)
            if keep_days == 0 then
                epoch_end = Time.now().to_i * 1000
            else
                epoch_end = calculate_epochms(keep_days, 'days')
            end

            query_results = search_timestamp(uri, 0, epoch_end)

            puts "Cleaning elasticsearch, leaving #{keep_days} days of history"
            puts "Deleting #{query_results['hits']['total']} entries"

            if ask_confirmation then delete_timestamp(uri, 0, epoch_end) end
        end

        def purge_hours(keep_hours, uri)
            if keep_hours == 0 then
                epoch_end = Time.now().to_i * 1000
            else
                epoch_end = calculate_epochms(keep_hours, 'hours')
            end

            query_results = search_timestamp(uri, 0, epoch_end)

            puts "Cleaning elasticsearch, leaving #{keep_hours} hours of history"
            puts "Deleting #{query_results['hits']['total']} entries"

            if ask_confirmation then delete_timestamp(uri, 0, epoch_end) end
        end

        def ask_confirmation
            print "Press 'Y' to confirm: "
            if STDIN.gets.chomp == 'Y' then
                return true
            else
                return false
            end
        end
    end
end
