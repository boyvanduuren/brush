class Brush
    module Timecalc
        def calculate_epochms(amount, unit, timepoint = Time.now())
            seconds_per_day = 24 * 60 * 60
            amount = amount.to_i
            now = timepoint.to_i * 1000

            case unit
                when 'hours'
                    return now - (amount * (60 * 60) * 1000)
                when 'days'
                    return now - (amount * seconds_per_day * 1000)
            end
        end

        def calculate_enddate(days_to_keep, timepoint = Time.now())
            seconds_per_day = 24 * 60 * 60
            date_format = "%Y.%m.%d"

            enddate =  timepoint
            enddate -= days_to_keep.to_i * seconds_per_day

            return enddate.strftime(date_format)
        end

        def purgeable_indices(days_to_keep, indices, index_format, timepoint = Time.now())
            seconds_per_day = 24 * 60 * 60

            today = timepoint
            enddate = today - (days_to_keep-= 1) * seconds_per_day
            purgedate = enddate

            while purgedate <= today
                indices.delete(purgedate.strftime(index_format))
                purgedate += seconds_per_day
            end

            return indices
        end
    end
end
