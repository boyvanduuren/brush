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
    end
end
