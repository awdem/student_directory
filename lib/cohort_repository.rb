require 'cohort'


class CohortRepository
  def all
    sql = "SELECT * FROM cohorts;"
    results_set = DatabaseConnection.exec_params(sql, [])

    cohorts = []
    results_set.each do |record|
      cohort = Cohort.new
      cohort.id = record["id"]
      cohort.cohort_name = record["cohort_name"]
      cohort.starting_date = record["starting_date"]
      cohorts << cohort
    end
    return cohorts
  end

  def find_by_id

  end

  def find_with_students

  end  

  def create

  end

  def delete

  end

end