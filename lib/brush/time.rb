class Brush
    module Timecalc
        def calculate_epochms(amount, unit)
            amount = amount.to_i
            now = Time.now().to_i * 1000

            case unit
                when 'hours'
                    return now - (amount * (60 * 60) * 1000)
                when 'days'
                    return now - (amount * 24 * (60 * 60) * 1000)
            end
        end

        def calculate_enddate(days_to_keep)
            seconds_per_day = 24 * 60 * 60
            enddate =  Time.now()
            enddate -= days_to_keep.to_i * seconds_per_day

            return enddate.strftime("%Y.%m.%d")
        end

        def purgeable_indices(days_to_keep, indices)
            seconds_per_day = 24 * 60 * 60
            date_format = "%Y.%m.%d"

            today = Time.now()
            enddate = today - (days_to_keep-= 1) * seconds_per_day
            purgedate = enddate

            while purgedate <= today
                indices.delete("logstash-#{purgedate.strftime(date_format)}")
                purgedate += seconds_per_day
            end

            return indices
        end
    end
end
