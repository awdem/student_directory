require 'cohort'
require 'student'

class CohortRepository
  def all
    sql = "SELECT * FROM cohorts;"
    results_set = DatabaseConnection.exec_params(sql, [])

    cohorts = []
    results_set.each do |results|
      cohort = Cohort.new
      cohort.id = results["id"]
      cohort.cohort_name = results["cohort_name"]
      cohort.starting_date = results["starting_date"]
      cohorts << cohort
    end
    return cohorts
  end

  def find_by_id(id)
    sql = 'SELECT * FROM cohorts WHERE id = $1'
    results = DatabaseConnection.exec_params(sql, [id]).first

    cohort = Cohort.new
    cohort.id = results['id']    
    cohort.cohort_name = results['cohort_name']    
    cohort.starting_date = results['starting_date'] 
    
    cohort
  end

  def find_with_students(id)
    sql = 'SELECT cohorts.id AS cohort_id,
                  cohort_name,
                  starting_date,
                  students.id AS student_id, 
                  student_name
                  FROM students
                  JOIN cohorts
                  ON students.cohort_id = cohorts.id
                  WHERE cohorts.id = $1'
    results = DatabaseConnection.exec_params(sql, [id])

    cohort = Cohort.new
    cohort.id = results.first['cohort_id']
    cohort.cohort_name = results.first['cohort_name']
    cohort.starting_date = results.first['starting_date']
    
    results.each do |record|
      student = Student.new
      student.id = record["student_id"]
      student.student_name = record["student_name"]
      student.cohort_id = record["cohort_id"]
      cohort.students << student
    end

    cohort
  end  

  def create

  end

  def delete

  end

end