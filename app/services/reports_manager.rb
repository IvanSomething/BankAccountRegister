class ReportsManager
    DEPOSIT_REPORT_COLUMNS = %i[currency amount user].freeze
    DEPOSIT_REPORT_COLUMNS_SQL = ['accounts.currency', 'amount', 'users.last_name'].freeze
    MEASURES_REPORT_COLUMNS = %i[avg max min tag].freeze
    MEASURES_REPORT_COLUMNS_SQL = [
      Arel.sql('avg(transactions.amount)'),
      Arel.sql('max(transactions.amount)'),
      Arel.sql('min(transactions.amount)'),
      'tags.name'
    ].freeze
    TOTAL_AMOUNT_REPORT_COLUMNS = %i[currency amount].freeze
  
    attr_reader :params
  
    def initialize(params)
      @params = params
    end

    private

  def deposits_report
    scoped_transactions
      .where(deposit: true)
      .pluck(DEPOSIT_REPORT_COLUMNS_SQL)
      .map { |row| DEPOSIT_REPORT_COLUMNS.zip(row).to_h }
      .group_by { |row| row.delete(:currency) }
  end

  def measures_report
    scoped_transactions
      .group('tags.name')
      .pluck(*MEASURES_REPORT_COLUMNS_SQL)
      .map { |row| MEASURES_REPORT_COLUMNS.zip(row).to_h }
      .group_by { |row| row.delete(:tag) }
  end
end