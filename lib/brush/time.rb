class Brush
    module Timecalc
        def calculate_epochms(amount, unit)
            amount = amount.to_i
            now = Time.now().to_i * 1000

            case unit
                when 'hours'
                    return now - (amount * (60 ** 2) * 1000)
                when 'days'
                    return now - (amount * 24 * (60 ** 2) * 1000)
            end
        end
    end
end
