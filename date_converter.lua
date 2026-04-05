local years = require("BSDate")
local function convert_to_bs(given_year, given_month, given_day)
    local reference = os.time { day = given_day, year = given_year, month = given_month }
    local daysfrom = os.difftime(reference, os.time { year = 1918, month = 4, day = 13 }) /
        (24 * 60 * 60) -- seconds in a day
    local remaining_days = math.floor(daysfrom)
    for year = 1975, 2099 do
        local month_list = years[year]
        local days_in_the_year = month_list[#month_list]
        if remaining_days >= days_in_the_year then
            remaining_days = remaining_days - days_in_the_year
        else
            for month = 1, 12 do
                local days_in_month = years[year][month]
                if remaining_days >= days_in_month then
                    remaining_days = remaining_days - days_in_month
                else
                    return { year = year, month = month, day = remaining_days + 2 }
                end
            end
        end
    end
end
local english_date = os.date("*t")
local year = convert_to_bs(english_date.year, english_date.month, english_date.day)
local nepali_months = {
    "Baisakh", "Jestha", "Asar", "Shrawan", "Bhadra", "Asoj", "Kartik", "Mangsir", "Poush", "Magh", "Falgun", "Chaitra"
}
return { month = nepali_months[year.month], year = year.year, day = year.day }
