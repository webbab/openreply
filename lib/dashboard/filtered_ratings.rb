module Dashboard
  class FilteredRatings
    attr_accessor :ratings, :ratings_older, :filter

    # @param [Customer] customer
    # @param [Employee] employee
    # @param [Symbol] interval - can be: :week, :month, :year, :all
    # @param [String] from
    # @param [String] to
    def initialize customer, employee, interval, from, to
      @ratings = Rating.order(:created_at)
      @ratings = @ratings.filter_by_employee(employee) if employee && employee
      @ratings = @ratings.filter_by_customer(customer) if customer && customer

      if from && !from.blank? && to && !to.blank?
        from = Date.parse from.to_s
        to = Date.parse to.to_s
      else
        from = Date.parse Statistics::Period.period_to_start_date(interval)
        to = Date.current
      end

      @ratings_older = @ratings
      @ratings = @ratings.where(created_at: (from...to+1))

      interval_length = (to-from).to_i
      @ratings_older = @ratings_older.where(created_at: (from - interval_length.days)...from)

      @filter = Filter.new(customer, employee, interval, from, to)
    end
  end
end
