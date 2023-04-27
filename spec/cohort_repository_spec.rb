require_relative 'cohort_repository'

def reset_test_tables
  seed_sql = File.read('spec/seeds_directory.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2_test' })
  connection.exec(seed_sql)
end


RSpec.describe CohortRepository do
  before(:each) do 
    reset_test_tables
  end  

    
end