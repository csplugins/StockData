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
      :ask,
      :ask_size,
      :average_daily_volume,
      :bid,
      :bid_size,
      :book_value,
      :change,
      :change_from_200_day_moving_average,
      :change_from_50_day_moving_average,
      :change_from_52_week_high,
      :change_From_52_week_low,
      :change_in_percent,
      :close,
      :dividend_pay_date,
      :dividend_per_share,
      :dividend_yield,
      :earnings_per_share,
      :ebitda,
      :eps_estimate_current_year,
      :eps_estimate_next_quarter,
      :eps_estimate_next_year,
      :ex_dividend_date,
      :float_shares,
      :high,
      :high_52_weeks,
      :last_trade_date,
      :last_trade_price,
      :last_trade_size,
      :last_trade_time,
      :low,
      :low_52_weeks,
      :market_capitalization,
      :moving_average_200_day,
      :moving_average_50_day,
      :name,
      :notes,
      :one_year_target_price,
      :open,
      :pe_ratio,
      :peg_ratio,
      :percent_change_from_200_day_moving_average,
      :percent_change_from_50_day_moving_average,
      :percent_change_from_52_week_high,
      :percent_change_from_52_week_low,
      :previous_close,
      :price_eps_estimate_current_year,
      :price_eps_Estimate_next_year,
      :price_per_book,
      :price_per_sales,
      :revenue,
      :shares_outstanding,
      :short_ratio,
      :stock_exchange,
      :symbol,
      :volume,
      :weeks_range_52
    ])
    my_method(data, @dataSymbol)
    save_stock_daily(data)

    data = yahoo_client.quotes(yahoo_client.symbols_by_market('us', 'nasdaq'),[
      :ask,
      :ask_size,
      :average_daily_volume,
      :bid,
      :bid_size,
      :book_value,
      :change,
      :change_from_200_day_moving_average,
      :change_from_50_day_moving_average,
      :change_from_52_week_high,
      :change_From_52_week_low,
      :change_in_percent,
      :close,
      :dividend_pay_date,
      :dividend_per_share,
      :dividend_yield,
      :earnings_per_share,
      :ebitda,
      :eps_estimate_current_year,
      :eps_estimate_next_quarter,
      :eps_estimate_next_year,
      :ex_dividend_date,
      :float_shares,
      :high,
      :high_52_weeks,
      :last_trade_date,
      :last_trade_price,
      :last_trade_size,
      :last_trade_time,
      :low,
      :low_52_weeks,
      :market_capitalization,
      :moving_average_200_day,
      :moving_average_50_day,
      :name,
      :notes,
      :one_year_target_price,
      :open,
      :pe_ratio,
      :peg_ratio,
      :percent_change_from_200_day_moving_average,
      :percent_change_from_50_day_moving_average,
      :percent_change_from_52_week_high,
      :percent_change_from_52_week_low,
      :previous_close,
      :price_eps_estimate_current_year,
      :price_eps_Estimate_next_year,
      :price_per_book,
      :price_per_sales,
      :revenue,
      :shares_outstanding,
      :short_ratio,
      :stock_exchange,
      :symbol,
      :volume,
      :weeks_range_52
    ])
    my_method(data, @dataSymbol)
    save_stock_daily(data)

    data = yahoo_client.quotes(yahoo_client.symbols_by_market('us', 'amex'),[
      :ask,
      :ask_size,
      :average_daily_volume,
      :bid,
      :bid_size,
      :book_value,
      :change,
      :change_from_200_day_moving_average,
      :change_from_50_day_moving_average,
      :change_from_52_week_high,
      :change_From_52_week_low,
      :change_in_percent,
      :close,
      :dividend_pay_date,
      :dividend_per_share,
      :dividend_yield,
      :earnings_per_share,
      :ebitda,
      :eps_estimate_current_year,
      :eps_estimate_next_quarter,
      :eps_estimate_next_year,
      :ex_dividend_date,
      :float_shares,
      :high,
      :high_52_weeks,
      :last_trade_date,
      :last_trade_price,
      :last_trade_size,
      :last_trade_time,
      :low,
      :low_52_weeks,
      :market_capitalization,
      :moving_average_200_day,
      :moving_average_50_day,
      :name,
      :notes,
      :one_year_target_price,
      :open,
      :pe_ratio,
      :peg_ratio,
      :percent_change_from_200_day_moving_average,
      :percent_change_from_50_day_moving_average,
      :percent_change_from_52_week_high,
      :percent_change_from_52_week_low,
      :previous_close,
      :price_eps_estimate_current_year,
      :price_eps_Estimate_next_year,
      :price_per_book,
      :price_per_sales,
      :revenue,
      :shares_outstanding,
      :short_ratio,
      :stock_exchange,
      :symbol,
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
    date = (Time.new - 0).strftime("%Y-%m-%d")#86400

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
