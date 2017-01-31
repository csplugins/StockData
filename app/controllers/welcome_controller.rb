class WelcomeController < ApplicationController
  def index
  end

  def search
    if params[:mktCap].present? == false
      params[:mktCap] = 1000000000
    end
    if params[:dividend].present? == false
      params[:dividend] = 2.5
    end
    if params[:lowPercent].present? == false
      params[:lowPercent] = 20
    end

    require 'fileutils'
    directory = Dir.pwd + "/Stocks/"

    dirname = File.dirname(directory)
    Dir.mkdir(directory) unless File.exists?(directory)

    yahoo_client = YahooFinance::Client.new
    @dataSymbol = []

    data = yahoo_client.quotes(yahoo_client.symbols_by_market('us', 'nyse'),[
      :after_hours_change_real_time,
      :annualized_gain,
      :ask,
      :ask_real_time,
      :ask_size,
      :average_daily_volume,
      :bid,
      :bid_real_time,
      :bid_size,
      :book_value,
      :change,
      :change_and_percent_change,
      :change_from_200_day_moving_average,
      :change_from_50_day_moving_average,
      :change_from_52_week_high,
      :change_From_52_week_low,
      :change_in_percent,
      :change_percent_realtime,
      :change_real_time,
      :close,
      :comission,
      :day_value_change,
      :day_value_change_realtime,
      :days_range,
      :days_range_realtime,
      :dividend_pay_date,
      :dividend_per_share,
      :dividend_yield,
      :earnings_per_share,
      :ebitda,
      :eps_estimate_current_year,
      :eps_estimate_next_quarter,
      :eps_estimate_next_year,
      :error_indicator,
      :ex_dividend_date,
      :float_shares,
      :high,
      :high_52_weeks,
      :high_limit,
      :holdings_gain,
      :holdings_gain_percent,
      :holdings_gain_percent_realtime,
      :holdings_gain_realtime,
      :holdings_value,
      :holdings_value_realtime,
      :last_trade_date,
      :last_trade_price,
      :last_trade_realtime_withtime,
      :last_trade_size,
      :last_trade_time,
      :last_trade_with_time,
      :low,
      :low_52_weeks,
      :low_limit,
      :market_cap_realtime,
      :market_capitalization,
      :more_info,
      :moving_average_200_day,
      :moving_average_50_day,
      :name,
      :notes,
      :one_year_target_price,
      :open,
      :order_book,
      :pe_ratio,
      :pe_ratio_realtime,
      :peg_ratio,
      :percent_change_from_200_day_moving_average,
      :percent_change_from_50_day_moving_average,
      :percent_change_from_52_week_high,
      :percent_change_from_52_week_low,
      :previous_close,
      :price_eps_estimate_current_year,
      :price_eps_Estimate_next_year,
      :price_paid,
      :price_per_book,
      :price_per_sales,
      :revenue,
      :shares_outstanding,
      :shares_owned,
      :short_ratio,
      :stock_exchange,
      :symbol,
      :ticker_trend,
      :trade_date,
      :trade_links,
      :volume,
      :weeks_range_52
    ])
    my_method(data, @dataSymbol)
    save_stock_daily(data)

    data = yahoo_client.quotes(yahoo_client.symbols_by_market('us', 'nasdaq'),[
      :after_hours_change_real_time,
      :annualized_gain,
      :ask,
      :ask_real_time,
      :ask_size,
      :average_daily_volume,
      :bid,
      :bid_real_time,
      :bid_size,
      :book_value,
      :change,
      :change_and_percent_change,
      :change_from_200_day_moving_average,
      :change_from_50_day_moving_average,
      :change_from_52_week_high,
      :change_From_52_week_low,
      :change_in_percent,
      :change_percent_realtime,
      :change_real_time,
      :close,
      :comission,
      :day_value_change,
      :day_value_change_realtime,
      :days_range,
      :days_range_realtime,
      :dividend_pay_date,
      :dividend_per_share,
      :dividend_yield,
      :earnings_per_share,
      :ebitda,
      :eps_estimate_current_year,
      :eps_estimate_next_quarter,
      :eps_estimate_next_year,
      :error_indicator,
      :ex_dividend_date,
      :float_shares,
      :high,
      :high_52_weeks,
      :high_limit,
      :holdings_gain,
      :holdings_gain_percent,
      :holdings_gain_percent_realtime,
      :holdings_gain_realtime,
      :holdings_value,
      :holdings_value_realtime,
      :last_trade_date,
      :last_trade_price,
      :last_trade_realtime_withtime,
      :last_trade_size,
      :last_trade_time,
      :last_trade_with_time,
      :low,
      :low_52_weeks,
      :low_limit,
      :market_cap_realtime,
      :market_capitalization,
      :more_info,
      :moving_average_200_day,
      :moving_average_50_day,
      :name,
      :notes,
      :one_year_target_price,
      :open,
      :order_book,
      :pe_ratio,
      :pe_ratio_realtime,
      :peg_ratio,
      :percent_change_from_200_day_moving_average,
      :percent_change_from_50_day_moving_average,
      :percent_change_from_52_week_high,
      :percent_change_from_52_week_low,
      :previous_close,
      :price_eps_estimate_current_year,
      :price_eps_Estimate_next_year,
      :price_paid,
      :price_per_book,
      :price_per_sales,
      :revenue,
      :shares_outstanding,
      :shares_owned,
      :short_ratio,
      :stock_exchange,
      :symbol,
      :ticker_trend,
      :trade_date,
      :trade_links,
      :volume,
      :weeks_range_52
    ])
    my_method(data, @dataSymbol)
    save_stock_daily(data)

    data = yahoo_client.quotes(yahoo_client.symbols_by_market('us', 'amex'),[
      :after_hours_change_real_time,
      :annualized_gain,
      :ask,
      :ask_real_time,
      :ask_size,
      :average_daily_volume,
      :bid,
      :bid_real_time,
      :bid_size,
      :book_value,
      :change,
      :change_and_percent_change,
      :change_from_200_day_moving_average,
      :change_from_50_day_moving_average,
      :change_from_52_week_high,
      :change_From_52_week_low,
      :change_in_percent,
      :change_percent_realtime,
      :change_real_time,
      :close,
      :comission,
      :day_value_change,
      :day_value_change_realtime,
      :days_range,
      :days_range_realtime,
      :dividend_pay_date,
      :dividend_per_share,
      :dividend_yield,
      :earnings_per_share,
      :ebitda,
      :eps_estimate_current_year,
      :eps_estimate_next_quarter,
      :eps_estimate_next_year,
      :error_indicator,
      :ex_dividend_date,
      :float_shares,
      :high,
      :high_52_weeks,
      :high_limit,
      :holdings_gain,
      :holdings_gain_percent,
      :holdings_gain_percent_realtime,
      :holdings_gain_realtime,
      :holdings_value,
      :holdings_value_realtime,
      :last_trade_date,
      :last_trade_price,
      :last_trade_realtime_withtime,
      :last_trade_size,
      :last_trade_time,
      :last_trade_with_time,
      :low,
      :low_52_weeks,
      :low_limit,
      :market_cap_realtime,
      :market_capitalization,
      :more_info,
      :moving_average_200_day,
      :moving_average_50_day,
      :name,
      :notes,
      :one_year_target_price,
      :open,
      :order_book,
      :pe_ratio,
      :pe_ratio_realtime,
      :peg_ratio,
      :percent_change_from_200_day_moving_average,
      :percent_change_from_50_day_moving_average,
      :percent_change_from_52_week_high,
      :percent_change_from_52_week_low,
      :previous_close,
      :price_eps_estimate_current_year,
      :price_eps_Estimate_next_year,
      :price_paid,
      :price_per_book,
      :price_per_sales,
      :revenue,
      :shares_outstanding,
      :shares_owned,
      :short_ratio,
      :stock_exchange,
      :symbol,
      :ticker_trend,
      :trade_date,
      :trade_links,
      :volume,
      :weeks_range_52
    ])
    my_method(data, @dataSymbol)
    save_stock_daily(data)

  end

  private
  def my_method(data, dataSymbol)
    for item in data
      next if item.market_capitalization == "N/A"
      next if item.dividend_yield == "N/A"
      next if item.pe_ratio == "N/A"
      #next if item.market_capitalization < params[:mktCap]
      #puts item.market_capitalization
      next if item.market_capitalization.to_s !~ /B/
      next if item.dividend_yield.to_f < params[:dividend].to_f
      yearLow = item.low_52_weeks.to_f
      yearHigh = item.high_52_weeks.to_f
      percent = params[:lowPercent].to_f * 0.01
      tenPercentLow = yearHigh - yearLow
      tenPercentLow *= percent.to_f
      tenPercentLow += yearLow
      next if item.previous_close.to_f > tenPercentLow

      @dataSymbol.push(item)
    end
  end

  private
  def save_stock_daily(data)
    require 'fileutils'
    date = Time.new.strftime("%Y-%m-%d")

    for item in data
      directory = Dir.pwd + "/Stocks/" + item.symbol + "/"
      dirname = File.dirname(directory)
      Dir.mkdir(directory) unless File.exists?(directory)
      output = File.open(directory + date,"w")

      temp = item.to_s
      temp = temp[13..-2]
      temp = temp.gsub(/, /, "\n")
      temp = temp + "\n"
      output << temp

      output.close
    end
  end
end
